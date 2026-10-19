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

import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:weakspot_client/src/protocol/protocol.dart' as _ixljif3m;
import 'question.dart' as _in6mynjk;
import 'topic.dart' as _iro94j51;

abstract class Attempt
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Attempt._({
    this.id,
    required this.questionId,
    this.question,
    required this.topicId,
    this.topic,
    required this.isCorrect,
    required this.selectedIndex,
    required this.answeredAt,
  });

  factory Attempt({
    int? id,
    required int questionId,
    _in6mynjk.Question? question,
    required int topicId,
    _iro94j51.Topic? topic,
    required bool isCorrect,
    required int selectedIndex,
    required DateTime answeredAt,
  }) = _AttemptImpl;

  factory Attempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return Attempt(
      id: jsonSerialization['id'] as int?,
      questionId: jsonSerialization['questionId'] as int,
      question: jsonSerialization['question'] == null
          ? null
          : _ixljif3m.Protocol().deserialize<_in6mynjk.Question>(
              jsonSerialization['question'],
            ),
      topicId: jsonSerialization['topicId'] as int,
      topic: jsonSerialization['topic'] == null
          ? null
          : _ixljif3m.Protocol().deserialize<_iro94j51.Topic>(
              jsonSerialization['topic'],
            ),
      isCorrect: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isCorrect'],
      ),
      selectedIndex: jsonSerialization['selectedIndex'] as int,
      answeredAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['answeredAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int questionId;

  _in6mynjk.Question? question;

  int topicId;

  /// Denormalised so mastery can be computed with one filtered query per topic
  /// instead of a join through questions on every read.
  _iro94j51.Topic? topic;

  bool isCorrect;

  int selectedIndex;

  DateTime answeredAt;

  /// Returns a shallow copy of this [Attempt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Attempt copyWith({
    int? id,
    int? questionId,
    _in6mynjk.Question? question,
    int? topicId,
    _iro94j51.Topic? topic,
    bool? isCorrect,
    int? selectedIndex,
    DateTime? answeredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Attempt',
      if (id != null) 'id': id,
      'questionId': questionId,
      if (question != null) 'question': question?.toJson(),
      'topicId': topicId,
      if (topic != null) 'topic': topic?.toJson(),
      'isCorrect': isCorrect,
      'selectedIndex': selectedIndex,
      'answeredAt': answeredAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Attempt',
      if (id != null) 'id': id,
      'questionId': questionId,
      if (question != null) 'question': question?.toJsonForProtocol(),
      'topicId': topicId,
      if (topic != null) 'topic': topic?.toJsonForProtocol(),
      'isCorrect': isCorrect,
      'selectedIndex': selectedIndex,
      'answeredAt': answeredAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttemptImpl extends Attempt {
  _AttemptImpl({
    int? id,
    required int questionId,
    _in6mynjk.Question? question,
    required int topicId,
    _iro94j51.Topic? topic,
    required bool isCorrect,
    required int selectedIndex,
    required DateTime answeredAt,
  }) : super._(
         id: id,
         questionId: questionId,
         question: question,
         topicId: topicId,
         topic: topic,
         isCorrect: isCorrect,
         selectedIndex: selectedIndex,
         answeredAt: answeredAt,
       );

  /// Returns a shallow copy of this [Attempt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Attempt copyWith({
    Object? id = _Undefined,
    int? questionId,
    Object? question = _Undefined,
    int? topicId,
    Object? topic = _Undefined,
    bool? isCorrect,
    int? selectedIndex,
    DateTime? answeredAt,
  }) {
    return Attempt(
      id: id is int? ? id : this.id,
      questionId: questionId ?? this.questionId,
      question: question is _in6mynjk.Question?
          ? question
          : this.question?.copyWith(),
      topicId: topicId ?? this.topicId,
      topic: topic is _iro94j51.Topic? ? topic : this.topic?.copyWith(),
      isCorrect: isCorrect ?? this.isCorrect,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }
}
