// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransciptEntryCollection on Isar {
  IsarCollection<TransciptEntry> get transciptEntrys => this.collection();
}

const TransciptEntrySchema = CollectionSchema(
  name: r'TransciptEntry',
  id: 2407119330741746682,
  properties: {
    r'audioPath': PropertySchema(
      id: 0,
      name: r'audioPath',
      type: IsarType.string,
    ),
    r'cleanedTranscript': PropertySchema(
      id: 1,
      name: r'cleanedTranscript',
      type: IsarType.string,
    ),
    r'cleanedWordCount': PropertySchema(
      id: 2,
      name: r'cleanedWordCount',
      type: IsarType.long,
    ),
    r'cleanupMode': PropertySchema(
      id: 3,
      name: r'cleanupMode',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'durationSeconds': PropertySchema(
      id: 5,
      name: r'durationSeconds',
      type: IsarType.long,
    ),
    r'formattedDuration': PropertySchema(
      id: 6,
      name: r'formattedDuration',
      type: IsarType.string,
    ),
    r'rawTranscript': PropertySchema(
      id: 7,
      name: r'rawTranscript',
      type: IsarType.string,
    ),
    r'rawWordCount': PropertySchema(
      id: 8,
      name: r'rawWordCount',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 9,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _transciptEntryEstimateSize,
  serialize: _transciptEntrySerialize,
  deserialize: _transciptEntryDeserialize,
  deserializeProp: _transciptEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _transciptEntryGetId,
  getLinks: _transciptEntryGetLinks,
  attach: _transciptEntryAttach,
  version: '3.1.0+1',
);

int _transciptEntryEstimateSize(
  TransciptEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.audioPath.length * 3;
  {
    final value = object.cleanedTranscript;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cleanupMode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.formattedDuration.length * 3;
  bytesCount += 3 + object.rawTranscript.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _transciptEntrySerialize(
  TransciptEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.audioPath);
  writer.writeString(offsets[1], object.cleanedTranscript);
  writer.writeLong(offsets[2], object.cleanedWordCount);
  writer.writeString(offsets[3], object.cleanupMode);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeLong(offsets[5], object.durationSeconds);
  writer.writeString(offsets[6], object.formattedDuration);
  writer.writeString(offsets[7], object.rawTranscript);
  writer.writeLong(offsets[8], object.rawWordCount);
  writer.writeString(offsets[9], object.title);
}

TransciptEntry _transciptEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransciptEntry();
  object.audioPath = reader.readString(offsets[0]);
  object.cleanedTranscript = reader.readStringOrNull(offsets[1]);
  object.cleanupMode = reader.readStringOrNull(offsets[3]);
  object.createdAt = reader.readDateTime(offsets[4]);
  object.durationSeconds = reader.readLong(offsets[5]);
  object.id = id;
  object.rawTranscript = reader.readString(offsets[7]);
  return object;
}

P _transciptEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _transciptEntryGetId(TransciptEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transciptEntryGetLinks(TransciptEntry object) {
  return [];
}

void _transciptEntryAttach(
    IsarCollection<dynamic> col, Id id, TransciptEntry object) {
  object.id = id;
}

extension TransciptEntryQueryWhereSort
    on QueryBuilder<TransciptEntry, TransciptEntry, QWhere> {
  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension TransciptEntryQueryWhere
    on QueryBuilder<TransciptEntry, TransciptEntry, QWhereClause> {
  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause> idBetween(
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

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransciptEntryQueryFilter
    on QueryBuilder<TransciptEntry, TransciptEntry, QFilterCondition> {
  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      audioPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cleanedTranscript',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cleanedTranscript',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cleanedTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cleanedTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cleanedTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cleanedTranscript',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cleanedTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cleanedTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cleanedTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cleanedTranscript',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cleanedTranscript',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedTranscriptIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cleanedTranscript',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedWordCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cleanedWordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedWordCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cleanedWordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedWordCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cleanedWordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanedWordCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cleanedWordCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cleanupMode',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cleanupMode',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cleanupMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cleanupMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cleanupMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cleanupMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cleanupMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cleanupMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cleanupMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cleanupMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cleanupMode',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      cleanupModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cleanupMode',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      durationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      durationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      durationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      durationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formattedDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formattedDuration',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      formattedDurationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formattedDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
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

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rawTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rawTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rawTranscript',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rawTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rawTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rawTranscript',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rawTranscript',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawTranscript',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawTranscriptIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rawTranscript',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawWordCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawWordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawWordCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rawWordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawWordCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rawWordCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      rawWordCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rawWordCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension TransciptEntryQueryObject
    on QueryBuilder<TransciptEntry, TransciptEntry, QFilterCondition> {}

extension TransciptEntryQueryLinks
    on QueryBuilder<TransciptEntry, TransciptEntry, QFilterCondition> {}

extension TransciptEntryQuerySortBy
    on QueryBuilder<TransciptEntry, TransciptEntry, QSortBy> {
  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> sortByAudioPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByAudioPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByCleanedTranscript() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanedTranscript', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByCleanedTranscriptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanedTranscript', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByCleanedWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanedWordCount', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByCleanedWordCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanedWordCount', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByCleanupMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanupMode', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByCleanupModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanupMode', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByFormattedDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDuration', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByFormattedDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDuration', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByRawTranscript() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawTranscript', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByRawTranscriptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawTranscript', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByRawWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawWordCount', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      sortByRawWordCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawWordCount', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TransciptEntryQuerySortThenBy
    on QueryBuilder<TransciptEntry, TransciptEntry, QSortThenBy> {
  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> thenByAudioPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByAudioPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByCleanedTranscript() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanedTranscript', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByCleanedTranscriptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanedTranscript', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByCleanedWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanedWordCount', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByCleanedWordCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanedWordCount', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByCleanupMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanupMode', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByCleanupModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanupMode', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByFormattedDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDuration', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByFormattedDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDuration', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByRawTranscript() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawTranscript', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByRawTranscriptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawTranscript', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByRawWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawWordCount', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy>
      thenByRawWordCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawWordCount', Sort.desc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TransciptEntryQueryWhereDistinct
    on QueryBuilder<TransciptEntry, TransciptEntry, QDistinct> {
  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct> distinctByAudioPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct>
      distinctByCleanedTranscript({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cleanedTranscript',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct>
      distinctByCleanedWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cleanedWordCount');
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct> distinctByCleanupMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cleanupMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct>
      distinctByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSeconds');
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct>
      distinctByFormattedDuration({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formattedDuration',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct>
      distinctByRawTranscript({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rawTranscript',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct>
      distinctByRawWordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rawWordCount');
    });
  }

  QueryBuilder<TransciptEntry, TransciptEntry, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension TransciptEntryQueryProperty
    on QueryBuilder<TransciptEntry, TransciptEntry, QQueryProperty> {
  QueryBuilder<TransciptEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransciptEntry, String, QQueryOperations> audioPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioPath');
    });
  }

  QueryBuilder<TransciptEntry, String?, QQueryOperations>
      cleanedTranscriptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cleanedTranscript');
    });
  }

  QueryBuilder<TransciptEntry, int, QQueryOperations>
      cleanedWordCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cleanedWordCount');
    });
  }

  QueryBuilder<TransciptEntry, String?, QQueryOperations>
      cleanupModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cleanupMode');
    });
  }

  QueryBuilder<TransciptEntry, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TransciptEntry, int, QQueryOperations>
      durationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSeconds');
    });
  }

  QueryBuilder<TransciptEntry, String, QQueryOperations>
      formattedDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formattedDuration');
    });
  }

  QueryBuilder<TransciptEntry, String, QQueryOperations>
      rawTranscriptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rawTranscript');
    });
  }

  QueryBuilder<TransciptEntry, int, QQueryOperations> rawWordCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rawWordCount');
    });
  }

  QueryBuilder<TransciptEntry, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
