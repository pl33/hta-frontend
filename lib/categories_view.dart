/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'app_login_state.dart';
import 'categories_proxy.dart';
import 'connect_server.dart';
import 'dialogs.dart';
import 'main.dart';

class CategoriesPage extends StatefulWidget {
  final GlobalAppState appState;

  static const String route = "/categories";

  const CategoriesPage({required this.appState, super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  /// Login info if logged in or null
  AppLoginLoggedIn? loginInfo;

  /// Handles login state changes
  void _onLoginStateChangeCb() {
    setState(() {
      loginInfo = widget.appState.loginInfo();
    });
  }

  @override
  void initState() {
    super.initState();
    widget.appState.addListener(_onLoginStateChangeCb);
    loginInfo = widget.appState.loginInfo();
  }

  @override
  void dispose() {
    super.dispose();
    widget.appState.removeListener(_onLoginStateChangeCb);
  }

  @override
  Widget build(BuildContext context) {
    if (loginInfo != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("Categories"),
        ),
        drawer: makeDefaultDrawer(context, widget.appState),
        body: CategoriesView(categoriesProxy: loginInfo!.categoriesProxy),
        floatingActionButton: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("Add"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.primaries.first,
          ),
          onPressed: () {
            categoriesShowCreateView(context, loginInfo!.categoriesProxy);
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

/// The Categories View Widget displays a list of all categories. Tapping
/// on the categories opens an editing view. The category list view
/// offers the possibility to add a new category, too.
class CategoriesView extends StatefulWidget {
  /// Cache and proxy for operations on the Category API.
  final CategoriesProxy categoriesProxy;

  const CategoriesView({required this.categoriesProxy, super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

/// State of the Categories View Widget
class _CategoriesViewState extends State<CategoriesView> {
  final ScrollController _scrollController = ScrollController();

  void _onProxyUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.categoriesProxy.addListener(_onProxyUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    widget.categoriesProxy.removeListener(_onProxyUpdate);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];
    for (var cat in widget.categoriesProxy.getCategories()) {
      items.add(ListTile(
        title: Text(cat.title),
        onTap: () {
          categoriesShowEditView(
              context, widget.categoriesProxy, cat.id! as int);
        },
      ));
      items.add(const Divider());
    }

    return ListView(
      controller: _scrollController,
      children: items,
    );
  }
}

/// Shows the dialog for creating new categories
///
/// It requires a BuildContext in [context] and a Categories Proxy in
/// [categoriesProxy].
void categoriesShowCreateView(
    BuildContext context, CategoriesProxy categoriesProxy) {
  showEditDialog(context, "New Category", {
    "title": TextFieldConfig(label: "Category Title"),
  }).then((res) {
    if (res.isOk()) {
      categoriesProxy.createCategory(res.values!["title"]!).then((item) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Category successfully created")));
        categoriesShowEditView(context, categoriesProxy, item.id! as int);
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Cannot create category: ${error as Exception}")));
      });
    }
  });
}

/// Categories edit view widget
class _CategoriesEditView extends StatefulWidget {
  /// Cache and proxy for operations on the Category API.
  final CategoriesProxy categoriesProxy;

  /// ID of category which should be edited
  final int categoryId;

  const _CategoriesEditView(
      {required this.categoriesProxy, required this.categoryId});

  @override
  State<_CategoriesEditView> createState() => _CategoriesEditViewState();
}

/// State of the Categories View Widget
class _CategoriesEditViewState extends State<_CategoriesEditView> {
  bool _multiChoicesExpanded = true;
  final Map<int, bool> _expandedSingleChoiceGroupsIds = {};

  void _onProxyUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.categoriesProxy.addListener(_onProxyUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    widget.categoriesProxy.removeListener(_onProxyUpdate);
  }

  List<Widget> _buildGroup<T extends ChoiceItemsFacade>(
      BuildContext context, T facade,
      {required String name, IconData? icon}) {
    final items = facade.getItems();
    final widgets = items.map((GenericChoiceItem item) {
      return ListTile(
        leading: (icon != null) ? Icon(icon) : null,
        title: Text(item.title),
        subtitle: Text(item.description),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            showEditDialog(
              context,
              "Edit $name",
              {
                "title": TextFieldConfig(
                  label: "Title",
                  initialValue: item.title,
                  prefixIcon: const Icon(Icons.title),
                ),
                "description": TextFieldConfig(
                  label: "Description",
                  initialValue: item.description,
                  maxLines: null,
                  prefixIcon: const Icon(Icons.description),
                ),
              },
              hasDelete: true,
            ).then((result) {
              if (result.isOk()) {
                facade
                    .update(item.id, result.values!["title"]!,
                        result.values!["description"]!)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$name successfully saved")));
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Cannot update $name: ${error as Exception}")));
                });
              } else if (result.isDelete()) {
                showConfirmDeleteDialog(context).then((confirmDelete) {
                  if (confirmDelete) {
                    facade.delete(item.id).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$name successfully deleted")));
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Cannot delete $name: ${error as Exception}")));
                    });
                  }
                });
              }
            });
          },
        ),
      );
    });
    return [
      ...widgets,
      ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: Text("Add $name"),
          onPressed: () {
            showEditDialog(context, "New $name", {
              "title": TextFieldConfig(
                label: "Title",
                prefixIcon: const Icon(Icons.title),
              ),
              "description": TextFieldConfig(
                label: "Description",
                maxLines: null,
                prefixIcon: const Icon(Icons.description),
              ),
            }).then((result) {
              if (result.isOk()) {
                facade
                    .create(result.values!["title"]!,
                        result.values!["description"]!)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$name successfully created")));
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Cannot create $name: ${error as Exception}")));
                });
              }
            });
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.categoriesProxy.getCategoryById(widget.categoryId);
    if (item == null) {
      return const Scaffold(
        body: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("Waiting ..."),
            ],
          ),
        ),
      );
    }

    final multiChoicesPanel = ExpansionPanel(
      headerBuilder: (context, isExpanded) =>
          const ListTile(title: Text("Multi Choices")),
      body: Column(
        children: _buildGroup(
          context,
          MultiChoiceItemsFacade(widget.categoriesProxy, widget.categoryId),
          name: "Multi Choice Item",
          icon: Icons.check_box_outline_blank,
        ),
      ),
      isExpanded: _multiChoicesExpanded,
    );

    final singleChoiceGroups =
        widget.categoriesProxy.getSingleChoiceGroups(widget.categoryId);
    final singleChoicePanels = singleChoiceGroups.map((group) {
      return ExpansionPanel(
        headerBuilder: (context, isExpanded) => ListTile(
          title: Text("Single Choices - ${group.title}"),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showEditDialog(
                context,
                "Edit Single Choice Group",
                {
                  "title": TextFieldConfig(
                    label: "Title",
                    initialValue: group.title,
                    prefixIcon: const Icon(Icons.title),
                  ),
                  "description": TextFieldConfig(
                    label: "Description",
                    initialValue: group.description,
                    maxLines: null,
                    prefixIcon: const Icon(Icons.description),
                  ),
                },
                hasDelete: true,
              ).then((result) {
                if (result.isOk()) {
                  widget.categoriesProxy
                      .updateSingleChoiceGroup(
                    group.id! as int,
                    result.values!["title"]!,
                    result.values!["description"]!,
                  )
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Single Choice Group successfully saved")));
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Cannot update Single Choice Group: ${error as Exception}")));
                  });
                } else if (result.isDelete()) {
                  showConfirmDeleteDialog(context).then((confirmDelete) {
                    if (confirmDelete) {
                      widget.categoriesProxy
                          .deleteSingleChoiceGroup(group.id! as int)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Single Choice Group successfully deleted")));
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Cannot delete Single Choice Group: ${error as Exception}")));
                      });
                    }
                  });
                }
              });
            },
          ),
        ),
        body: Column(
          children: _buildGroup(
            context,
            SingleChoiceItemsFacade(widget.categoriesProxy, group.id! as int),
            name: "Single Choice Item",
            icon: Icons.circle_outlined,
          ),
        ),
        isExpanded: _expandedSingleChoiceGroupsIds[group.id! as int] ?? false,
      );
    });

    final expansionList = ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        if (panelIndex == 0) {
          _multiChoicesExpanded = isExpanded;
        } else {
          // First panel is multi choice group
          final groupIndex = panelIndex - 1;
          if (groupIndex < singleChoiceGroups.length) {
            final groupId = singleChoiceGroups.elementAt(groupIndex).id! as int;
            _expandedSingleChoiceGroupsIds[groupId] = isExpanded;
          }
        }
        setState(() {});
      },
      children: [multiChoicesPanel, ...singleChoicePanels],
    );

    final addGroupButton = ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text("Add Single Choice Group"),
        onPressed: () {
          showEditDialog(context, "New Single Choice Group", {
            "title": TextFieldConfig(
              label: "Title",
              prefixIcon: const Icon(Icons.title),
            ),
            "description": TextFieldConfig(
              label: "Description",
              maxLines: null,
              prefixIcon: const Icon(Icons.description),
            ),
          }).then((result) {
            if (result.isOk()) {
              widget.categoriesProxy
                  .createSingleChoiceGroup(
                widget.categoryId,
                result.values!["title"]!,
                result.values!["description"]!,
              )
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Single Choice Group successfully created")));
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Cannot create Single Choice Group: ${error as Exception}")));
              });
            }
          });
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(item.title),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showEditDialog(context, "Edit Category", {
                "title": TextFieldConfig(
                    label: "Category Title", initialValue: item.title),
              }).then((res) {
                if (res.isOk()) {
                  widget.categoriesProxy
                      .updateCategory(widget.categoryId, res.values!["title"]!)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Category successfully saved")));
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Cannot update category: ${error as Exception}")));
                  });
                }
              });
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showConfirmDeleteDialog(context).then((confirmDelete) {
                if (confirmDelete) {
                  widget.categoriesProxy
                      .deleteCategory(widget.categoryId)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Category successfully deleted")));
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Cannot delete category: ${error as Exception}")));
                  });
                }
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            expansionList,
            addGroupButton,
          ],
        ),
      ),
    );
  }
}

/// Shows the dialog for editing existing items
///
/// It requires a BuildContext in [context] and a Categories Proxy in
/// [categoriesProxy]. The [currentItem] points to the item which
/// should be edited.
void categoriesShowEditView(
    BuildContext context, CategoriesProxy categoriesProxy, int categoryId) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
    return _CategoriesEditView(
        categoriesProxy: categoriesProxy, categoryId: categoryId);
  }));
}
