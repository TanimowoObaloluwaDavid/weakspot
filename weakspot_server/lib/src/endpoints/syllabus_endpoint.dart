import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../ai/ai_client.dart';
import '../ai/ai_exceptions.dart';
import '../ai/syllabus_ai.dart';
import '../ai/syllabus_models.dart';
import '../generated/protocol.dart';
import '../services/mastery_service.dart';

/// Turns a syllabus into topics and questions, then hands back the first
/// weighted round so the client can go straight into a quiz.
class SyllabusEndpoint extends Endpoint {
  static const int defaultQuestionsPerTopic = 3;

  Future<BuildResult> build(
    Session session, {
    required String syllabus,
    int questionsPerTopic = defaultQuestionsPerTopic,
  }) async {
    final trimmed = syllabus.trim();
    if (trimmed.length < 20) {
      throw Exception(
        'Paste at least a couple of sentences of syllabus so there is something '
        'to build questions from.',
      );
    }

    final ai = SyllabusAi(_resolveClient(session));

    final GeneratedSyllabus generated;
    try {
      generated = await ai.generate(
        syllabus: trimmed,
        questionsPerTopic: questionsPerTopic,
      );
    } on MissingApiKeyException catch (e) {
      throw Exception(e.toString());
    } on AiRequestFailedException catch (e) {
      throw Exception('${e.toString()}\n${e.body}');
    } on AiResponseFormatException catch (e) {
      throw Exception('Could not read the model response. ${e.toString()}');
    } on FormatException catch (e) {
      throw Exception('Could not read the model response. ${e.message}');
    } catch (e) {
      throw Exception('Generation failed: $e');
    }

    // Replace any previous syllabus so two sets never mix.
    await _clearPrevious(session);

    final topics = <Topic>[];
    final questions = <Question>[];
    var topicPosition = 0;

    for (final topicData in generated.topics) {
      final topic = await Topic.db.insertRow(
        session,
        Topic(
          name: topicData.name,
          subject: generated.subject,
          position: topicPosition++,
        ),
      );
      topics.add(topic);

      var questionPosition = 0;
      for (final questionData in topicData.questions) {
        questions.add(
          Question(
            topicId: topic.id!,
            prompt: questionData.prompt,
            options: questionData.options,
            correctIndex: questionData.correctIndex,
            explanation: questionData.explanation,
            position: questionPosition++,
          ),
        );
      }
    }

    if (questions.isNotEmpty) {
      await Question.db.insert(session, questions);
    }

    final firstRound = await MasteryService().nextQuestions(
      session,
      count: questionsPerTopic,
    );

    return BuildResult(
      subject: generated.subject,
      topicCount: topics.length,
      questionCount: questions.length,
      firstRound: firstRound,
    );
  }

  /// Wipes the previous syllabus so two sets never mix. Attempts go first
  /// because they reference both questions and topics. Rows are fetched and
  /// deleted one by one: the dataset is tiny and this runs once per rebuild.
  Future<void> _clearPrevious(Session session) async {
    for (final attempt in await Attempt.db.find(session)) {
      await Attempt.db.deleteRow(session, attempt);
    }
    for (final question in await Question.db.find(session)) {
      await Question.db.deleteRow(session, question);
    }
    for (final topic in await Topic.db.find(session)) {
      await Topic.db.deleteRow(session, topic);
    }
  }

  /// Reads provider and keys from Serverpod passwords first, then the
  /// environment, so CI and Serverpod Cloud can inject secrets without editing
  /// a file.
  AiClient _resolveClient(Session session) {
    String fromConfig(String name) {
      final value = session.passwords[name];
      return (value != null && value.trim().isNotEmpty) ? value.trim() : '';
    }

    String fromEnv(String name) => Platform.environment[name] ?? '';

    String firstConfigured(List<String> names, List<String> envNames) {
      for (final name in names) {
        final value = fromConfig(name);
        if (value.isNotEmpty) return value;
      }
      for (final name in envNames) {
        final value = fromEnv(name);
        if (value.isNotEmpty) return value;
      }
      return '';
    }

    final provider = firstConfigured(
      ['aiProvider'],
      ['AI_PROVIDER'],
    );

    return AiClientFactory.create(
      provider: provider,
      geminiKey: firstConfigured(
        ['geminiApiKey'],
        ['GEMINI_API_KEY'],
      ),
      groqKey: firstConfigured(
        ['groqApiKey'],
        ['GROQ_API_KEY'],
      ),
      geminiModel: fromConfig('geminiModel'),
      groqModel: fromConfig('groqModel'),
    );
  }
}