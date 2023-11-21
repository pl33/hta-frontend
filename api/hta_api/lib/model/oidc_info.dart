//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class OidcInfo {
  /// Returns a new [OidcInfo] instance.
  OidcInfo({
    required this.discoveryUrl,
    this.clientId,
    this.clientSecret,
  });

  String discoveryUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? clientId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? clientSecret;

  @override
  bool operator ==(Object other) => identical(this, other) || other is OidcInfo &&
     other.discoveryUrl == discoveryUrl &&
     other.clientId == clientId &&
     other.clientSecret == clientSecret;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (discoveryUrl.hashCode) +
    (clientId == null ? 0 : clientId!.hashCode) +
    (clientSecret == null ? 0 : clientSecret!.hashCode);

  @override
  String toString() => 'OidcInfo[discoveryUrl=$discoveryUrl, clientId=$clientId, clientSecret=$clientSecret]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'discovery_url'] = this.discoveryUrl;
    if (this.clientId != null) {
      json[r'client_id'] = this.clientId;
    } else {
      json[r'client_id'] = null;
    }
    if (this.clientSecret != null) {
      json[r'client_secret'] = this.clientSecret;
    } else {
      json[r'client_secret'] = null;
    }
    return json;
  }

  /// Returns a new [OidcInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static OidcInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "OidcInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "OidcInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return OidcInfo(
        discoveryUrl: mapValueOfType<String>(json, r'discovery_url')!,
        clientId: mapValueOfType<String>(json, r'client_id'),
        clientSecret: mapValueOfType<String>(json, r'client_secret'),
      );
    }
    return null;
  }

  static List<OidcInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <OidcInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = OidcInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, OidcInfo> mapFromJson(dynamic json) {
    final map = <String, OidcInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = OidcInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of OidcInfo-objects as value to a dart map
  static Map<String, List<OidcInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<OidcInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = OidcInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'discovery_url',
  };
}

