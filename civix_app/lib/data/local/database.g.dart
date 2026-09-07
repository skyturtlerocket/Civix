// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CachedBriefsTable extends CachedBriefs
    with TableInfo<$CachedBriefsTable, CachedBrief> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedBriefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _briefIdMeta = const VerificationMeta(
    'briefId',
  );
  @override
  late final GeneratedColumn<String> briefId = GeneratedColumn<String>(
    'brief_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [briefId, json, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_briefs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedBrief> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('brief_id')) {
      context.handle(
        _briefIdMeta,
        briefId.isAcceptableOrUnknown(data['brief_id']!, _briefIdMeta),
      );
    } else if (isInserting) {
      context.missing(_briefIdMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
        _jsonMeta,
        json.isAcceptableOrUnknown(data['json']!, _jsonMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {briefId};
  @override
  CachedBrief map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedBrief(
      briefId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brief_id'],
      )!,
      json: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedBriefsTable createAlias(String alias) {
    return $CachedBriefsTable(attachedDatabase, alias);
  }
}

class CachedBrief extends DataClass implements Insertable<CachedBrief> {
  final String briefId;
  final String json;
  final DateTime cachedAt;
  const CachedBrief({
    required this.briefId,
    required this.json,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['brief_id'] = Variable<String>(briefId);
    map['json'] = Variable<String>(json);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedBriefsCompanion toCompanion(bool nullToAbsent) {
    return CachedBriefsCompanion(
      briefId: Value(briefId),
      json: Value(json),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedBrief.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedBrief(
      briefId: serializer.fromJson<String>(json['briefId']),
      json: serializer.fromJson<String>(json['json']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'briefId': serializer.toJson<String>(briefId),
      'json': serializer.toJson<String>(json),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedBrief copyWith({String? briefId, String? json, DateTime? cachedAt}) =>
      CachedBrief(
        briefId: briefId ?? this.briefId,
        json: json ?? this.json,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedBrief copyWithCompanion(CachedBriefsCompanion data) {
    return CachedBrief(
      briefId: data.briefId.present ? data.briefId.value : this.briefId,
      json: data.json.present ? data.json.value : this.json,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedBrief(')
          ..write('briefId: $briefId, ')
          ..write('json: $json, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(briefId, json, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedBrief &&
          other.briefId == this.briefId &&
          other.json == this.json &&
          other.cachedAt == this.cachedAt);
}

class CachedBriefsCompanion extends UpdateCompanion<CachedBrief> {
  final Value<String> briefId;
  final Value<String> json;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedBriefsCompanion({
    this.briefId = const Value.absent(),
    this.json = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedBriefsCompanion.insert({
    required String briefId,
    required String json,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : briefId = Value(briefId),
       json = Value(json),
       cachedAt = Value(cachedAt);
  static Insertable<CachedBrief> custom({
    Expression<String>? briefId,
    Expression<String>? json,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (briefId != null) 'brief_id': briefId,
      if (json != null) 'json': json,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedBriefsCompanion copyWith({
    Value<String>? briefId,
    Value<String>? json,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedBriefsCompanion(
      briefId: briefId ?? this.briefId,
      json: json ?? this.json,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (briefId.present) {
      map['brief_id'] = Variable<String>(briefId.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedBriefsCompanion(')
          ..write('briefId: $briefId, ')
          ..write('json: $json, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedBriefsTable cachedBriefs = $CachedBriefsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedBriefs];
}

typedef $$CachedBriefsTableCreateCompanionBuilder =
    CachedBriefsCompanion Function({
      required String briefId,
      required String json,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedBriefsTableUpdateCompanionBuilder =
    CachedBriefsCompanion Function({
      Value<String> briefId,
      Value<String> json,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$CachedBriefsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedBriefsTable> {
  $$CachedBriefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get briefId => $composableBuilder(
    column: $table.briefId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedBriefsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedBriefsTable> {
  $$CachedBriefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get briefId => $composableBuilder(
    column: $table.briefId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedBriefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedBriefsTable> {
  $$CachedBriefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get briefId =>
      $composableBuilder(column: $table.briefId, builder: (column) => column);

  GeneratedColumn<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedBriefsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedBriefsTable,
          CachedBrief,
          $$CachedBriefsTableFilterComposer,
          $$CachedBriefsTableOrderingComposer,
          $$CachedBriefsTableAnnotationComposer,
          $$CachedBriefsTableCreateCompanionBuilder,
          $$CachedBriefsTableUpdateCompanionBuilder,
          (
            CachedBrief,
            BaseReferences<_$AppDatabase, $CachedBriefsTable, CachedBrief>,
          ),
          CachedBrief,
          PrefetchHooks Function()
        > {
  $$CachedBriefsTableTableManager(_$AppDatabase db, $CachedBriefsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedBriefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedBriefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedBriefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> briefId = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedBriefsCompanion(
                briefId: briefId,
                json: json,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String briefId,
                required String json,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedBriefsCompanion.insert(
                briefId: briefId,
                json: json,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedBriefsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedBriefsTable,
      CachedBrief,
      $$CachedBriefsTableFilterComposer,
      $$CachedBriefsTableOrderingComposer,
      $$CachedBriefsTableAnnotationComposer,
      $$CachedBriefsTableCreateCompanionBuilder,
      $$CachedBriefsTableUpdateCompanionBuilder,
      (
        CachedBrief,
        BaseReferences<_$AppDatabase, $CachedBriefsTable, CachedBrief>,
      ),
      CachedBrief,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedBriefsTableTableManager get cachedBriefs =>
      $$CachedBriefsTableTableManager(_db, _db.cachedBriefs);
}
