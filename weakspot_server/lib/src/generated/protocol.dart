/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, no_leading_underscores_for_library_prefixes
// ignore_for_file: unnecessary_type_check

import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:weakspot_server/src/generated/question.dart' as _iahsd0y6;
import 'answer_result.dart' as _irbcmcg9;
import 'attempt.dart' as _iyzrlzh2;
import 'build_result.dart' as _if4lnnq0;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'mastery_report.dart' as _i8fihlrf;
import 'question.dart' as _in6mynjk;
import 'topic.dart' as _iro94j51;
import 'topic_mastery.dart' as _iypce4t3;
export 'answer_result.dart';
export 'attempt.dart';
export 'build_result.dart';
export 'greetings/greeting.dart';
export 'mastery_report.dart';
export 'question.dart';
export 'topic.dart';
export 'topic_mastery.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'attempts',
      dartName: 'Attempt',
      schema: 'public',
      module: 'weakspot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'questionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'topicId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'isCorrect',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'selectedIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'answeredAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'attempts_fk_0',
          columns: ['questionId'],
          referenceTable: 'questions',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'attempts_fk_1',
          columns: ['topicId'],
          referenceTable: 'topics',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'questions',
      dartName: 'Question',
      schema: 'public',
      module: 'weakspot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'topicId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'prompt',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'options',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'correctIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'explanation',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'position',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'questions_fk_0',
          columns: ['topicId'],
          referenceTable: 'topics',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'topics',
      dartName: 'Topic',
      schema: 'public',
      module: 'weakspot',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subject',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'position',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'estimatedMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _irbcmcg9.AnswerResult) {
      return _irbcmcg9.AnswerResult.fromJson(data) as T;
    }
    if (t == _iyzrlzh2.Attempt) {
      return _iyzrlzh2.Attempt.fromJson(data) as T;
    }
    if (t == _if4lnnq0.BuildResult) {
      return _if4lnnq0.BuildResult.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _i8fihlrf.MasteryReport) {
      return _i8fihlrf.MasteryReport.fromJson(data) as T;
    }
    if (t == _in6mynjk.Question) {
      return _in6mynjk.Question.fromJson(data) as T;
    }
    if (t == _iro94j51.Topic) {
      return _iro94j51.Topic.fromJson(data) as T;
    }
    if (t == _iypce4t3.TopicMastery) {
      return _iypce4t3.TopicMastery.fromJson(data) as T;
    }
    if (t == _is.getType<_irbcmcg9.AnswerResult?>()) {
      return (data != null ? _irbcmcg9.AnswerResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iyzrlzh2.Attempt?>()) {
      return (data != null ? _iyzrlzh2.Attempt.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_if4lnnq0.BuildResult?>()) {
      return (data != null ? _if4lnnq0.BuildResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8fihlrf.MasteryReport?>()) {
      return (data != null ? _i8fihlrf.MasteryReport.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_in6mynjk.Question?>()) {
      return (data != null ? _in6mynjk.Question.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iro94j51.Topic?>()) {
      return (data != null ? _iro94j51.Topic.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iypce4t3.TopicMastery?>()) {
      return (data != null ? _iypce4t3.TopicMastery.fromJson(data) : null) as T;
    }
    if (t == List<_in6mynjk.Question>) {
      return (data as List)
              .map((e) => deserialize<_in6mynjk.Question>(e))
              .toList()
          as T;
    }
    if (t == List<_iypce4t3.TopicMastery>) {
      return (data as List)
              .map((e) => deserialize<_iypce4t3.TopicMastery>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iahsd0y6.Question>) {
      return (data as List)
              .map((e) => deserialize<_iahsd0y6.Question>(e))
              .toList()
          as T;
    }
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _irbcmcg9.AnswerResult => 'AnswerResult',
      _iyzrlzh2.Attempt => 'Attempt',
      _if4lnnq0.BuildResult => 'BuildResult',
      _izw8z7ou.Greeting => 'Greeting',
      _i8fihlrf.MasteryReport => 'MasteryReport',
      _in6mynjk.Question => 'Question',
      _iro94j51.Topic => 'Topic',
      _iypce4t3.TopicMastery => 'TopicMastery',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('weakspot.', '');
    }

    switch (data) {
      case _irbcmcg9.AnswerResult():
        return 'AnswerResult';
      case _iyzrlzh2.Attempt():
        return 'Attempt';
      case _if4lnnq0.BuildResult():
        return 'BuildResult';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _i8fihlrf.MasteryReport():
        return 'MasteryReport';
      case _in6mynjk.Question():
        return 'Question';
      case _iro94j51.Topic():
        return 'Topic';
      case _iypce4t3.TopicMastery():
        return 'TopicMastery';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AnswerResult') {
      return deserialize<_irbcmcg9.AnswerResult>(data['data']);
    }
    if (dataClassName == 'Attempt') {
      return deserialize<_iyzrlzh2.Attempt>(data['data']);
    }
    if (dataClassName == 'BuildResult') {
      return deserialize<_if4lnnq0.BuildResult>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'MasteryReport') {
      return deserialize<_i8fihlrf.MasteryReport>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_in6mynjk.Question>(data['data']);
    }
    if (dataClassName == 'Topic') {
      return deserialize<_iro94j51.Topic>(data['data']);
    }
    if (dataClassName == 'TopicMastery') {
      return deserialize<_iypce4t3.TopicMastery>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iyzrlzh2.Attempt:
        return _iyzrlzh2.Attempt.t;
      case _in6mynjk.Question:
        return _in6mynjk.Question.t;
      case _iro94j51.Topic:
        return _iro94j51.Topic.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'weakspot';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _isp.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
