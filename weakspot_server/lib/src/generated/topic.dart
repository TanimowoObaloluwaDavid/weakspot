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

abstract class Topic implements _is.TableRow<int?>, _is.ProtocolSerialization {
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

  static final t = TopicTable();

  static const db = TopicRepository._();

  @override
  int? id;

  String name;

  String subject;

  int position;

  int? estimatedMinutes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Topic]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static TopicInclude include() {
    return TopicInclude._();
  }

  static TopicIncludeList includeList({
    _is.WhereExpressionBuilder<TopicTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TopicTable>? orderBy,
    _is.OrderByListBuilder<TopicTable>? orderByList,
    TopicInclude? include,
  }) {
    return TopicIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class TopicUpdateTable extends _is.UpdateTable<TopicTable> {
  TopicUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
    table.subject,
    value,
  );

  _is.ColumnValue<int, int> position(int value) => _is.ColumnValue(
    table.position,
    value,
  );

  _is.ColumnValue<int, int> estimatedMinutes(int? value) => _is.ColumnValue(
    table.estimatedMinutes,
    value,
  );
}

class TopicTable extends _is.Table<int?> {
  TopicTable({super.tableRelation}) : super(tableName: 'topics') {
    updateTable = TopicUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    subject = _is.ColumnString(
      'subject',
      this,
    );
    position = _is.ColumnInt(
      'position',
      this,
    );
    estimatedMinutes = _is.ColumnInt(
      'estimatedMinutes',
      this,
    );
  }

  late final TopicUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString subject;

  late final _is.ColumnInt position;

  late final _is.ColumnInt estimatedMinutes;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    subject,
    position,
    estimatedMinutes,
  ];
}

class TopicInclude extends _is.IncludeObject {
  TopicInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Topic.t;
}

class TopicIncludeList extends _is.IncludeList {
  TopicIncludeList._({
    _is.WhereExpressionBuilder<TopicTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Topic.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Topic.t;
}

class TopicRepository {
  const TopicRepository._();

  /// Returns a list of [Topic]s matching the given query parameters.
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
  Future<List<Topic>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TopicTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TopicTable>? orderBy,
    _is.OrderByListBuilder<TopicTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Topic>(
      where: where?.call(Topic.t),
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Topic] matching the given query parameters.
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
  Future<Topic?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TopicTable>? where,
    int? offset,
    _is.OrderByBuilder<TopicTable>? orderBy,
    _is.OrderByListBuilder<TopicTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Topic>(
      where: where?.call(Topic.t),
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Topic] by its [id] or null if no such row exists.
  Future<Topic?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Topic>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Topic]s in the list and returns the inserted rows.
  ///
  /// The returned [Topic]s will have their `id` fields set.
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
  Future<List<Topic>> insert(
    _is.DatabaseSession session,
    List<Topic> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Topic>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Topic] and returns the inserted row.
  ///
  /// The returned [Topic] will have its `id` field set.
  Future<Topic> insertRow(
    _is.DatabaseSession session,
    Topic row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Topic>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Topic]s in the list and returns the resulting rows.
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
  /// The returned [Topic]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Topic>> upsert(
    _is.DatabaseSession session,
    List<Topic> rows, {
    required _is.ColumnSelections<TopicTable> conflictColumns,
    _is.ColumnSelections<TopicTable>? updateColumns,
    _is.WhereExpressionBuilder<TopicTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Topic>(
      rows,
      conflictColumns: conflictColumns(Topic.t),
      updateColumns: updateColumns?.call(Topic.t),
      updateWhere: updateWhere?.call(Topic.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Topic] and returns the resulting row.
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
  /// The returned [Topic] will have its `id` field set.
  Future<Topic?> upsertRow(
    _is.DatabaseSession session,
    Topic row, {
    required _is.ColumnSelections<TopicTable> conflictColumns,
    _is.ColumnSelections<TopicTable>? updateColumns,
    _is.WhereExpressionBuilder<TopicTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Topic>(
      row,
      conflictColumns: conflictColumns(Topic.t),
      updateColumns: updateColumns?.call(Topic.t),
      updateWhere: updateWhere?.call(Topic.t),
      transaction: transaction,
    );
  }

  /// Updates all [Topic]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Topic>> update(
    _is.DatabaseSession session,
    List<Topic> rows, {
    _is.ColumnSelections<TopicTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Topic>(
      rows,
      columns: columns?.call(Topic.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Topic]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Topic> updateRow(
    _is.DatabaseSession session,
    Topic row, {
    _is.ColumnSelections<TopicTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Topic>(
      row,
      columns: columns?.call(Topic.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Topic] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Topic?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TopicUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Topic>(
      id,
      columnValues: columnValues(Topic.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Topic]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Topic>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TopicUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TopicTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TopicTable>? orderBy,
    _is.OrderByListBuilder<TopicTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Topic>(
      columnValues: columnValues(Topic.t.updateTable),
      where: where(Topic.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Topic]s in the list and returns the deleted rows.
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
  Future<List<Topic>> delete(
    _is.DatabaseSession session,
    List<Topic> rows, {
    _is.OrderByBuilder<TopicTable>? orderBy,
    _is.OrderByListBuilder<TopicTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Topic>(
      rows,
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Topic].
  Future<Topic> deleteRow(
    _is.DatabaseSession session,
    Topic row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Topic>(
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
  Future<List<Topic>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TopicTable> where,
    _is.OrderByBuilder<TopicTable>? orderBy,
    _is.OrderByListBuilder<TopicTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Topic>(
      where: where(Topic.t),
      orderBy: orderBy?.call(Topic.t),
      orderByList: orderByList?.call(Topic.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TopicTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Topic>(
      where: where?.call(Topic.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Topic] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TopicTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Topic>(
      where: where(Topic.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
