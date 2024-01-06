/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hta_api/api.dart' as api;
import 'package:hta_frontend_flutter/connect_server.dart';
import 'package:hta_frontend_flutter/date_time_edit.dart';
import 'package:intl/intl.dart';

import 'categories_proxy.dart';
import 'dialogs.dart';
import 'main.dart';

class EntriesPage extends StatefulWidget {
  final GlobalAppState appState;

  static const String route = "/entries";

  const EntriesPage({required this.appState, super.key});

  @override
  State<StatefulWidget> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  /// Handles login state changes
  void _onLoginStateChangeCb() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.appState.loginStateValue.addListener(_onLoginStateChangeCb);
  }

  @override
  void dispose() {
    super.dispose();
    widget.appState.loginStateValue.removeListener(_onLoginStateChangeCb);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appState.isLoggedIn()) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Health Entries"),
        ),
        drawer: widget.appState.makeDefaultDrawer(context),
        body: EntriesView(
          controller: widget.appState.entriesViewController!,
          categoriesProxy: widget.appState.categoriesProxy!,
        ),
        floatingActionButton: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("Add"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.primaries.first,
          ),
          onPressed: () {
            entryShowNewDialog(context, widget.appState.entriesViewController!,
                widget.appState.categoriesProxy!);
          },
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text("Not logged in. Redirecting."),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(ConnectServerPage.route);
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      );
    }
  }
}

/// State storage of an entry item
class EntryState {
  /// Entry data
  final api.Entry entry;

  /// Card widget is expanded
  bool isExpanded;

  EntryState({required this.entry, this.isExpanded = false});
}

/// View controller for entry card widgets and entry list
class EntriesViewController with ChangeNotifier {
  /// List of states
  ///
  /// It caches the currently loaded items starting with the most recent ones.
  final List<EntryState> _cache;

  /// API client
  final api.ApiClient _client;

  /// True if data is fetched from the API
  bool isLoading = false;

  EntriesViewController({required api.ApiClient client})
      : _client = client,
        _cache = [];

  /// Get the length of the cached items
  int get length => _cache.length;

  /// Retrieve the entry state of a certain index
  EntryState? getEntryState(int index) {
    if (index < length) {
      return _cache[index];
    } else {
      return null;
    }
  }

  /// Clear the cache
  void invalidate() {
    _cache.clear();
    notifyListeners();
  }

  /// Load the next [limit] entries to the cache
  Future<void> loadNext({int limit = 20}) async {
    // TODO: Handle the case when a new entry was added in the meantime

    isLoading = true;
    notifyListeners();
    final apiWorker = api.EntryApi(_client);
    final items =
        await apiWorker.entriesGet(first: _cache.length, limit: limit);
    if (items != null) {
      for (var element in items) {
        if (_cache.where((e) => e.entry.id == element.id).isEmpty) {
          _cache.add(EntryState(entry: element));
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> create(api.Entry entry) async {
    final apiWorker = api.EntryApi(_client);
    final newItem = await apiWorker.entriesPost(body: entry);
    if (newItem != null) {
      _cache.insert(0, EntryState(entry: newItem));
      notifyListeners();
    }
  }

  Future<void> update(int id, api.Entry entry) async {
    final index = _cache.indexWhere((e) => e.entry.id == id);
    if (index > -1) {
      final apiWorker = api.EntryApi(_client);
      final updatedItem = await apiWorker.entriesIdPut(id, body: entry);
      if (updatedItem != null) {
        _cache[index] = EntryState(
            entry: updatedItem, isExpanded: _cache[index].isExpanded);
        notifyListeners();
      }
    }
  }

  Future<void> delete(int id) async {
    final index = _cache.indexWhere((e) => e.entry.id == id);
    if (index > -1) {
      final apiWorker = api.EntryApi(_client);
      await apiWorker.entriesIdDelete(id);
      _cache.removeAt(index);
      notifyListeners();
    }
  }
}

/// Entries view widget
class EntriesView extends StatefulWidget {
  final EntriesViewController controller;

  final CategoriesProxy categoriesProxy;

  const EntriesView(
      {required this.controller, required this.categoriesProxy, super.key});

  @override
  State<EntriesView> createState() => _EntriesViewState();
}

/// Entries view state
class _EntriesViewState extends State<EntriesView> {
  final ScrollController _scrollController = ScrollController();

  static const double _scrollLoadThreshold = 0.8;

  /// Callback invoked when the widget controller has a new event
  void _onControllerUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.invalidate();
    widget.controller.loadNext().onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Cannot load entries: ${error as Exception}")));
    });
    widget.controller.addListener(_onControllerUpdate);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_onControllerUpdate);
  }

  /// The callback is invoked if the user scrolls to the end of the list. It
  /// automatically triggers a fetch of the next entries.
  void _scrollListener() {
    if ((_scrollController.offset >=
            (_scrollController.position.maxScrollExtent *
                _scrollLoadThreshold)) &&
        !_scrollController.position.outOfRange) {
      widget.controller.loadNext();
    }
  }

  /// Truncate remark texts with ellipsis
  static String _truncateWithEllipsis(String str, int max) {
    return (str.length <= max) ? str : "${str.substring(0, max)}...";
  }

  /// Widget builder for the list view
  Widget? _listItemBuilder(BuildContext context, int index) {
    if (index < widget.controller.length) {
      final entryState = widget.controller.getEntryState(index)!;

      final timeWidget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Spacer(),
          const Icon(Icons.calendar_month),
          Text(DateFormat.yMMMd().format(entryState.entry.startTime)),
          Container(width: 20),
          const Icon(Icons.timer),
          Text(DateFormat.Hm().format(entryState.entry.startTime)),
          const Spacer(),
        ],
      );

      Widget overviewWidget;
      if (entryState.entry.haveBloodPressure) {
        overviewWidget = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.thermostat),
                const SizedBox(
                    child: Text(
                  "SYS:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                SizedBox(child: Text("${entryState.entry.systole}")),
              ],
            ),
            Container(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.thermostat),
                const SizedBox(
                    child: Text(
                  "DIA:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                SizedBox(child: Text("${entryState.entry.diastole}")),
              ],
            ),
            Container(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.heart_broken),
                const SizedBox(
                    child: Text(
                  "Pulse:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                SizedBox(child: Text("${entryState.entry.pulse}")),
              ],
            ),
            const Spacer(),
          ],
        );
      } else {
        overviewWidget = Text((entryState.entry.remarks != null)
            ? _truncateWithEllipsis(entryState.entry.remarks!, 25)
            : "-");
      }

      final editButton = IconButton(
        onPressed: () {
          _entryShowEditDialog(context, entryState.entry);
        },
        icon: const Icon(Icons.edit),
      );

      final List<Widget> columns = [
        ListTile(
          leading: Icon(entryState.entry.haveBloodPressure
              ? Icons.monitor_heart_rounded
              : Icons.description_rounded),
          title: timeWidget,
          subtitle: overviewWidget,
          onTap: () {
            entryState.isExpanded = !entryState.isExpanded;
            setState(() {});
          },
          trailing: editButton,
        ),
      ];

      if (entryState.isExpanded) {
        columns.add(const Divider());
        if (entryState.entry.remarks != null) {
          columns.add(
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100, child: Text("Remarks:")),
                  SizedBox(child: Text(entryState.entry.remarks!)),
                ],
              ),
            ),
          );
        }
      }

      return Card(
          child: Column(
        children: columns,
      ));
    } else if ((index == widget.controller.length) &&
        widget.controller.isLoading) {
      return const Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            Text("Loading ..."),
          ],
        ),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _listItemBuilder,
      itemCount:
          widget.controller.length + (widget.controller.isLoading ? 1 : 0),
      controller: _scrollController,
    );
  }

  /// Shows the dialog for editing existing items
  void _entryShowEditDialog(BuildContext context, api.Entry entry) {
    final controller =
        _EntryEditViewController(widget.categoriesProxy, initialValue: entry);
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return _EntryEditView(
        title: "Edit Entry",
        controller: controller,
        categoriesProxy: widget.categoriesProxy,
        hasDelete: true,
      );
    }));
    controller.future.then((result) {
      if (result.isSave()) {
        widget.controller.update(entry.id! as int, result.entry!).then((value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Updated entry")));
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Cannot update entry: ${error as Exception}")));
        });
      } else if (result.isDelete()) {
        widget.controller.delete(entry.id! as int).then((value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Deleted entry")));
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Cannot delete entry: ${error as Exception}")));
        });
      }
    });
  }
}

/// Shows the dialog for creating new items
void entryShowNewDialog(BuildContext context,
    EntriesViewController entriesController, CategoriesProxy categoriesProxy) {
  final controller = _EntryEditViewController(categoriesProxy);
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
    return _EntryEditView(
        title: "New Entry",
        controller: controller,
        categoriesProxy: categoriesProxy);
  }));
  controller.future.then((result) {
    if (result.isSave()) {
      entriesController.create(result.entry!).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Created entry")));
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Cannot create entry: ${error as Exception}")));
      });
    }
  });
}

/// Result codes of the edit view widget
enum _EntryEditViewResultCode {
  canceled,
  save,
  delete,
}

/// Result of the edit view widget
class _EntryEditViewResult {
  /// Result code
  final _EntryEditViewResultCode code;

  /// On code = save, the ready-to-use entry for API operations.
  final api.Entry? entry;

  _EntryEditViewResult({required this.code, this.entry}) {
    if ((code == _EntryEditViewResultCode.save) && (entry == null)) {
      throw "If the code is saved, entry must not be null";
    }
  }

  /// Check if the result code was Save
  bool isSave() {
    return (code == _EntryEditViewResultCode.save);
  }

  /// Check if the result code was Canceled
  bool isCanceled() {
    return (code == _EntryEditViewResultCode.canceled);
  }

  /// Check if the result code was Delete
  bool isDelete() {
    return (code == _EntryEditViewResultCode.delete);
  }
}

/// Data controller for the entry edit view widget
class _EntryEditViewController {
  final _completer = Completer<_EntryEditViewResult>();

  final remarksController = TextEditingController();
  final systoleController = TextEditingController();
  final diastoleController = TextEditingController();
  final pulseController = TextEditingController();
  bool hasBloodPressure = true;
  DateTime startTime = DateTime.now();
  DateTime? endTime;
  List<int> multiChoices = [];
  Map<int, int?> singleChoices = {};

  _EntryEditViewController(CategoriesProxy categoriesProxy,
      {api.Entry? initialValue}) {
    if (initialValue != null) {
      remarksController.text = initialValue.remarks ?? "";
      systoleController.text = (initialValue.systole ?? 0.0).toString();
      diastoleController.text = (initialValue.diastole ?? 0.0).toString();
      pulseController.text = (initialValue.pulse ?? 0.0).toString();
      hasBloodPressure = initialValue.haveBloodPressure;
      startTime = initialValue.startTime;
      // If year is <= 1900, timestamp was probably 0 or null
      if ((initialValue.endTime?.year ?? 0) > 1900) {
        endTime = initialValue.endTime;
      } else {
        endTime = null;
      }
      multiChoices = initialValue.multiChoices.map(
        (e) {
          return e as int;
        },
      ).toList();
      for (var category in categoriesProxy.getCategories()) {
        final categoryId = category.id as int;
        for (var group in categoriesProxy.getSingleChoiceGroups(categoryId)) {
          final groupId = group.id as int;
          singleChoices[groupId] = null;
          for (var item in categoriesProxy.getSingleChoiceItems(groupId)) {
            final itemId = item.id as int;
            if (initialValue.singleChoices.contains(itemId)) {
              singleChoices[groupId] = itemId;
            }
          }
        }
      }
    }
  }

  /// Complete the view with Cancel
  void completeCancel() {
    _completer.complete(
      _EntryEditViewResult(code: _EntryEditViewResultCode.canceled),
    );
  }

  /// Complete the view with Delete
  void completeDelete() {
    _completer.complete(
      _EntryEditViewResult(code: _EntryEditViewResultCode.delete),
    );
  }

  /// Complete the view with Save and store the ready-to-use entry for API operations
  void completeSave() {
    double? diastole;
    try {
      diastole = double.parse(diastoleController.text);
    } on FormatException {
      diastole = null;
    }

    double? systole;
    try {
      systole = double.parse(systoleController.text);
    } on FormatException {
      systole = null;
    }

    double? pulse;
    try {
      pulse = double.parse(pulseController.text);
    } on FormatException {
      pulse = null;
    }

    final List<int> singleList = [];
    for (var choice in singleChoices.values) {
      if (choice != null) {
        singleList.add(choice);
      }
    }

    _completer.complete(
      _EntryEditViewResult(
          code: _EntryEditViewResultCode.save,
          entry: api.Entry(
            id: null,
            userId: null,
            haveBloodPressure: hasBloodPressure,
            diastole: diastole,
            systole: systole,
            pulse: pulse,
            startTime: startTime,
            endTime: endTime,
            multiChoices: multiChoices,
            singleChoices: singleList,
            remarks: remarksController.text,
          )),
    );
  }

  Future<_EntryEditViewResult> get future => _completer.future;
}

/// Entry edit view widget
class _EntryEditView extends StatefulWidget {
  /// Widget Title
  final String title;

  /// Data controller
  final _EntryEditViewController controller;

  /// Categories proxy
  final CategoriesProxy categoriesProxy;

  /// True if delete button should be displayed
  final bool hasDelete;

  const _EntryEditView(
      {required this.title,
      required this.controller,
      required this.categoriesProxy,
      this.hasDelete = false});

  @override
  State<_EntryEditView> createState() => _EntryEditViewState();
}

/// State of the Entry edit view widget
class _EntryEditViewState extends State<_EntryEditView> {
  final _editFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          } else {
            exitDiscard(context);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => exitDiscard(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    controller.completeSave();
                    Navigator.of(context).pop();
                  },
                ),
                Visibility(
                  visible: widget.hasDelete,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      if (!_editFormKey.currentState!.validate()) {
                        return;
                      }
                      showConfirmDeleteDialog(context).then((shouldDiscard) {
                        if (shouldDiscard) {
                          controller.completeDelete();
                          Navigator.of(context).pop();
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _editFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Have blood pressure?"),
                      trailing: Switch(
                          value: controller.hasBloodPressure,
                          onChanged: (value) {
                            setState(() {
                              controller.hasBloodPressure = value;
                            });
                          }),
                    ),
                    Visibility(
                      visible: controller.hasBloodPressure,
                      child: TextFormField(
                        controller: controller.systoleController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.thermostat),
                          labelText: "Systole",
                          border: OutlineInputBorder(),
                        ),
                        validator: _doubleValidator,
                      ),
                    ),
                    Visibility(
                      visible: controller.hasBloodPressure,
                      child: TextFormField(
                        controller: controller.diastoleController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.thermostat),
                          labelText: "Diastole",
                          border: OutlineInputBorder(),
                        ),
                        validator: _doubleValidator,
                      ),
                    ),
                    Visibility(
                      visible: controller.hasBloodPressure,
                      child: TextFormField(
                        controller: controller.pulseController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.heart_broken),
                          labelText: "Pulse",
                          border: OutlineInputBorder(),
                        ),
                        validator: _doubleValidator,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Start Time"),
                      subtitle: DateTimeEdit(
                        initialValue: controller.startTime,
                        onChange: (value) {
                          setState(() {
                            controller.startTime = value;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: controller.endTime != null,
                      replacement: Container(
                          alignment: Alignment.topLeft,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text("Add End Time"),
                            onPressed: () {
                              setState(() {
                                controller.endTime = DateTime.now();
                              });
                            },
                          )),
                      child: ListTile(
                        title: const Text("End Time"),
                        subtitle: DateTimeEdit(
                          initialValue: controller.endTime ?? DateTime.now(),
                          onChange: (value) {
                            setState(() {
                              controller.endTime = value;
                            });
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              controller.endTime = null;
                            });
                          },
                        ),
                      ),
                    ),
                    const Divider(),
                    TextFormField(
                      controller: controller.remarksController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        labelText: "Remarks",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                    ),
                    const Divider(),
                    ..._buildGroups(context, controller),
                  ],
                ),
              ),
            )));
  }

  static String? _doubleValidator(String? value) {
    try {
      double.parse(value!);
      return null;
    } on FormatException {
      return "Invalid number";
    }
  }

  /// Discard all changes and exit view
  void exitDiscard(BuildContext context) {
    final controller = widget.controller;
    showConfirmDiscardDialog(context).then((shouldDiscard) {
      if (shouldDiscard) {
        controller.completeCancel();
        Navigator.of(context).pop();
      }
    });
  }

  Iterable<Widget> _buildGroups(
      BuildContext context, _EntryEditViewController controller) {
    final categories = widget.categoriesProxy.getCategories();

    return categories.map((category) {
      final multiChoices =
          widget.categoriesProxy.getMultiChoiceItems(category.id as int);
      final singleChoiceGroups =
          widget.categoriesProxy.getSingleChoiceGroups(category.id as int);
      return Card(
        child: Column(
          children: [
            ListTile(
              title: Text(category.title),
            ),
            ...multiChoices.map((choice) {
              final choiceId = choice.id as int;
              final isChecked = controller.multiChoices.contains(choiceId);
              return ListTile(
                subtitle: Text(choice.title),
                leading: Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    if (value != null) {
                      if (value && !isChecked) {
                        controller.multiChoices.add(choiceId);
                      } else if (!value && isChecked) {
                        controller.multiChoices.remove(choiceId);
                      }
                    }
                    setState(() {});
                  },
                ),
              );
            }),
            ...singleChoiceGroups.map((group) {
              final groupId = group.id as int;
              final choices =
                  widget.categoriesProxy.getSingleChoiceItems(groupId);
              return Row(
                children: [
                  Expanded(
                    child: DropdownMenu<int>(
                      initialSelection: controller.singleChoices[groupId],
                      label: Text(group.title),
                      dropdownMenuEntries: choices.map((choice) {
                        final choiceId = choice.id as int;
                        return DropdownMenuEntry<int>(
                          value: choiceId,
                          label: choice.title,
                        );
                      }).toList(),
                      onSelected: (value) {
                        setState(() {
                          controller.singleChoices[groupId] = value;
                        });
                      },
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      );
    });
  }
}
