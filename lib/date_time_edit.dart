/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef DateTimeEditChange = void Function(DateTime value);

/// Entries view widget
class DateTimeEdit extends StatefulWidget {
  /// Initial value
  final DateTime? initialValue;

  /// on change callback
  final DateTimeEditChange? onChange;

  const DateTimeEdit({this.initialValue, this.onChange, super.key});

  @override
  State<DateTimeEdit> createState() => _DateTimeEditState();
}

/// Entries view state
class _DateTimeEditState extends State<DateTimeEdit> {
  DateTime? currentValue;

  @override
  Widget build(BuildContext context) {
    currentValue ??= widget.initialValue ?? DateTime.now();

    return Row(
      children: [
        TextButton(
          child: Row(
            children: [
              const Icon(Icons.calendar_month),
              Text(DateFormat.yMMMd().format(currentValue!)),
            ],
          ),
          onPressed: () {
            showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(2200),
              initialDate: currentValue!,
            ).then((value) {
              if (value != null) {
                setState(() {
                  currentValue = DateTime(
                    value.year,
                    value.month,
                    value.day,
                    currentValue!.hour,
                    currentValue!.minute,
                    0,
                    0,
                    0,
                  );
                });
                if (widget.onChange != null) {
                  widget.onChange!(currentValue!);
                }
              }
            });
          },
        ),
        Container(width: 20),
        TextButton(
          child: Row(
            children: [
              const Icon(Icons.timer),
              Text(DateFormat.Hm().format(currentValue!)),
            ],
          ),
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                  hour: currentValue!.hour, minute: currentValue!.minute),
            ).then((value) {
              if (value != null) {
                setState(() {
                  currentValue = DateTime(
                    currentValue!.year,
                    currentValue!.month,
                    currentValue!.day,
                    value.hour,
                    value.minute,
                    0,
                    0,
                    0,
                  );
                });
                if (widget.onChange != null) {
                  widget.onChange!(currentValue!);
                }
              }
            });
          },
        ),
      ],
    );
  }
}
