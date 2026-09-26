// This is a generated file - do not edit.
//
// Generated from anki/search.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SearchNode_Flag extends $pb.ProtobufEnum {
  static const SearchNode_Flag FLAG_NONE =
      SearchNode_Flag._(0, _omitEnumNames ? '' : 'FLAG_NONE');
  static const SearchNode_Flag FLAG_ANY =
      SearchNode_Flag._(1, _omitEnumNames ? '' : 'FLAG_ANY');
  static const SearchNode_Flag FLAG_RED =
      SearchNode_Flag._(2, _omitEnumNames ? '' : 'FLAG_RED');
  static const SearchNode_Flag FLAG_ORANGE =
      SearchNode_Flag._(3, _omitEnumNames ? '' : 'FLAG_ORANGE');
  static const SearchNode_Flag FLAG_GREEN =
      SearchNode_Flag._(4, _omitEnumNames ? '' : 'FLAG_GREEN');
  static const SearchNode_Flag FLAG_BLUE =
      SearchNode_Flag._(5, _omitEnumNames ? '' : 'FLAG_BLUE');
  static const SearchNode_Flag FLAG_PINK =
      SearchNode_Flag._(6, _omitEnumNames ? '' : 'FLAG_PINK');
  static const SearchNode_Flag FLAG_TURQUOISE =
      SearchNode_Flag._(7, _omitEnumNames ? '' : 'FLAG_TURQUOISE');
  static const SearchNode_Flag FLAG_PURPLE =
      SearchNode_Flag._(8, _omitEnumNames ? '' : 'FLAG_PURPLE');

  static const $core.List<SearchNode_Flag> values = <SearchNode_Flag>[
    FLAG_NONE,
    FLAG_ANY,
    FLAG_RED,
    FLAG_ORANGE,
    FLAG_GREEN,
    FLAG_BLUE,
    FLAG_PINK,
    FLAG_TURQUOISE,
    FLAG_PURPLE,
  ];

  static final $core.List<SearchNode_Flag?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static SearchNode_Flag? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SearchNode_Flag._(super.value, super.name);
}

class SearchNode_Rating extends $pb.ProtobufEnum {
  static const SearchNode_Rating RATING_ANY =
      SearchNode_Rating._(0, _omitEnumNames ? '' : 'RATING_ANY');
  static const SearchNode_Rating RATING_AGAIN =
      SearchNode_Rating._(1, _omitEnumNames ? '' : 'RATING_AGAIN');
  static const SearchNode_Rating RATING_HARD =
      SearchNode_Rating._(2, _omitEnumNames ? '' : 'RATING_HARD');
  static const SearchNode_Rating RATING_GOOD =
      SearchNode_Rating._(3, _omitEnumNames ? '' : 'RATING_GOOD');
  static const SearchNode_Rating RATING_EASY =
      SearchNode_Rating._(4, _omitEnumNames ? '' : 'RATING_EASY');
  static const SearchNode_Rating RATING_BY_RESCHEDULE =
      SearchNode_Rating._(5, _omitEnumNames ? '' : 'RATING_BY_RESCHEDULE');

  static const $core.List<SearchNode_Rating> values = <SearchNode_Rating>[
    RATING_ANY,
    RATING_AGAIN,
    RATING_HARD,
    RATING_GOOD,
    RATING_EASY,
    RATING_BY_RESCHEDULE,
  ];

  static final $core.List<SearchNode_Rating?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static SearchNode_Rating? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SearchNode_Rating._(super.value, super.name);
}

class SearchNode_CardState extends $pb.ProtobufEnum {
  static const SearchNode_CardState CARD_STATE_NEW =
      SearchNode_CardState._(0, _omitEnumNames ? '' : 'CARD_STATE_NEW');
  static const SearchNode_CardState CARD_STATE_LEARN =
      SearchNode_CardState._(1, _omitEnumNames ? '' : 'CARD_STATE_LEARN');
  static const SearchNode_CardState CARD_STATE_REVIEW =
      SearchNode_CardState._(2, _omitEnumNames ? '' : 'CARD_STATE_REVIEW');
  static const SearchNode_CardState CARD_STATE_DUE =
      SearchNode_CardState._(3, _omitEnumNames ? '' : 'CARD_STATE_DUE');
  static const SearchNode_CardState CARD_STATE_SUSPENDED =
      SearchNode_CardState._(4, _omitEnumNames ? '' : 'CARD_STATE_SUSPENDED');
  static const SearchNode_CardState CARD_STATE_BURIED =
      SearchNode_CardState._(5, _omitEnumNames ? '' : 'CARD_STATE_BURIED');

  static const $core.List<SearchNode_CardState> values = <SearchNode_CardState>[
    CARD_STATE_NEW,
    CARD_STATE_LEARN,
    CARD_STATE_REVIEW,
    CARD_STATE_DUE,
    CARD_STATE_SUSPENDED,
    CARD_STATE_BURIED,
  ];

  static final $core.List<SearchNode_CardState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static SearchNode_CardState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SearchNode_CardState._(super.value, super.name);
}

class SearchNode_FieldSearchMode extends $pb.ProtobufEnum {
  static const SearchNode_FieldSearchMode FIELD_SEARCH_MODE_NORMAL =
      SearchNode_FieldSearchMode._(
          0, _omitEnumNames ? '' : 'FIELD_SEARCH_MODE_NORMAL');
  static const SearchNode_FieldSearchMode FIELD_SEARCH_MODE_REGEX =
      SearchNode_FieldSearchMode._(
          1, _omitEnumNames ? '' : 'FIELD_SEARCH_MODE_REGEX');
  static const SearchNode_FieldSearchMode FIELD_SEARCH_MODE_NOCOMBINING =
      SearchNode_FieldSearchMode._(
          2, _omitEnumNames ? '' : 'FIELD_SEARCH_MODE_NOCOMBINING');

  static const $core.List<SearchNode_FieldSearchMode> values =
      <SearchNode_FieldSearchMode>[
    FIELD_SEARCH_MODE_NORMAL,
    FIELD_SEARCH_MODE_REGEX,
    FIELD_SEARCH_MODE_NOCOMBINING,
  ];

  static final $core.List<SearchNode_FieldSearchMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static SearchNode_FieldSearchMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SearchNode_FieldSearchMode._(super.value, super.name);
}

class SearchNode_Group_Joiner extends $pb.ProtobufEnum {
  static const SearchNode_Group_Joiner AND =
      SearchNode_Group_Joiner._(0, _omitEnumNames ? '' : 'AND');
  static const SearchNode_Group_Joiner OR =
      SearchNode_Group_Joiner._(1, _omitEnumNames ? '' : 'OR');

  static const $core.List<SearchNode_Group_Joiner> values =
      <SearchNode_Group_Joiner>[
    AND,
    OR,
  ];

  static final $core.List<SearchNode_Group_Joiner?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static SearchNode_Group_Joiner? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SearchNode_Group_Joiner._(super.value, super.name);
}

class BrowserColumns_Sorting extends $pb.ProtobufEnum {
  static const BrowserColumns_Sorting SORTING_NONE =
      BrowserColumns_Sorting._(0, _omitEnumNames ? '' : 'SORTING_NONE');
  static const BrowserColumns_Sorting SORTING_ASCENDING =
      BrowserColumns_Sorting._(1, _omitEnumNames ? '' : 'SORTING_ASCENDING');
  static const BrowserColumns_Sorting SORTING_DESCENDING =
      BrowserColumns_Sorting._(2, _omitEnumNames ? '' : 'SORTING_DESCENDING');

  static const $core.List<BrowserColumns_Sorting> values =
      <BrowserColumns_Sorting>[
    SORTING_NONE,
    SORTING_ASCENDING,
    SORTING_DESCENDING,
  ];

  static final $core.List<BrowserColumns_Sorting?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static BrowserColumns_Sorting? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BrowserColumns_Sorting._(super.value, super.name);
}

class BrowserColumns_Alignment extends $pb.ProtobufEnum {
  static const BrowserColumns_Alignment ALIGNMENT_START =
      BrowserColumns_Alignment._(0, _omitEnumNames ? '' : 'ALIGNMENT_START');
  static const BrowserColumns_Alignment ALIGNMENT_CENTER =
      BrowserColumns_Alignment._(1, _omitEnumNames ? '' : 'ALIGNMENT_CENTER');

  static const $core.List<BrowserColumns_Alignment> values =
      <BrowserColumns_Alignment>[
    ALIGNMENT_START,
    ALIGNMENT_CENTER,
  ];

  static final $core.List<BrowserColumns_Alignment?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static BrowserColumns_Alignment? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BrowserColumns_Alignment._(super.value, super.name);
}

class BrowserRow_Color extends $pb.ProtobufEnum {
  static const BrowserRow_Color COLOR_DEFAULT =
      BrowserRow_Color._(0, _omitEnumNames ? '' : 'COLOR_DEFAULT');
  static const BrowserRow_Color COLOR_MARKED =
      BrowserRow_Color._(1, _omitEnumNames ? '' : 'COLOR_MARKED');
  static const BrowserRow_Color COLOR_SUSPENDED =
      BrowserRow_Color._(2, _omitEnumNames ? '' : 'COLOR_SUSPENDED');
  static const BrowserRow_Color COLOR_FLAG_RED =
      BrowserRow_Color._(3, _omitEnumNames ? '' : 'COLOR_FLAG_RED');
  static const BrowserRow_Color COLOR_FLAG_ORANGE =
      BrowserRow_Color._(4, _omitEnumNames ? '' : 'COLOR_FLAG_ORANGE');
  static const BrowserRow_Color COLOR_FLAG_GREEN =
      BrowserRow_Color._(5, _omitEnumNames ? '' : 'COLOR_FLAG_GREEN');
  static const BrowserRow_Color COLOR_FLAG_BLUE =
      BrowserRow_Color._(6, _omitEnumNames ? '' : 'COLOR_FLAG_BLUE');
  static const BrowserRow_Color COLOR_FLAG_PINK =
      BrowserRow_Color._(7, _omitEnumNames ? '' : 'COLOR_FLAG_PINK');
  static const BrowserRow_Color COLOR_FLAG_TURQUOISE =
      BrowserRow_Color._(8, _omitEnumNames ? '' : 'COLOR_FLAG_TURQUOISE');
  static const BrowserRow_Color COLOR_FLAG_PURPLE =
      BrowserRow_Color._(9, _omitEnumNames ? '' : 'COLOR_FLAG_PURPLE');
  static const BrowserRow_Color COLOR_BURIED =
      BrowserRow_Color._(10, _omitEnumNames ? '' : 'COLOR_BURIED');

  static const $core.List<BrowserRow_Color> values = <BrowserRow_Color>[
    COLOR_DEFAULT,
    COLOR_MARKED,
    COLOR_SUSPENDED,
    COLOR_FLAG_RED,
    COLOR_FLAG_ORANGE,
    COLOR_FLAG_GREEN,
    COLOR_FLAG_BLUE,
    COLOR_FLAG_PINK,
    COLOR_FLAG_TURQUOISE,
    COLOR_FLAG_PURPLE,
    COLOR_BURIED,
  ];

  static final $core.List<BrowserRow_Color?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 10);
  static BrowserRow_Color? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BrowserRow_Color._(super.value, super.name);
}

class BrowserRow_Cell_TextElideMode extends $pb.ProtobufEnum {
  static const BrowserRow_Cell_TextElideMode ElideLeft =
      BrowserRow_Cell_TextElideMode._(0, _omitEnumNames ? '' : 'ElideLeft');
  static const BrowserRow_Cell_TextElideMode ElideRight =
      BrowserRow_Cell_TextElideMode._(1, _omitEnumNames ? '' : 'ElideRight');
  static const BrowserRow_Cell_TextElideMode ElideMiddle =
      BrowserRow_Cell_TextElideMode._(2, _omitEnumNames ? '' : 'ElideMiddle');
  static const BrowserRow_Cell_TextElideMode ElideNone =
      BrowserRow_Cell_TextElideMode._(3, _omitEnumNames ? '' : 'ElideNone');

  static const $core.List<BrowserRow_Cell_TextElideMode> values =
      <BrowserRow_Cell_TextElideMode>[
    ElideLeft,
    ElideRight,
    ElideMiddle,
    ElideNone,
  ];

  static final $core.List<BrowserRow_Cell_TextElideMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static BrowserRow_Cell_TextElideMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BrowserRow_Cell_TextElideMode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
