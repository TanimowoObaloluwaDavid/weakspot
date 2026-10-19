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
import 'topic.dart' as _iro94j51;

abstract class Question
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Question._({
    this.id,
    required this.topicId,
    this.topic,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.position,
  });

  factory Question({
    int? id,
    required int topicId,
    _iro94j51.Topic? topic,
    required String prompt,
    required List<String> options,
    required int correctIndex,
    required String explanation,
    required int position,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      topicId: jsonSerialization['topicId'] as int,
      topic: jsonSerialization['topic'] == null
          ? null
          : _ixljif3m.Protocol().deserialize<_iro94j51.Topic>(
              jsonSerialization['topic'],
            ),
      prompt: jsonSerialization['prompt'] as String,
      options: _ixljif3m.Protocol().deserialize<List<String>>(
        jsonSerialization['options'],
      ),
      correctIndex: jsonSerialization['correctIndex'] as int,
      explanation: jsonSerialization['explanation'] as String,
      position: jsonSerialization['position'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int topicId;

  _iro94j51.Topic? topic;

  String prompt;

  List<String> options;

  int correctIndex;

  String explanation;

  int position;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Question copyWith({
    int? id,
    int? topicId,
    _iro94j51.Topic? topic,
    String? prompt,
    List<String>? options,
    int? correctIndex,
    String? explanation,
    int? position,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'topicId': topicId,
      if (topic != null) 'topic': topic?.toJson(),
      'prompt': prompt,
      'options': options.toJson(),
      'correctIndex': correctIndex,
      'explanation': explanation,
      'position': position,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'topicId': topicId,
      if (topic != null) 'topic': topic?.toJsonForProtocol(),
      'prompt': prompt,
      'options': options.toJson(),
      'correctIndex': correctIndex,
      'explanation': explanation,
      'position': position,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required int topicId,
    _iro94j51.Topic? topic,
    required String prompt,
    required List<String> options,
    required int correctIndex,
    required String explanation,
    required int position,
  }) : super._(
         id: id,
         topicId: topicId,
         topic: topic,
         prompt: prompt,
         options: options,
         correctIndex: correctIndex,
         explanation: explanation,
         position: position,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? topicId,
    Object? topic = _Undefined,
    String? prompt,
    List<String>? options,
    int? correctIndex,
    String? explanation,
    int? position,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      topicId: topicId ?? this.topicId,
      topic: topic is _iro94j51.Topic? ? topic : this.topic?.copyWith(),
      prompt: prompt ?? this.prompt,
      options: options ?? this.options.map((e0) => e0).toList(),
      correctIndex: correctIndex ?? this.correctIndex,
      explanation: explanation ?? this.explanation,
      position: position ?? this.position,
    );
  }
}
