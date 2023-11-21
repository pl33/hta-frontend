//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CategorySingleChoice {
  /// Returns a new [CategorySingleChoice] instance.
  CategorySingleChoice({
    required this.title,
    this.id,
    this.groupId,
    this.description,
  });

  String title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? groupId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CategorySingleChoice &&
     other.title == title &&
     other.id == id &&
     other.groupId == groupId &&
     other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (id == null ? 0 : id!.hashCode) +
    (groupId == null ? 0 : groupId!.hashCode) +
    (description == null ? 0 : description!.hashCode);

  @override
  String toString() => 'CategorySingleChoice[title=$title, id=$id, groupId=$groupId, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.groupId != null) {
      json[r'group_id'] = this.groupId;
    } else {
      json[r'group_id'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    return json;
  }

  /// Returns a new [CategorySingleChoice] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CategorySingleChoice? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CategorySingleChoice[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CategorySingleChoice[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CategorySingleChoice(
        title: mapValueOfType<String>(json, r'title')!,
        id: json[r'id'] == null
            ? null
            : num.parse(json[r'id'].toString()),
        groupId: json[r'group_id'] == null
            ? null
            : num.parse(json[r'group_id'].toString()),
        description: mapValueOfType<String>(json, r'description'),
      );
    }
    return null;
  }

  static List<CategorySingleChoice> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CategorySingleChoice>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CategorySingleChoice.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CategorySingleChoice> mapFromJson(dynamic json) {
    final map = <String, CategorySingleChoice>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CategorySingleChoice.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CategorySingleChoice-objects as value to a dart map
  static Map<String, List<CategorySingleChoice>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CategorySingleChoice>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CategorySingleChoice.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
  };
}

