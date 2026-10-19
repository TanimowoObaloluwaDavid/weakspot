/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _is;

abstract class TopicMastery
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TopicMastery._({
    required this.topicId,
    required this.name,
    required this.subject,
    required this.attempted,
    required this.correct,
    required this.questionCount,
  });

  factory TopicMastery({
    required int topicId,
    required String name,
    required String subject,
    required int attempted,
    required int correct,
    required int questionCount,
  }) = _TopicMasteryImpl;

  factory TopicMastery.fromJson(Map<String, dynamic> jsonSerialization) {
    return TopicMastery(
      topicId: jsonSerialization['topicId'] as int,
      name: jsonSerialization['name'] as String,
      subject: jsonSerialization['subject'] as String,
      attempted: jsonSerialization['attempted'] as int,
      correct: jsonSerialization['correct'] as int,
      questionCount: jsonSerialization['questionCount'] as int,
    );
  }

  int topicId;

  String name;

  String subject;

  int attempted;

  int correct;

  int questionCount;

  /// Returns a shallow copy of this [TopicMastery]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TopicMastery copyWith({
    int? topicId,
    String? name,
    String? subject,
    int? attempted,
    int? correct,
    int? questionCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TopicMastery',
      'topicId': topicId,
      'name': name,
      'subject': subject,
      'attempted': attempted,
      'correct': correct,
      'questionCount': questionCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TopicMastery',
      'topicId': topicId,
      'name': name,
      'subject': subject,
      'attempted': attempted,
      'correct': correct,
      'questionCount': questionCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _TopicMasteryImpl extends TopicMastery {
  _TopicMasteryImpl({
    required int topicId,
    required String name,
    required String subject,
    required int attempted,
    required int correct,
    required int questionCount,
  }) : super._(
         topicId: topicId,
         name: name,
         subject: subject,
         attempted: attempted,
         correct: correct,
         questionCount: questionCount,
       );

  /// Returns a shallow copy of this [TopicMastery]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TopicMastery copyWith({
    int? topicId,
    String? name,
    String? subject,
    int? attempted,
    int? correct,
    int? questionCount,
  }) {
    return TopicMastery(
      topicId: topicId ?? this.topicId,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      attempted: attempted ?? this.attempted,
      correct: correct ?? this.correct,
      questionCount: questionCount ?? this.questionCount,
    );
  }
}
