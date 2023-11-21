//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Entry {
  /// Returns a new [Entry] instance.
  Entry({
    required this.haveBloodPressure,
    required this.startTime,
    this.multiChoices = const [],
    this.singleChoices = const [],
    this.id,
    this.userId,
    this.remarks,
    this.systole,
    this.diastole,
    this.pulse,
    this.endTime,
  });

  bool haveBloodPressure;

  DateTime startTime;

  List<num> multiChoices;

  List<num> singleChoices;

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
  num? userId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? remarks;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? systole;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? diastole;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? pulse;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? endTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Entry &&
     other.haveBloodPressure == haveBloodPressure &&
     other.startTime == startTime &&
     other.multiChoices == multiChoices &&
     other.singleChoices == singleChoices &&
     other.id == id &&
     other.userId == userId &&
     other.remarks == remarks &&
     other.systole == systole &&
     other.diastole == diastole &&
     other.pulse == pulse &&
     other.endTime == endTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (haveBloodPressure.hashCode) +
    (startTime.hashCode) +
    (multiChoices.hashCode) +
    (singleChoices.hashCode) +
    (id == null ? 0 : id!.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (remarks == null ? 0 : remarks!.hashCode) +
    (systole == null ? 0 : systole!.hashCode) +
    (diastole == null ? 0 : diastole!.hashCode) +
    (pulse == null ? 0 : pulse!.hashCode) +
    (endTime == null ? 0 : endTime!.hashCode);

  @override
  String toString() => 'Entry[haveBloodPressure=$haveBloodPressure, startTime=$startTime, multiChoices=$multiChoices, singleChoices=$singleChoices, id=$id, userId=$userId, remarks=$remarks, systole=$systole, diastole=$diastole, pulse=$pulse, endTime=$endTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'have_blood_pressure'] = this.haveBloodPressure;
      json[r'start_time'] = this.startTime.toUtc().toIso8601String();
      json[r'multi_choices'] = this.multiChoices;
      json[r'single_choices'] = this.singleChoices;
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.userId != null) {
      json[r'user_id'] = this.userId;
    } else {
      json[r'user_id'] = null;
    }
    if (this.remarks != null) {
      json[r'remarks'] = this.remarks;
    } else {
      json[r'remarks'] = null;
    }
    if (this.systole != null) {
      json[r'systole'] = this.systole;
    } else {
      json[r'systole'] = null;
    }
    if (this.diastole != null) {
      json[r'diastole'] = this.diastole;
    } else {
      json[r'diastole'] = null;
    }
    if (this.pulse != null) {
      json[r'pulse'] = this.pulse;
    } else {
      json[r'pulse'] = null;
    }
    if (this.endTime != null) {
      json[r'end_time'] = this.endTime!.toUtc().toIso8601String();
    } else {
      json[r'end_time'] = null;
    }
    return json;
  }

  /// Returns a new [Entry] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Entry? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Entry[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Entry[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Entry(
        haveBloodPressure: mapValueOfType<bool>(json, r'have_blood_pressure')!,
        startTime: mapDateTime(json, r'start_time', '')!,
        multiChoices: json[r'multi_choices'] is List
            ? (json[r'multi_choices'] as List).cast<num>()
            : const [],
        singleChoices: json[r'single_choices'] is List
            ? (json[r'single_choices'] as List).cast<num>()
            : const [],
        id: json[r'id'] == null
            ? null
            : num.parse(json[r'id'].toString()),
        userId: json[r'user_id'] == null
            ? null
            : num.parse(json[r'user_id'].toString()),
        remarks: mapValueOfType<String>(json, r'remarks'),
        systole: mapValueOfType<double>(json, r'systole'),
        diastole: mapValueOfType<double>(json, r'diastole'),
        pulse: mapValueOfType<double>(json, r'pulse'),
        endTime: mapDateTime(json, r'end_time', ''),
      );
    }
    return null;
  }

  static List<Entry> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Entry>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Entry.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Entry> mapFromJson(dynamic json) {
    final map = <String, Entry>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Entry.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Entry-objects as value to a dart map
  static Map<String, List<Entry>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Entry>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Entry.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'have_blood_pressure',
    'start_time',
    'multi_choices',
    'single_choices',
  };
}

