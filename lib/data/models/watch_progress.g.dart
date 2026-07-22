// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_progress.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWatchProgressCollection on Isar {
  IsarCollection<WatchProgress> get watchProgress => this.collection();
}

const WatchProgressSchema = CollectionSchema(
  name: r'WatchProgress',
  id: -7341403213961839091,
  properties: {
    r'lessonId': PropertySchema(
      id: 0,
      name: r'lessonId',
      type: IsarType.long,
    ),
    r'positionMs': PropertySchema(
      id: 1,
      name: r'positionMs',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 2,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _watchProgressEstimateSize,
  serialize: _watchProgressSerialize,
  deserialize: _watchProgressDeserialize,
  deserializeProp: _watchProgressDeserializeProp,
  idName: r'id',
  indexes: {
    r'lessonId': IndexSchema(
      id: 2130166291500416829,
      name: r'lessonId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lessonId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _watchProgressGetId,
  getLinks: _watchProgressGetLinks,
  attach: _watchProgressAttach,
  version: '3.1.0+1',
);

int _watchProgressEstimateSize(
  WatchProgress object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _watchProgressSerialize(
  WatchProgress object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.lessonId);
  writer.writeLong(offsets[1], object.positionMs);
  writer.writeDateTime(offsets[2], object.updatedAt);
}

WatchProgress _watchProgressDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WatchProgress();
  object.id = id;
  object.lessonId = reader.readLong(offsets[0]);
  object.positionMs = reader.readLong(offsets[1]);
  object.updatedAt = reader.readDateTime(offsets[2]);
  return object;
}

P _watchProgressDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _watchProgressGetId(WatchProgress object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _watchProgressGetLinks(WatchProgress object) {
  return [];
}

void _watchProgressAttach(
    IsarCollection<dynamic> col, Id id, WatchProgress object) {
  object.id = id;
}

extension WatchProgressByIndex on IsarCollection<WatchProgress> {
  Future<WatchProgress?> getByLessonId(int lessonId) {
    return getByIndex(r'lessonId', [lessonId]);
  }

  WatchProgress? getByLessonIdSync(int lessonId) {
    return getByIndexSync(r'lessonId', [lessonId]);
  }

  Future<bool> deleteByLessonId(int lessonId) {
    return deleteByIndex(r'lessonId', [lessonId]);
  }

  bool deleteByLessonIdSync(int lessonId) {
    return deleteByIndexSync(r'lessonId', [lessonId]);
  }

  Future<List<WatchProgress?>> getAllByLessonId(List<int> lessonIdValues) {
    final values = lessonIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'lessonId', values);
  }

  List<WatchProgress?> getAllByLessonIdSync(List<int> lessonIdValues) {
    final values = lessonIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'lessonId', values);
  }

  Future<int> deleteAllByLessonId(List<int> lessonIdValues) {
    final values = lessonIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'lessonId', values);
  }

  int deleteAllByLessonIdSync(List<int> lessonIdValues) {
    final values = lessonIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'lessonId', values);
  }

  Future<Id> putByLessonId(WatchProgress object) {
    return putByIndex(r'lessonId', object);
  }

  Id putByLessonIdSync(WatchProgress object, {bool saveLinks = true}) {
    return putByIndexSync(r'lessonId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLessonId(List<WatchProgress> objects) {
    return putAllByIndex(r'lessonId', objects);
  }

  List<Id> putAllByLessonIdSync(List<WatchProgress> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'lessonId', objects, saveLinks: saveLinks);
  }
}

extension WatchProgressQueryWhereSort
    on QueryBuilder<WatchProgress, WatchProgress, QWhere> {
  QueryBuilder<WatchProgress, WatchProgress, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhere> anyLessonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lessonId'),
      );
    });
  }
}

extension WatchProgressQueryWhere
    on QueryBuilder<WatchProgress, WatchProgress, QWhereClause> {
  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause> lessonIdEqualTo(
      int lessonId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lessonId',
        value: [lessonId],
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause>
      lessonIdNotEqualTo(int lessonId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lessonId',
              lower: [],
              upper: [lessonId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lessonId',
              lower: [lessonId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lessonId',
              lower: [lessonId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lessonId',
              lower: [],
              upper: [lessonId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause>
      lessonIdGreaterThan(
    int lessonId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lessonId',
        lower: [lessonId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause>
      lessonIdLessThan(
    int lessonId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lessonId',
        lower: [],
        upper: [lessonId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterWhereClause> lessonIdBetween(
    int lowerLessonId,
    int upperLessonId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lessonId',
        lower: [lowerLessonId],
        includeLower: includeLower,
        upper: [upperLessonId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchProgressQueryFilter
    on QueryBuilder<WatchProgress, WatchProgress, QFilterCondition> {
  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      lessonIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lessonId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      lessonIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lessonId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      lessonIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lessonId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      lessonIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lessonId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      positionMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'positionMs',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      positionMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'positionMs',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      positionMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'positionMs',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      positionMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'positionMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchProgressQueryObject
    on QueryBuilder<WatchProgress, WatchProgress, QFilterCondition> {}

extension WatchProgressQueryLinks
    on QueryBuilder<WatchProgress, WatchProgress, QFilterCondition> {}

extension WatchProgressQuerySortBy
    on QueryBuilder<WatchProgress, WatchProgress, QSortBy> {
  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy> sortByLessonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonId', Sort.asc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy>
      sortByLessonIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonId', Sort.desc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy> sortByPositionMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionMs', Sort.asc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy>
      sortByPositionMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionMs', Sort.desc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WatchProgressQuerySortThenBy
    on QueryBuilder<WatchProgress, WatchProgress, QSortThenBy> {
  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy> thenByLessonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonId', Sort.asc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy>
      thenByLessonIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonId', Sort.desc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy> thenByPositionMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionMs', Sort.asc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy>
      thenByPositionMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionMs', Sort.desc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WatchProgressQueryWhereDistinct
    on QueryBuilder<WatchProgress, WatchProgress, QDistinct> {
  QueryBuilder<WatchProgress, WatchProgress, QDistinct> distinctByLessonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lessonId');
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QDistinct> distinctByPositionMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'positionMs');
    });
  }

  QueryBuilder<WatchProgress, WatchProgress, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension WatchProgressQueryProperty
    on QueryBuilder<WatchProgress, WatchProgress, QQueryProperty> {
  QueryBuilder<WatchProgress, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WatchProgress, int, QQueryOperations> lessonIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lessonId');
    });
  }

  QueryBuilder<WatchProgress, int, QQueryOperations> positionMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'positionMs');
    });
  }

  QueryBuilder<WatchProgress, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
