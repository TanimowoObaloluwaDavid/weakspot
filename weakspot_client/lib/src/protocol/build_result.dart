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

abstract class BuildResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BuildResult._({
    required this.subject,
    required this.topicCount,
    required this.questionCount,
    required this.firstRound,
  });

  factory BuildResult({
    required String subject,
    required int topicCount,
    required int questionCount,
    required List<_in6mynjk.Question> firstRound,
  }) = _BuildResultImpl;

  factory BuildResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildResult(
      subject: jsonSerialization['subject'] as String,
      topicCount: jsonSerialization['topicCount'] as int,
      questionCount: jsonSerialization['questionCount'] as int,
      firstRound: _ixljif3m.Protocol().deserialize<List<_in6mynjk.Question>>(
        jsonSerialization['firstRound'],
      ),
    );
  }

  String subject;

  int topicCount;

  int questionCount;

  List<_in6mynjk.Question> firstRound;

  /// Returns a shallow copy of this [BuildResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BuildResult copyWith({
    String? subject,
    int? topicCount,
    int? questionCount,
    List<_in6mynjk.Question>? firstRound,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildResult',
      'subject': subject,
      'topicCount': topicCount,
      'questionCount': questionCount,
      'firstRound': firstRound.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BuildResult',
      'subject': subject,
      'topicCount': topicCount,
      'questionCount': questionCount,
      'firstRound': firstRound.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BuildResultImpl extends BuildResult {
  _BuildResultImpl({
    required String subject,
    required int topicCount,
    required int questionCount,
    required List<_in6mynjk.Question> firstRound,
  }) : super._(
         subject: subject,
         topicCount: topicCount,
         questionCount: questionCount,
         firstRound: firstRound,
       );

  /// Returns a shallow copy of this [BuildResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BuildResult copyWith({
    String? subject,
    int? topicCount,
    int? questionCount,
    List<_in6mynjk.Question>? firstRound,
  }) {
    return BuildResult(
      subject: subject ?? this.subject,
      topicCount: topicCount ?? this.topicCount,
      questionCount: questionCount ?? this.questionCount,
      firstRound:
          firstRound ?? this.firstRound.map((e0) => e0.copyWith()).toList(),
    );
  }
}
