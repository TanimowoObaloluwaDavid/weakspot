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

abstract class AnswerResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AnswerResult._({
    required this.isCorrect,
    required this.correctIndex,
    required this.explanation,
    required this.topicName,
    required this.topicPercent,
    required this.isTopicWeak,
  });

  factory AnswerResult({
    required bool isCorrect,
    required int correctIndex,
    required String explanation,
    required String topicName,
    required int topicPercent,
    required bool isTopicWeak,
  }) = _AnswerResultImpl;

  factory AnswerResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnswerResult(
      isCorrect: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isCorrect'],
      ),
      correctIndex: jsonSerialization['correctIndex'] as int,
      explanation: jsonSerialization['explanation'] as String,
      topicName: jsonSerialization['topicName'] as String,
      topicPercent: jsonSerialization['topicPercent'] as int,
      isTopicWeak: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isTopicWeak'],
      ),
    );
  }

  bool isCorrect;

  int correctIndex;

  String explanation;

  String topicName;

  int topicPercent;

  bool isTopicWeak;

  /// Returns a shallow copy of this [AnswerResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AnswerResult copyWith({
    bool? isCorrect,
    int? correctIndex,
    String? explanation,
    String? topicName,
    int? topicPercent,
    bool? isTopicWeak,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnswerResult',
      'isCorrect': isCorrect,
      'correctIndex': correctIndex,
      'explanation': explanation,
      'topicName': topicName,
      'topicPercent': topicPercent,
      'isTopicWeak': isTopicWeak,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnswerResult',
      'isCorrect': isCorrect,
      'correctIndex': correctIndex,
      'explanation': explanation,
      'topicName': topicName,
      'topicPercent': topicPercent,
      'isTopicWeak': isTopicWeak,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AnswerResultImpl extends AnswerResult {
  _AnswerResultImpl({
    required bool isCorrect,
    required int correctIndex,
    required String explanation,
    required String topicName,
    required int topicPercent,
    required bool isTopicWeak,
  }) : super._(
         isCorrect: isCorrect,
         correctIndex: correctIndex,
         explanation: explanation,
         topicName: topicName,
         topicPercent: topicPercent,
         isTopicWeak: isTopicWeak,
       );

  /// Returns a shallow copy of this [AnswerResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AnswerResult copyWith({
    bool? isCorrect,
    int? correctIndex,
    String? explanation,
    String? topicName,
    int? topicPercent,
    bool? isTopicWeak,
  }) {
    return AnswerResult(
      isCorrect: isCorrect ?? this.isCorrect,
      correctIndex: correctIndex ?? this.correctIndex,
      explanation: explanation ?? this.explanation,
      topicName: topicName ?? this.topicName,
      topicPercent: topicPercent ?? this.topicPercent,
      isTopicWeak: isTopicWeak ?? this.isTopicWeak,
    );
  }
}
