// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_answer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizAnswerCollection on Isar {
  IsarCollection<QuizAnswer> get quizAnswers => this.collection();
}

const QuizAnswerSchema = CollectionSchema(
  name: r'QuizAnswer',
  id: -687287399106352755,
  properties: {
    r'answeredAt': PropertySchema(
      id: 0,
      name: r'answeredAt',
      type: IsarType.dateTime,
    ),
    r'questionId': PropertySchema(
      id: 1,
      name: r'questionId',
      type: IsarType.long,
    ),
    r'selectedIndex': PropertySchema(
      id: 2,
      name: r'selectedIndex',
      type: IsarType.long,
    )
  },
  estimateSize: _quizAnswerEstimateSize,
  serialize: _quizAnswerSerialize,
  deserialize: _quizAnswerDeserialize,
  deserializeProp: _quizAnswerDeserializeProp,
  idName: r'id',
  indexes: {
    r'questionId': IndexSchema(
      id: 5032123391997384121,
      name: r'questionId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'questionId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _quizAnswerGetId,
  getLinks: _quizAnswerGetLinks,
  attach: _quizAnswerAttach,
  version: '3.1.0+1',
);

int _quizAnswerEstimateSize(
  QuizAnswer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _quizAnswerSerialize(
  QuizAnswer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.answeredAt);
  writer.writeLong(offsets[1], object.questionId);
  writer.writeLong(offsets[2], object.selectedIndex);
}

QuizAnswer _quizAnswerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizAnswer();
  object.answeredAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.questionId = reader.readLong(offsets[1]);
  object.selectedIndex = reader.readLong(offsets[2]);
  return object;
}

P _quizAnswerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizAnswerGetId(QuizAnswer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizAnswerGetLinks(QuizAnswer object) {
  return [];
}

void _quizAnswerAttach(IsarCollection<dynamic> col, Id id, QuizAnswer object) {
  object.id = id;
}

extension QuizAnswerByIndex on IsarCollection<QuizAnswer> {
  Future<QuizAnswer?> getByQuestionId(int questionId) {
    return getByIndex(r'questionId', [questionId]);
  }

  QuizAnswer? getByQuestionIdSync(int questionId) {
    return getByIndexSync(r'questionId', [questionId]);
  }

  Future<bool> deleteByQuestionId(int questionId) {
    return deleteByIndex(r'questionId', [questionId]);
  }

  bool deleteByQuestionIdSync(int questionId) {
    return deleteByIndexSync(r'questionId', [questionId]);
  }

  Future<List<QuizAnswer?>> getAllByQuestionId(List<int> questionIdValues) {
    final values = questionIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'questionId', values);
  }

  List<QuizAnswer?> getAllByQuestionIdSync(List<int> questionIdValues) {
    final values = questionIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'questionId', values);
  }

  Future<int> deleteAllByQuestionId(List<int> questionIdValues) {
    final values = questionIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'questionId', values);
  }

  int deleteAllByQuestionIdSync(List<int> questionIdValues) {
    final values = questionIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'questionId', values);
  }

  Future<Id> putByQuestionId(QuizAnswer object) {
    return putByIndex(r'questionId', object);
  }

  Id putByQuestionIdSync(QuizAnswer object, {bool saveLinks = true}) {
    return putByIndexSync(r'questionId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByQuestionId(List<QuizAnswer> objects) {
    return putAllByIndex(r'questionId', objects);
  }

  List<Id> putAllByQuestionIdSync(List<QuizAnswer> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'questionId', objects, saveLinks: saveLinks);
  }
}

extension QuizAnswerQueryWhereSort
    on QueryBuilder<QuizAnswer, QuizAnswer, QWhere> {
  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhere> anyQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'questionId'),
      );
    });
  }
}

extension QuizAnswerQueryWhere
    on QueryBuilder<QuizAnswer, QuizAnswer, QWhereClause> {
  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> idBetween(
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

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> questionIdEqualTo(
      int questionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'questionId',
        value: [questionId],
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> questionIdNotEqualTo(
      int questionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questionId',
              lower: [],
              upper: [questionId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questionId',
              lower: [questionId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questionId',
              lower: [questionId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questionId',
              lower: [],
              upper: [questionId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> questionIdGreaterThan(
    int questionId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'questionId',
        lower: [questionId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> questionIdLessThan(
    int questionId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'questionId',
        lower: [],
        upper: [questionId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterWhereClause> questionIdBetween(
    int lowerQuestionId,
    int upperQuestionId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'questionId',
        lower: [lowerQuestionId],
        includeLower: includeLower,
        upper: [upperQuestionId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuizAnswerQueryFilter
    on QueryBuilder<QuizAnswer, QuizAnswer, QFilterCondition> {
  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition> answeredAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition>
      answeredAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition>
      answeredAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition> answeredAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answeredAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition> idBetween(
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

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition> questionIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition>
      questionIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition>
      questionIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition> questionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition>
      selectedIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition>
      selectedIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition>
      selectedIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterFilterCondition>
      selectedIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuizAnswerQueryObject
    on QueryBuilder<QuizAnswer, QuizAnswer, QFilterCondition> {}

extension QuizAnswerQueryLinks
    on QueryBuilder<QuizAnswer, QuizAnswer, QFilterCondition> {}

extension QuizAnswerQuerySortBy
    on QueryBuilder<QuizAnswer, QuizAnswer, QSortBy> {
  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> sortByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.asc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> sortByAnsweredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.desc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> sortByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.asc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> sortByQuestionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.desc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> sortBySelectedIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedIndex', Sort.asc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> sortBySelectedIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedIndex', Sort.desc);
    });
  }
}

extension QuizAnswerQuerySortThenBy
    on QueryBuilder<QuizAnswer, QuizAnswer, QSortThenBy> {
  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> thenByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.asc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> thenByAnsweredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.desc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> thenByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.asc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> thenByQuestionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.desc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> thenBySelectedIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedIndex', Sort.asc);
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QAfterSortBy> thenBySelectedIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedIndex', Sort.desc);
    });
  }
}

extension QuizAnswerQueryWhereDistinct
    on QueryBuilder<QuizAnswer, QuizAnswer, QDistinct> {
  QueryBuilder<QuizAnswer, QuizAnswer, QDistinct> distinctByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answeredAt');
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QDistinct> distinctByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionId');
    });
  }

  QueryBuilder<QuizAnswer, QuizAnswer, QDistinct> distinctBySelectedIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedIndex');
    });
  }
}

extension QuizAnswerQueryProperty
    on QueryBuilder<QuizAnswer, QuizAnswer, QQueryProperty> {
  QueryBuilder<QuizAnswer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizAnswer, DateTime, QQueryOperations> answeredAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answeredAt');
    });
  }

  QueryBuilder<QuizAnswer, int, QQueryOperations> questionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionId');
    });
  }

  QueryBuilder<QuizAnswer, int, QQueryOperations> selectedIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedIndex');
    });
  }
}
