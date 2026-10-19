import 'ai_client.dart';
import 'syllabus_models.dart';

/// The single place AI is used in WeakSpot.
///
/// AI's entire job is turning a syllabus into topics and questions. Everything
/// that decides what the student sees next -- mastery, weighting, re-queueing --
/// is deterministic code in MasteryService, with no model involved.
class SyllabusAi {
  SyllabusAi(this.client);

  final AiClient client;

  Future<GeneratedSyllabus> generate({
    required String syllabus,
    required int questionsPerTopic,
  }) async {
    final raw = await client.complete(
      prompt: _buildPrompt(syllabus, questionsPerTopic),
      schema: responseSchema,
      temperature: 0.4,
    );

    return GeneratedSyllabus.fromJson(
      AiClient.extractJson(raw),
      fallbackSubject: _guessSubject(syllabus),
    );
  }

  String get providerName => client.providerName;

  String _buildPrompt(String syllabus, int questionsPerTopic) => '''
You are an exam question writer. Read the syllabus below and produce practice
questions for a student who is revising for an exam.

Syllabus:
"""
$syllabus
"""

Rules:
- Split the syllabus into between 3 and 8 topics. Topics must come only from the
  syllabus text. Do not invent topics that are not listed.
- Generate exactly $questionsPerTopic multiple-choice questions per topic.
- Each question must have exactly 4 options.
- Distractors must be plausible and specific to the topic. Never use filler like
  "All of the above" or "None of the above".
- The explanation must say WHY the correct option is correct, in one sentence.
- If the syllabus mentions a specific course, module or subject name, use it.
''';

  /// Shared by both providers. Groq and Gemini accept the same JSON Schema
  /// shape here, which is why the two clients can be swapped freely.
  static const Map<String, dynamic> responseSchema = {
    'type': 'object',
    'properties': {
      'subject': {'type': 'string'},
      'topics': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'name': {'type': 'string'},
            'questions': {
              'type': 'array',
              'items': {
                'type': 'object',
                'properties': {
                  'prompt': {'type': 'string'},
                  'options': {
                    'type': 'array',
                    'items': {'type': 'string'},
                  },
                  'correctIndex': {'type': 'integer'},
                  'explanation': {'type': 'string'},
                },
                'required': ['prompt', 'options', 'correctIndex', 'explanation'],
              },
            },
          },
          'required': ['name', 'questions'],
        },
      },
    },
    'required': ['subject', 'topics'],
  };

  static String _guessSubject(String syllabus) {
    final firstLine = syllabus
        .split('\n')
        .map((l) => l.trim())
        .firstWhere((l) => l.isNotEmpty, orElse: () => 'Syllabus');
    return firstLine.length <= 60 ? firstLine : '${firstLine.substring(0, 57)}...';
  }
}