import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../models/mastery_math.dart';

/// The part of WeakSpot that decides what the student sees next.
///
/// Deliberately contains no AI. Question generation is AI; the scheduling that
/// makes those questions useful is arithmetic, and it lives here.
class MasteryService {
  MasteryService([Random? random]) : _random = random ?? Random();

  final Random _random;

  static const int weakThreshold = 50;

  /// Mastery for every topic, ordered so the app leads with the topic doing the
  /// most damage: weakest first, never-attempted topics last.
  Future<List<TopicMastery>> computeMastery(Session session) async {
    final topics = await Topic.db.find(session);

    final mastery = <TopicMastery>[];
    for (final topic in topics) {
      final topicId = topic.id!;
      final attempts = await Attempt.db.find(
        session,
        where: (t) => t.topicId.equals(topicId),
        limit: 1000,
      );
      final questions = await Question.db.find(
        session,
        where: (t) => t.topicId.equals(topicId),
        limit: 1000,
      );

      mastery.add(
        TopicMastery(
          topicId: topicId,
          name: topic.name,
          subject: topic.subject,
          attempted: attempts.length,
          correct: attempts.where((a) => a.isCorrect).length,
          questionCount: questions.length,
        ),
      );
    }

    mastery.sort((a, b) {
      if (a.isUntouched && b.isUntouched) return a.name.compareTo(b.name);
      if (a.isUntouched) return 1;
      if (b.isUntouched) return -1;
      return a.ratio.compareTo(b.ratio);
    });

    return mastery;
  }

  /// Picks the next [count] questions, biased toward weak topics.
  ///
  /// Weighted-random rather than round-robin, so repeated sessions on the same
  /// day do not produce an identical order. At most one question per topic per
  /// round, so a round spans topics instead of hammering a single weak one.
  Future<List<Question>> nextQuestions(
    Session session, {
    int count = 5,
    int? topicId,
  }) async {
    final allTopics = await Topic.db.find(session);
    final topicIds = topicId != null
        ? <int>[topicId]
        : allTopics.map((t) => t.id!).toList();

    if (topicIds.isEmpty) return const [];

    final pools = <int, List<Question>>{};
    final weights = <int, double>{};

    for (final id in topicIds) {
      final questions = await Question.db.find(
        session,
        where: (t) => t.topicId.equals(id),
        orderBy: (t) => t.position,
        limit: 500,
      );
      if (questions.isEmpty) continue;
      pools[id] = questions;
      weights[id] = await _weightFor(session, id);
    }

    if (pools.isEmpty) return const [];

    final picked = <Question>[];
    final usedTopics = <int>{};

    for (var i = 0; i < count; i++) {
      var source = pools.entries.where((e) => !usedTopics.contains(e.key)).toList();
      if (source.isEmpty) source = pools.entries.toList();

      final total = source.fold<double>(
        0,
        (sum, e) => sum + (weights[e.key] ?? 1.0),
      );

      var roll = _random.nextDouble() * total;
      var chosen = source.first;
      for (final entry in source) {
        roll -= weights[entry.key] ?? 1.0;
        if (roll <= 0) {
          chosen = entry;
          break;
        }
      }

      picked.add(_pickFrom(chosen.value));
      usedTopics.add(chosen.key);
    }

    return picked;
  }

  Future<double> _weightFor(Session session, int topicId) async {
    final attempts = await Attempt.db.find(
      session,
      where: (t) => t.topicId.equals(topicId),
      limit: 1000,
    );
    if (attempts.isEmpty) return 1.0;
    final correct = attempts.where((a) => a.isCorrect).length;
    final percent = (correct / attempts.length * 100).round();
    return max(1.0, (100 - percent).toDouble());
  }

  Question _pickFrom(List<Question> questions) {
    if (questions.length == 1) return questions.first;
    return questions[_random.nextInt(questions.length)];
  }
}
