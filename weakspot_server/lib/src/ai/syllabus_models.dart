import 'dart:convert';

/// Plain data classes for the syllabus the AI returns, plus defensive parsing.
/// Kept separate from the Serverpod models so the AI contract can change
/// without touching the database schema.

class GeneratedQuestion {
  GeneratedQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}

class GeneratedTopic {
  GeneratedTopic({required this.name, required this.questions});

  final String name;
  final List<GeneratedQuestion> questions;
}

class GeneratedSyllabus {
  GeneratedSyllabus({required this.subject, required this.topics});

  final String subject;
  final List<GeneratedTopic> topics;

  factory GeneratedSyllabus.fromJson(
    String rawJson, {
    String fallbackSubject = 'Syllabus',
  }) {
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;

    final rawSubject = (decoded['subject'] as String?)?.trim();
    final subject = (rawSubject != null && rawSubject.isNotEmpty)
        ? rawSubject
        : fallbackSubject;

    final topics = <GeneratedTopic>[];
    final rawTopics = decoded['topics'] as List<dynamic>? ?? const [];

    for (final rawTopic in rawTopics) {
      if (rawTopic is! Map<String, dynamic>) continue;
      final name = (rawTopic['name'] as String?)?.trim() ?? '';
      if (name.isEmpty) continue;

      final questions = <GeneratedQuestion>[];
      final rawQuestions = rawTopic['questions'] as List<dynamic>? ?? const [];

      for (final rawQuestion in rawQuestions) {
        if (rawQuestion is! Map<String, dynamic>) continue;
        final question = _parseQuestion(rawQuestion);
        if (question != null) questions.add(question);
      }

      if (questions.isNotEmpty) {
        topics.add(GeneratedTopic(name: name, questions: questions));
      }
    }

    if (topics.isEmpty) {
      throw const FormatException(
        'No usable topics came back. Try pasting a longer syllabus.',
      );
    }

    return GeneratedSyllabus(subject: subject, topics: topics);
  }

  static GeneratedQuestion? _parseQuestion(Map<String, dynamic> raw) {
    final prompt = (raw['prompt'] as String?)?.trim() ?? '';
    if (prompt.isEmpty) return null;

    final rawOptions = raw['options'] as List<dynamic>? ?? const [];
    final options = rawOptions
        .map((o) => (o as String?)?.trim() ?? '')
        .where((o) => o.isNotEmpty)
        .toList();

    // A malformed option list would silently shift correctIndex, so reject it.
    if (options.length != 4) return null;

    final correctIndex = (raw['correctIndex'] as num?)?.toInt() ?? -1;
    if (correctIndex < 0 || correctIndex >= options.length) return null;

    final explanation = (raw['explanation'] as String?)?.trim() ?? '';

    return GeneratedQuestion(
      prompt: prompt,
      options: options,
      correctIndex: correctIndex,
      explanation: explanation,
    );
  }
}
