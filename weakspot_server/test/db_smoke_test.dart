import 'package:test/test.dart';
import 'package:weakspot_server/src/generated/protocol.dart';

import 'integration/test_tools/serverpod_test_tools.dart';

/// Round-trips real data through the database. Each case runs inside a
/// transaction that is rolled back afterwards.
void main() {
  withServerpod('Database round trip', (sessionBuilder, endpoints) {
    final session = sessionBuilder.build();

    test('given a fresh database then there are no topics', () async {
      final topics = await Topic.db.find(session);
      expect(topics, isEmpty);
    });

    test('given an inserted topic then it can be read back', () async {
      final topic = await Topic.db.insertRow(
        session,
        Topic(name: 'TCP/IP', subject: 'Networks', position: 0),
      );
      expect(topic.id, isNotNull);

      final all = await Topic.db.find(session);
      expect(all.length, 1);
      expect(all.first.name, 'TCP/IP');
    });

    test('given an answered question then the result reflects it', () async {
      final topic = await Topic.db.insertRow(
        session,
        Topic(name: 'Routing', subject: 'Networks', position: 0),
      );
      final question = await Question.db.insertRow(
        session,
        Question(
          topicId: topic.id!,
          prompt: 'What does CIDR stand for?',
          options: ['A', 'B', 'C', 'D'],
          correctIndex: 0,
          explanation: 'Classless Inter-Domain Routing.',
          position: 0,
        ),
      );

      final result = await endpoints.quiz.submit(
        sessionBuilder,
        questionId: question.id!,
        selectedIndex: 1,
      );

      expect(result.isCorrect, isFalse);
      expect(result.correctIndex, 0);
      expect(result.topicName, 'Routing');
    });

    test('given a topic with questions then next returns them', () async {
      final topic = await Topic.db.insertRow(
        session,
        Topic(name: 'Fundamentals', subject: 'Networks', position: 0),
      );
      for (var i = 0; i < 3; i++) {
        await Question.db.insertRow(
          session,
          Question(
            topicId: topic.id!,
            prompt: 'Question $i',
            options: ['A', 'B', 'C', 'D'],
            correctIndex: 0,
            explanation: 'Because.',
            position: i,
          ),
        );
      }

      final round = await endpoints.quiz.next(sessionBuilder, count: 3);
      expect(round.length, 3);
      expect(round.every((q) => q.topicId == topic.id!), isTrue);
    });

    test('given recorded attempts then the report counts them', () async {
      final topic = await Topic.db.insertRow(
        session,
        Topic(name: 'Addressing', subject: 'Networks', position: 0),
      );
      final question = await Question.db.insertRow(
        session,
        Question(
          topicId: topic.id!,
          prompt: 'How many bits in an IPv4 address?',
          options: ['32', '64', '128', '256'],
          correctIndex: 0,
          explanation: 'IPv4 uses 32 bits.',
          position: 0,
        ),
      );

      await endpoints.quiz.submit(
        sessionBuilder,
        questionId: question.id!,
        selectedIndex: 0,
      );
      await endpoints.quiz.submit(
        sessionBuilder,
        questionId: question.id!,
        selectedIndex: 2,
      );

      final report = await endpoints.quiz.report(sessionBuilder);
      expect(report.totalAttempted, 2);
      expect(report.totalCorrect, 1);
      expect(report.topics.length, greaterThanOrEqualTo(1));
    });
  });
}