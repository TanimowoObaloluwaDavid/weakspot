import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../models/mastery_math.dart';
import '../services/mastery_service.dart';

/// Serves questions, records answers, and reports where the student is weak.
///
/// No AI is involved in any of this. Every call is deterministic.
class QuizEndpoint extends Endpoint {
  MasteryService get _mastery => MasteryService(Random());

  /// The next weighted round. Weak topics come back more often.
  Future<List<Question>> next(Session session, {int count = 5}) {
    return _mastery.nextQuestions(session, count: count);
  }

  Future<AnswerResult> submit(
    Session session, {
    required int questionId,
    required int selectedIndex,
  }) async {
    final question = await Question.db.findById(session, questionId);
    if (question == null) {
      throw Exception('That question no longer exists. Rebuild the syllabus.');
    }

    final isCorrect = selectedIndex == question.correctIndex;

    await Attempt.db.insertRow(
      session,
      Attempt(
        questionId: question.id!,
        topicId: question.topicId,
        isCorrect: isCorrect,
        selectedIndex: selectedIndex,
        answeredAt: DateTime.now(),
      ),
    );

    final mastery = await _mastery.computeMastery(session);

    TopicMastery? thisTopic;
    for (final m in mastery) {
      if (m.topicId == question.topicId) {
        thisTopic = m;
        break;
      }
    }

    return AnswerResult(
      isCorrect: isCorrect,
      correctIndex: question.correctIndex,
      explanation: question.explanation,
      topicName: thisTopic?.name ?? 'Unknown topic',
      topicPercent: thisTopic?.percent ?? 0,
      isTopicWeak: thisTopic?.isWeak ?? false,
    );
  }

  Future<MasteryReport> report(Session session) async {
    final mastery = await _mastery.computeMastery(session);

    final attempted = mastery.fold<int>(0, (s, m) => s + m.attempted);
    final correct = mastery.fold<int>(0, (s, m) => s + m.correct);

    return MasteryReport(
      topics: mastery,
      totalAttempted: attempted,
      totalCorrect: correct,
      weakCount: mastery.where((m) => m.isWeak).length,
    );
  }
}
