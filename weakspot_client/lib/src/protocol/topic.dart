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

abstract class Topic
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Topic._({
    this.id,
    required this.name,
    required this.subject,
    required this.position,
    this.estimatedMinutes,
  });

  factory Topic({
    int? id,
    required String name,
    required String subject,
    required int position,
    int? estimatedMinutes,
  }) = _TopicImpl;

  factory Topic.fromJson(Map<String, dynamic> jsonSerialization) {
    return Topic(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      subject: jsonSerialization['subject'] as String,
      position: jsonSerialization['position'] as int,
      estimatedMinutes: jsonSerialization['estimatedMinutes'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String subject;

  int position;

  int? estimatedMinutes;

  /// Returns a shallow copy of this [Topic]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Topic copyWith({
    int? id,
    String? name,
    String? subject,
    int? position,
    int? estimatedMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Topic',
      if (id != null) 'id': id,
      'name': name,
      'subject': subject,
      'position': position,
      if (estimatedMinutes != null) 'estimatedMinutes': estimatedMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Topic',
      if (id != null) 'id': id,
      'name': name,
      'subject': subject,
      'position': position,
      if (estimatedMinutes != null) 'estimatedMinutes': estimatedMinutes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TopicImpl extends Topic {
  _TopicImpl({
    int? id,
    required String name,
    required String subject,
    required int position,
    int? estimatedMinutes,
  }) : super._(
         id: id,
         name: name,
         subject: subject,
         position: position,
         estimatedMinutes: estimatedMinutes,
       );

  /// Returns a shallow copy of this [Topic]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Topic copyWith({
    Object? id = _Undefined,
    String? name,
    String? subject,
    int? position,
    Object? estimatedMinutes = _Undefined,
  }) {
    return Topic(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      position: position ?? this.position,
      estimatedMinutes: estimatedMinutes is int?
          ? estimatedMinutes
          : this.estimatedMinutes,
    );
  }
}
