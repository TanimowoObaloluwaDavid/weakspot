import 'package:test/test.dart';
import 'package:weakspot_server/src/ai/ai_client.dart';
import 'package:weakspot_server/src/ai/ai_exceptions.dart';
import 'package:weakspot_server/src/ai/gemini_client.dart';
import 'package:weakspot_server/src/ai/groq_client.dart';
import 'package:weakspot_server/src/ai/syllabus_models.dart';

void main() {
  group('provider selection', () {
    test('groq is the default when nothing is configured', () {
      final client = AiClientFactory.create(
        provider: '',
        geminiKey: '',
        groqKey: '',
      );
      expect(client, isA<GroqClient>());
      expect(client.providerName, 'Groq');
    });

    test('gemini is used when asked for', () {
      final client = AiClientFactory.create(
        provider: 'gemini',
        geminiKey: 'abc',
        groqKey: 'def',
      );
      expect(client, isA<GeminiClient>());
    });

    test('an unknown provider falls back to groq rather than crashing', () {
      final client = AiClientFactory.create(
        provider: 'not-a-real-provider',
        geminiKey: '',
        groqKey: '',
      );
      expect(client, isA<GroqClient>());
    });

    test('model overrides are honoured', () {
      final client = AiClientFactory.create(
        provider: 'groq',
        geminiKey: '',
        groqKey: '',
        groqModel: 'moonshotai/kimi-k2-instruct-0905',
      );
      expect(client.model, 'moonshotai/kimi-k2-instruct-0905');
    });

    test('a blank model override does not blank the model', () {
      final client = AiClientFactory.create(
        provider: 'groq',
        geminiKey: '',
        groqKey: '',
        groqModel: '   ',
      );
      expect(client.model.isNotEmpty, isTrue);
    });
  });

  group('missing keys', () {
    test('groq reports itself when the key is blank', () {
      final client = GroqClient(apiKey: '   ');
      expect(
        () => client.complete(prompt: 'x', schema: const {}),
        throwsA(isA<MissingApiKeyException>()),
      );
    });

    test('the error names the provider and where to fix it', () {
      final message = MissingApiKeyException('Groq').toString();
      expect(message, contains('Groq'));
      expect(message, contains('groqApiKey'));
    });
  });

  group('json extraction', () {
    test('reads plain json', () {
      expect(AiClient.extractJson('{"a":1}'), '{"a":1}');
    });

    test('reads json wrapped in a code fence', () {
      const raw = 'Here you go:\n```json\n{"a":1}\n```\nHope that helps.';
      expect(AiClient.extractJson(raw), '{"a":1}');
    });

    test('does not stop at a brace inside a string', () {
      const raw = '{"note":"use {curly} braces","b":2}';
      expect(AiClient.extractJson(raw), raw);
    });

    test('handles escaped quotes inside strings', () {
      const raw = r'{"note":"he said \"hi\"","b":2}';
      expect(AiClient.extractJson(raw), raw);
    });

    test('throws when there is no object at all', () {
      expect(
        () => AiClient.extractJson('sorry, I cannot help'),
        throwsA(isA<AiResponseFormatException>()),
      );
    });

    test('throws on unbalanced json', () {
      expect(
        () => AiClient.extractJson('{"a":1'),
        throwsA(isA<AiResponseFormatException>()),
      );
    });
  });

  group('syllabus parsing', () {
    String goodResponse() => '''
{
  "subject": "Intro to Computer Networks",
  "topics": [
    {
      "name": "TCP/IP",
      "questions": [
        {
          "prompt": "Which layer does TCP sit at?",
          "options": ["Network", "Transport", "Data link", "Session"],
          "correctIndex": 1,
          "explanation": "TCP is a transport layer protocol."
        }
      ]
    }
  ]
}
''';

    test('parses a well formed response', () {
      final syllabus =
          GeneratedSyllabus.fromJson(AiClient.extractJson(goodResponse()));
      expect(syllabus.subject, 'Intro to Computer Networks');
      expect(syllabus.topics.length, 1);
      expect(syllabus.topics.first.name, 'TCP/IP');
      expect(syllabus.topics.first.questions.single.correctIndex, 1);
    });

    test('drops questions that do not have exactly four options', () {
      // A malformed option list would silently shift correctIndex, so those
      // questions are rejected rather than trusted.
      const raw = '''
{
  "subject": "S",
  "topics": [
    {
      "name": "T",
      "questions": [
        {"prompt":"a","options":["x","y"],"correctIndex":0,"explanation":"e"},
        {"prompt":"b","options":["x","y","z","w"],"correctIndex":3,"explanation":"e"}
      ]
    }
  ]
}
''';
      final syllabus = GeneratedSyllabus.fromJson(raw);
      expect(syllabus.topics.first.questions.length, 1);
      expect(syllabus.topics.first.questions.single.prompt, 'b');
    });

    test('drops a question whose correctIndex is out of range', () {
      const raw = '''
{
  "subject": "S",
  "topics": [
    {
      "name": "T",
      "questions": [
        {"prompt":"a","options":["x","y","z","w"],"correctIndex":9,"explanation":"e"},
        {"prompt":"b","options":["x","y","z","w"],"correctIndex":0,"explanation":"e"}
      ]
    }
  ]
}
''';
      // Only the out-of-range question is dropped; the valid one survives.
      final syllabus = GeneratedSyllabus.fromJson(raw);
      expect(syllabus.topics.first.questions.length, 1);
      expect(syllabus.topics.first.questions.single.prompt, 'b');
    });

    test('falls back to a subject when the model omits one', () {
      const raw = '''
{
  "topics": [
    {"name":"T","questions":[
      {"prompt":"a","options":["x","y","z","w"],"correctIndex":0,"explanation":"e"}
    ]}
  ]
}
''';
      final syllabus = GeneratedSyllabus.fromJson(raw, fallbackSubject: 'Networks');
      expect(syllabus.subject, 'Networks');
    });

    test('throws when no topic survives validation', () {
      const raw = '{"subject":"S","topics":[]}';
      expect(
        () => GeneratedSyllabus.fromJson(raw),
        throwsA(isA<FormatException>()),
      );
    });
  });
}