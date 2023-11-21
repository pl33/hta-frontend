//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CategoryMultiChoice {
  /// Returns a new [CategoryMultiChoice] instance.
  CategoryMultiChoice({
    required this.title,
    this.id,
    this.categoryId,
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
  num? categoryId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CategoryMultiChoice &&
     other.title == title &&
     other.id == id &&
     other.categoryId == categoryId &&
     other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (id == null ? 0 : id!.hashCode) +
    (categoryId == null ? 0 : categoryId!.hashCode) +
    (description == null ? 0 : description!.hashCode);

  @override
  String toString() => 'CategoryMultiChoice[title=$title, id=$id, categoryId=$categoryId, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.categoryId != null) {
      json[r'category_id'] = this.categoryId;
    } else {
      json[r'category_id'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    return json;
  }

  /// Returns a new [CategoryMultiChoice] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CategoryMultiChoice? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CategoryMultiChoice[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CategoryMultiChoice[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CategoryMultiChoice(
        title: mapValueOfType<String>(json, r'title')!,
        id: json[r'id'] == null
            ? null
            : num.parse(json[r'id'].toString()),
        categoryId: json[r'category_id'] == null
            ? null
            : num.parse(json[r'category_id'].toString()),
        description: mapValueOfType<String>(json, r'description'),
      );
    }
    return null;
  }

  static List<CategoryMultiChoice> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CategoryMultiChoice>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CategoryMultiChoice.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CategoryMultiChoice> mapFromJson(dynamic json) {
    final map = <String, CategoryMultiChoice>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CategoryMultiChoice.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CategoryMultiChoice-objects as value to a dart map
  static Map<String, List<CategoryMultiChoice>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CategoryMultiChoice>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CategoryMultiChoice.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
  };
}

