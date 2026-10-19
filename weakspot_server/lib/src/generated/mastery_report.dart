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
import 'package:weakspot_server/src/generated/protocol.dart' as _i7zocjgr;
import 'topic_mastery.dart' as _iypce4t3;

abstract class MasteryReport
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MasteryReport._({
    required this.topics,
    required this.totalAttempted,
    required this.totalCorrect,
    required this.weakCount,
  });

  factory MasteryReport({
    required List<_iypce4t3.TopicMastery> topics,
    required int totalAttempted,
    required int totalCorrect,
    required int weakCount,
  }) = _MasteryReportImpl;

  factory MasteryReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return MasteryReport(
      topics: _i7zocjgr.Protocol().deserialize<List<_iypce4t3.TopicMastery>>(
        jsonSerialization['topics'],
      ),
      totalAttempted: jsonSerialization['totalAttempted'] as int,
      totalCorrect: jsonSerialization['totalCorrect'] as int,
      weakCount: jsonSerialization['weakCount'] as int,
    );
  }

  List<_iypce4t3.TopicMastery> topics;

  int totalAttempted;

  int totalCorrect;

  int weakCount;

  /// Returns a shallow copy of this [MasteryReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MasteryReport copyWith({
    List<_iypce4t3.TopicMastery>? topics,
    int? totalAttempted,
    int? totalCorrect,
    int? weakCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MasteryReport',
      'topics': topics.toJson(valueToJson: (v) => v.toJson()),
      'totalAttempted': totalAttempted,
      'totalCorrect': totalCorrect,
      'weakCount': weakCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MasteryReport',
      'topics': topics.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalAttempted': totalAttempted,
      'totalCorrect': totalCorrect,
      'weakCount': weakCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MasteryReportImpl extends MasteryReport {
  _MasteryReportImpl({
    required List<_iypce4t3.TopicMastery> topics,
    required int totalAttempted,
    required int totalCorrect,
    required int weakCount,
  }) : super._(
         topics: topics,
         totalAttempted: totalAttempted,
         totalCorrect: totalCorrect,
         weakCount: weakCount,
       );

  /// Returns a shallow copy of this [MasteryReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MasteryReport copyWith({
    List<_iypce4t3.TopicMastery>? topics,
    int? totalAttempted,
    int? totalCorrect,
    int? weakCount,
  }) {
    return MasteryReport(
      topics: topics ?? this.topics.map((e0) => e0.copyWith()).toList(),
      totalAttempted: totalAttempted ?? this.totalAttempted,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      weakCount: weakCount ?? this.weakCount,
    );
  }
}
