import 'package:test/test.dart';
import 'package:weakspot_server/src/generated/protocol.dart';
import 'package:weakspot_server/src/models/mastery_math.dart';

TopicMastery _topic({
  int attempted = 4,
  int correct = 0,
}) => TopicMastery(
  topicId: 1,
  name: 'Topic',
  subject: 'Subject',
  attempted: attempted,
  correct: correct,
  questionCount: 3,
);

void main() {
  group('mastery ratio', () {
    test('is the share of correct answers', () {
      expect(_topic(attempted: 4, correct: 3).percent, 75);
      expect(_topic(attempted: 4, correct: 2).percent, 50);
      expect(_topic(attempted: 4, correct: 0).percent, 0);
    });

    test('treats a never-attempted topic as unknown, not failed', () {
      final topic = _topic(attempted: 0, correct: 0);
      expect(topic.isUntouched, isTrue);
      expect(topic.isWeak, isFalse, reason: 'no evidence yet');
      expect(topic.ratio, 1.0, reason: 'kept out of the way until the student tries it');
    });
  });

  group('weak flag', () {
    test('flags a tried topic under half', () {
      expect(_topic(attempted: 4, correct: 1).isWeak, isTrue);
      expect(
        _topic(attempted: 4, correct: 2).isWeak,
        isFalse,
        reason: 'exactly half is not weak',
      );
    });

    test('does not flag untouched topics', () {
      expect(_topic(attempted: 0).isWeak, isFalse);
    });
  });

  group('selection weight', () {
    test('is the inverse of mastery', () {
      expect(_topic(attempted: 4, correct: 0).selectionWeight, 100);
      expect(_topic(attempted: 4, correct: 4).selectionWeight, 1);
    });

    test('a struggling topic outweighs a mastered one', () {
      final weak = _topic(attempted: 10, correct: 1).selectionWeight;
      final strong = _topic(attempted: 10, correct: 9).selectionWeight;
      expect(weak, greaterThan(strong * 5));
    });

    test('never returns zero so a failed topic stays in rotation', () {
      // 0% would weight to zero if unguarded, dropping the topic entirely,
      // which is the opposite of what this app exists to do.
      expect(_topic(attempted: 10, correct: 0).selectionWeight, greaterThan(0));
    });

    test('weights are ordered from weakest to strongest', () {
      final weights = [
        _topic(attempted: 10, correct: 0).selectionWeight,
        _topic(attempted: 10, correct: 3).selectionWeight,
        _topic(attempted: 10, correct: 6).selectionWeight,
        _topic(attempted: 10, correct: 10).selectionWeight,
      ];
      final sorted = [...weights]..sort((a, b) => b.compareTo(a));
      expect(weights, sorted);
    });
  });
}
