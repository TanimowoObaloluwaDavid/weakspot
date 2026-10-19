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
// ignore_for_file: unnecessary_null_comparison

import 'package:serverpod/serverpod.dart' as _is;
import 'package:weakspot_server/src/generated/protocol.dart' as _i7zocjgr;
import 'question.dart' as _in6mynjk;
import 'topic.dart' as _iro94j51;

abstract class Attempt
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _i7zocjgr.Protocol().deserialize<_in6mynjk.Question>(
              jsonSerialization['question'],
            ),
      topicId: jsonSerialization['topicId'] as int,
      topic: jsonSerialization['topic'] == null
          ? null
          : _i7zocjgr.Protocol().deserialize<_iro94j51.Topic>(
              jsonSerialization['topic'],
            ),
      isCorrect: _is.BoolJsonExtension.fromJson(jsonSerialization['isCorrect']),
      selectedIndex: jsonSerialization['selectedIndex'] as int,
      answeredAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['answeredAt'],
      ),
    );
  }

  static final t = AttemptTable();

  static const db = AttemptRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Attempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static AttemptInclude include({
    _in6mynjk.QuestionInclude? question,
    _iro94j51.TopicInclude? topic,
  }) {
    return AttemptInclude._(
      question: question,
      topic: topic,
    );
  }

  static AttemptIncludeList includeList({
    _is.WhereExpressionBuilder<AttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    AttemptInclude? include,
  }) {
    return AttemptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class AttemptUpdateTable extends _is.UpdateTable<AttemptTable> {
  AttemptUpdateTable(super.table);

  _is.ColumnValue<int, int> questionId(int value) => _is.ColumnValue(
    table.questionId,
    value,
  );

  _is.ColumnValue<int, int> topicId(int value) => _is.ColumnValue(
    table.topicId,
    value,
  );

  _is.ColumnValue<bool, bool> isCorrect(bool value) => _is.ColumnValue(
    table.isCorrect,
    value,
  );

  _is.ColumnValue<int, int> selectedIndex(int value) => _is.ColumnValue(
    table.selectedIndex,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> answeredAt(DateTime value) =>
      _is.ColumnValue(
        table.answeredAt,
        value,
      );
}

class AttemptTable extends _is.Table<int?> {
  AttemptTable({super.tableRelation}) : super(tableName: 'attempts') {
    updateTable = AttemptUpdateTable(this);
    questionId = _is.ColumnInt(
      'questionId',
      this,
    );
    topicId = _is.ColumnInt(
      'topicId',
      this,
    );
    isCorrect = _is.ColumnBool(
      'isCorrect',
      this,
    );
    selectedIndex = _is.ColumnInt(
      'selectedIndex',
      this,
    );
    answeredAt = _is.ColumnDateTime(
      'answeredAt',
      this,
    );
  }

  late final AttemptUpdateTable updateTable;

  late final _is.ColumnInt questionId;

  _in6mynjk.QuestionTable? _question;

  late final _is.ColumnInt topicId;

  /// Denormalised so mastery can be computed with one filtered query per topic
  /// instead of a join through questions on every read.
  _iro94j51.TopicTable? _topic;

  late final _is.ColumnBool isCorrect;

  late final _is.ColumnInt selectedIndex;

  late final _is.ColumnDateTime answeredAt;

  _in6mynjk.QuestionTable get question {
    if (_question != null) return _question!;
    _question = _is.createRelationTable(
      relationFieldName: 'question',
      field: Attempt.t.questionId,
      foreignField: _in6mynjk.Question.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _in6mynjk.QuestionTable(tableRelation: foreignTableRelation),
    );
    return _question!;
  }

  _iro94j51.TopicTable get topic {
    if (_topic != null) return _topic!;
    _topic = _is.createRelationTable(
      relationFieldName: 'topic',
      field: Attempt.t.topicId,
      foreignField: _iro94j51.Topic.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iro94j51.TopicTable(tableRelation: foreignTableRelation),
    );
    return _topic!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    questionId,
    topicId,
    isCorrect,
    selectedIndex,
    answeredAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'question') {
      return question;
    }
    if (relationField == 'topic') {
      return topic;
    }
    return null;
  }
}

class AttemptInclude extends _is.IncludeObject {
  AttemptInclude._({
    _in6mynjk.QuestionInclude? question,
    _iro94j51.TopicInclude? topic,
  }) {
    _question = question;
    _topic = topic;
  }

  _in6mynjk.QuestionInclude? _question;

  _iro94j51.TopicInclude? _topic;

  @override
  Map<String, _is.Include?> get includes => {
    'question': _question,
    'topic': _topic,
  };

  @override
  _is.Table<int?> get table => Attempt.t;
}

class AttemptIncludeList extends _is.IncludeList {
  AttemptIncludeList._({
    _is.WhereExpressionBuilder<AttemptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Attempt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Attempt.t;
}

class AttemptRepository {
  const AttemptRepository._();

  final attachRow = const AttemptAttachRowRepository._();

  /// Returns a list of [Attempt]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Attempt>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    AttemptInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Attempt>(
      where: where?.call(Attempt.t),
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Attempt] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Attempt?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttemptTable>? where,
    int? offset,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    AttemptInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Attempt>(
      where: where?.call(Attempt.t),
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Attempt] by its [id] or null if no such row exists.
  Future<Attempt?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    AttemptInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Attempt>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Attempt]s in the list and returns the inserted rows.
  ///
  /// The returned [Attempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> insert(
    _is.DatabaseSession session,
    List<Attempt> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Attempt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Attempt] and returns the inserted row.
  ///
  /// The returned [Attempt] will have its `id` field set.
  Future<Attempt> insertRow(
    _is.DatabaseSession session,
    Attempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Attempt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Attempt]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Attempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> upsert(
    _is.DatabaseSession session,
    List<Attempt> rows, {
    required _is.ColumnSelections<AttemptTable> conflictColumns,
    _is.ColumnSelections<AttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<AttemptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Attempt>(
      rows,
      conflictColumns: conflictColumns(Attempt.t),
      updateColumns: updateColumns?.call(Attempt.t),
      updateWhere: updateWhere?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Attempt] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Attempt] will have its `id` field set.
  Future<Attempt?> upsertRow(
    _is.DatabaseSession session,
    Attempt row, {
    required _is.ColumnSelections<AttemptTable> conflictColumns,
    _is.ColumnSelections<AttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<AttemptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Attempt>(
      row,
      conflictColumns: conflictColumns(Attempt.t),
      updateColumns: updateColumns?.call(Attempt.t),
      updateWhere: updateWhere?.call(Attempt.t),
      transaction: transaction,
    );
  }

  /// Updates all [Attempt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> update(
    _is.DatabaseSession session,
    List<Attempt> rows, {
    _is.ColumnSelections<AttemptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Attempt>(
      rows,
      columns: columns?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Attempt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Attempt> updateRow(
    _is.DatabaseSession session,
    Attempt row, {
    _is.ColumnSelections<AttemptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Attempt>(
      row,
      columns: columns?.call(Attempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Attempt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Attempt?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AttemptUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Attempt>(
      id,
      columnValues: columnValues(Attempt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Attempt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AttemptUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AttemptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Attempt>(
      columnValues: columnValues(Attempt.t.updateTable),
      where: where(Attempt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Attempt]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> delete(
    _is.DatabaseSession session,
    List<Attempt> rows, {
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Attempt>(
      rows,
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Attempt].
  Future<Attempt> deleteRow(
    _is.DatabaseSession session,
    Attempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Attempt>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AttemptTable> where,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Attempt>(
      where: where(Attempt.t),
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttemptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Attempt>(
      where: where?.call(Attempt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Attempt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AttemptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Attempt>(
      where: where(Attempt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AttemptAttachRowRepository {
  const AttemptAttachRowRepository._();

  /// Creates a relation between the given [Attempt] and [Question]
  /// by setting the [Attempt]'s foreign key `questionId` to refer to the [Question].
  Future<void> question(
    _is.DatabaseSession session,
    Attempt attempt,
    _in6mynjk.Question question, {
    _is.Transaction? transaction,
  }) async {
    if (attempt.id == null) {
      throw ArgumentError.notNull('attempt.id');
    }
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }

    var $attempt = attempt.copyWith(questionId: question.id);
    await session.db.updateRow<Attempt>(
      $attempt,
      columns: [Attempt.t.questionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Attempt] and [Topic]
  /// by setting the [Attempt]'s foreign key `topicId` to refer to the [Topic].
  Future<void> topic(
    _is.DatabaseSession session,
    Attempt attempt,
    _iro94j51.Topic topic, {
    _is.Transaction? transaction,
  }) async {
    if (attempt.id == null) {
      throw ArgumentError.notNull('attempt.id');
    }
    if (topic.id == null) {
      throw ArgumentError.notNull('topic.id');
    }

    var $attempt = attempt.copyWith(topicId: topic.id);
    await session.db.updateRow<Attempt>(
      $attempt,
      columns: [Attempt.t.topicId],
      transaction: transaction,
    );
  }
}
