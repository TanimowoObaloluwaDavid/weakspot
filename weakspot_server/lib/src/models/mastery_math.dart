import 'dart:math';

import '../generated/protocol.dart';

/// The scheduling arithmetic, kept out of the generated model so it stays
/// readable and can be shared by the server and the client.
///
/// Nothing here touches the database or any model -- given the same attempt
/// history it always produces the same numbers.
extension TopicMasteryMath on TopicMastery {
  /// 0.0 to 1.0. Topics never attempted are treated as fully known so they
  /// stay out of the way until the student has actually tried them.
  double get ratio {
    if (attempted == 0) return 1.0;
    return correct / attempted;
  }

  int get percent => (ratio * 100).round();

  /// No evidence yet. The UI shows this differently from "weak".
  bool get isUntouched => attempted == 0;

  /// A topic is weak once the student has tried it and scored under half.
  bool get isWeak => attempted > 0 && percent < 50;

  /// How strongly the next-question picker should pull from this topic.
  ///
  /// A topic at 0% scores 100, one at 100% scores 1, so a struggling topic is
  /// pulled up to 100x more often than a mastered one. Never zero -- otherwise
  /// a topic the student always fails would fall out of rotation entirely,
  /// which is the opposite of what this app is for.
  double get selectionWeight => max(1.0, (100 - percent).toDouble());
}
