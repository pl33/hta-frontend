/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/material.dart';

/// Configuration for _showEditDialog
class TextFieldConfig {
  /// Label text of the text field
  String label;
  /// Maximum lines of the text field
  int? maxLines;
  /// Initial text of the text field
  String? initialValue;
  /// Prefix icon
  Widget? prefixIcon;

  TextFieldConfig({required this.label, this.maxLines = 1, this.initialValue, this.prefixIcon});
}

/// _showEditDialog status code
enum ShowEditDialogStatus {
  canceled,
  delete,
  ok,
}

/// _showEditDialog result
class ShowEditDialogResult {
  /// Status code
  ShowEditDialogStatus status;
  /// Map of the strings
  Map<String, String>? values;

  ShowEditDialogResult({required this.status, this.values});

  /// Is status OK?
  bool isOk() { return status == ShowEditDialogStatus.ok; }
  /// Is status DELETE?
  bool isDelete() { return status == ShowEditDialogStatus.delete; }
}

/// Show a dialog for editing variables
///
/// [title] defines the dialog title
///
/// [textFieldConfigs] is a map of the configuration. The key will be reflected
/// in the returned result.
Future<ShowEditDialogResult> showEditDialog(BuildContext context, String title, Map<String, TextFieldConfig> textFieldConfigs, {bool hasDelete = false}) async
{
  final Map<String, TextEditingController> editingControllers = {};
  final List<TextField> textFields = [];
  textFieldConfigs.forEach((key, value) {
    editingControllers[key] = TextEditingController(text: value.initialValue ?? "");
    textFields.add(
      TextField(
        controller: editingControllers[key],
        decoration: InputDecoration(
          prefixIcon: value.prefixIcon,
          labelText: value.label,
          border: const OutlineInputBorder(),
        ),
        maxLines: value.maxLines,
      ),
    );
  });

  final buttonConfig = [
    (ShowEditDialogStatus.ok, Icons.check, Colors.green, "OK"),
    (ShowEditDialogStatus.canceled, Icons.cancel, Colors.grey, "Cancel"),
  ];
  if (hasDelete) {
    buttonConfig.add(
        (ShowEditDialogStatus.delete, Icons.delete, Colors.red, "Delete")
    );
  }

  final result = await showDialog<ShowEditDialogStatus?>(
      context: context,
      builder: (BuildContext dialogContext) {
        final List<Widget> buttons = [];
        for (var (code, icon, color, label) in buttonConfig) {
          buttons.add(
              ElevatedButton.icon(
                icon: Icon(icon),
                label: Text(label),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                ),
                onPressed: () {
                  Navigator.pop(dialogContext, code);
                },
              )
          );
        }

        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title: Text(title),
          content: Column(
            children: [
              ...textFields,
            ],
          ),
          actions: buttons,
        );
      }
  );

  switch (result ?? ShowEditDialogStatus.canceled) {
    case ShowEditDialogStatus.ok:
      {
        final Map<String, String> values = {};
        editingControllers.forEach((key, value) {
          values[key] = value.text;
        });
        return ShowEditDialogResult(status: ShowEditDialogStatus.ok, values: values);
      }
    case ShowEditDialogStatus.canceled:
      return ShowEditDialogResult(status: ShowEditDialogStatus.canceled);
    case ShowEditDialogStatus.delete:
      return ShowEditDialogResult(status: ShowEditDialogStatus.delete);
    default:
      return ShowEditDialogResult(status: ShowEditDialogStatus.canceled);
  }
}

/// Show a dialog to confirm the deletion
Future<bool> showConfirmDeleteDialog(BuildContext context) async {
  final confirm = await showDialog<bool?>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure to delete the item?'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text("Delete"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(dialogContext, true);
            },
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.cancel),
            label: const Text("Cancel"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
          ),
        ],
      );
    },
  );

  return confirm ?? false;
}
