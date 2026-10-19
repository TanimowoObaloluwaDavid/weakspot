# WeakSpot

**Stop revising everything equally.**

Students spread their revision evenly across every topic, then walk into the
exam weakest in exactly the parts they neglected. WeakSpot finds the topics you
keep getting wrong and pulls them back in until they are solid.

Paste a syllabus, answer questions, and the next round is weighted toward
whatever you are failing. No scheduling algorithm to learn, no manual tagging,
no dashboard to configure.

Built with Flutter and Serverpod for the FlutterBytes x Serverpod Hackathon 2026.

## The idea

Two halves, and only one of them is AI.

**AI does one thing:** turn a syllabus into topics and questions. That is
`SyllabusAi`, and it is the only file in the project that calls a model.

**Everything else is arithmetic:** mastery per topic, weighted selection, weak
topic detection. That is `MasteryService`, and it contains no AI at all.

This split is the point. Remove the AI and you have a static quiz app. Remove
the database and the AI has nothing to adapt to. Both halves are load-bearing,
and the second half is what makes this a product rather than a chatbot.

The weighting:

```
weight = max(1, 100 - mastery_percent)
```

A topic you score 10% on is pulled roughly ten times more often than one you
score 90% on. The floor of 1 matters: unguarded, a topic you always fail would
weight to zero and drop out of rotation entirely, which is exactly backwards.

## Running it

**1. Pick a provider and add your key** — both free tiers:

```yaml
# weakspot_server/config/passwords.yaml, under development:
aiProvider: 'groq'      # or 'gemini'
groqApiKey: 'gsk_...'   # from https://console.groq.com/keys
```

| Provider | Key from | Default model | Notes |
|---|---|---|---|
| **groq** | [console.groq.com/keys](https://console.groq.com/keys) | `llama-3.3-70b-versatile` | Very fast, default here |
| **gemini** | [aistudio.google.com/apikey](https://aistudio.google.com/apikey) | `gemini-2.0-flash` | |

Override the model without touching code: `groqModel:` or `geminiModel:`.

**2. Start the server and the Flutter app together**

```bash
serverpod start
```

Serverpod 4 runs an embedded Postgres locally, so there is nothing else to
install and no Docker needed.

The app has a **sample syllabus** button on the first screen if you want to see
the whole flow without finding a syllabus first.

### Swapping providers

`AiClient` is an interface; `GroqClient` and `GeminiClient` implement it.
`AiClientFactory.create` picks one from config. Both share a single JSON Schema,
so they accept identical payloads and the rest of the app never knows which is
in use. Adding a third provider is a new client plus one `case` in the factory.

Credentials resolve in this order, so nothing is hardcoded:

1. `session.passwords` from `config/passwords.yaml`
2. Environment: `GROQ_API_KEY`, `GEMINI_API_KEY`, `AI_PROVIDER`

## What is deliberately not here

No accounts. No spaced-repetition scheduler beyond simple weighted re-queueing.
No leaderboards. No PDF upload. No spaced calendar.

Scope is the strategy. A small promise kept beats a large promise half met.

## Layout

```
weakspot_server/lib/src/
  ai/
    ai_client.dart         interface + factory that picks the provider
    groq_client.dart       Groq, OpenAI-compatible, json_schema
    gemini_client.dart     Gemini generateContent with responseSchema
    syllabus_ai.dart       builds the prompt, only place AI is used
    syllabus_models.dart   parsing the model's reply defensively
    ai_exceptions.dart     typed failures
  services/
    mastery_service.dart   the engine: mastery, weighting, selection
  models/
    *.spy.yaml             Topic, Question, Attempt + result models
    mastery_math.dart      the scheduling arithmetic, shared logic
  endpoints/
    syllabus_endpoint.dart syllabus text -> topics + questions
    quiz_endpoint.dart     next round, submit, report

weakspot_flutter/lib/
  screens/
    home_screen.dart       entry, routes to syllabus or mastery
    syllabus_screen.dart   paste, generate
    quiz_screen.dart       answer, feedback, explanation
    mastery_screen.dart    the board: weakest first, weak ones in red
```

## Tests

```bash
cd weakspot_server
dart test test/ai_provider_test.dart test/mastery_math_test.dart
```

26 tests. `ai_provider_test.dart` covers provider selection, missing-key
reporting, JSON extraction (code fences, braces inside strings, unbalanced
output) and syllabus validation. `mastery_math_test.dart` pins the weighting
claims.

`test/db_smoke_test.dart` exercises the database round trip but needs the
embedded Postgres harness, which downloads binaries on first run.

## Deploying

```bash
serverpod cloud launch
```

Set `GROQ_API_KEY` (or `GEMINI_API_KEY`) and `AI_PROVIDER` as secrets on the
Cloud project. The server reads config first and falls back to the environment.