/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/material.dart';
import 'package:hta_api/api.dart' as api;

/// Cache and proxy for the Category API
class CategoriesProxy with ChangeNotifier {
  /// Category API Client
  final api.CategoryApi _apiClient;

  /// Category cache
  final Map<int, api.Category> _categoryCache;

  /// Multi Choice Item cache
  final Map<int, api.CategoryMultiChoice> _mcItemCache;

  /// Single Choice Group cache
  final Map<int, api.CategorySingleChoiceGroup> _scGroupCache;

  /// Single Choice Item cache
  final Map<int, api.CategorySingleChoice> _scItemCache;

  @protected
  CategoriesProxy({required client})
      : _apiClient = api.CategoryApi(client),
        _categoryCache = {},
        _mcItemCache = {},
        _scGroupCache = {},
        _scItemCache = {};

  int get length => _categoryCache.length;

  /// Reloads all categories and entries from the server
  Future<void> reloadAll() async {
    _categoryCache.clear();
    _mcItemCache.clear();
    _scGroupCache.clear();
    _scItemCache.clear();
    // Categories
    {
      final items = await _apiClient.categoryGet();
      for (var item in items ?? [] as List<api.Category>) {
        _categoryCache[item.id! as int] = item;
      }
    }
    for (var catId in _categoryCache.keys) {
      // Multi Choice Items
      {
        final items = await _apiClient.categoryCategoryIdMultiChoiceGet(catId);
        for (var item in items ?? [] as List<api.CategoryMultiChoice>) {
          _mcItemCache[item.id! as int] = item;
        }
      }
      // Single Choice Groups
      {
        final items =
            await _apiClient.categoryCategoryIdSingleChoiceGroupGet(catId);
        for (var item in items ?? [] as List<api.CategorySingleChoiceGroup>) {
          _scGroupCache[item.id! as int] = item;
        }
      }
      // Single Choice Items
      for (var group in _scGroupCache.values) {
        final items = await _apiClient
            .singleChoiceGroupGroupIdSingleChoiceGet(group.id! as int);
        for (var item in items ?? [] as List<api.CategorySingleChoice>) {
          _scItemCache[item.id! as int] = item;
        }
      }
    }

    notifyListeners();
  }

  /// Retrieve Category by its ID
  api.Category? getCategoryById(int id) {
    return _categoryCache[id];
  }

  /// Get a list of all categories which are cached
  Iterable<api.Category> getCategories() {
    return _categoryCache.values;
  }

  /// Create new category
  Future<api.Category> createCategory(String title) async {
    api.Category? item = api.Category(
      title: title,
    );
    item = await _apiClient.categoryPost(body: item);
    _categoryCache[item?.id! as int] = item!;
    notifyListeners();
    return item;
  }

  /// Modify an existing category
  Future<void> updateCategory(int id, String title) async {
    if (_categoryCache.containsKey(id)) {
      _categoryCache[id]?.id = null;
      _categoryCache[id]?.userId = null;
      _categoryCache[id]?.title = title;
      final result =
          await _apiClient.categoryIdPut(id, body: _categoryCache[id]!);
      _categoryCache[id] = result!;
      notifyListeners();
    }
  }

  /// Delete a category
  Future<void> deleteCategory(int id) async {
    if (_categoryCache.containsKey(id)) {
      await _apiClient.categoryIdDelete(id);
      _categoryCache.remove(id);
      notifyListeners();
    }
  }

  /// Retrieve multi choice item by its ID
  api.CategoryMultiChoice? getMultiChoiceItemById(int id) {
    return _mcItemCache[id];
  }

  /// Get a list of all multi choice items which are cached in category [categoryId]
  Iterable<api.CategoryMultiChoice> getMultiChoiceItems(int categoryId) {
    return _mcItemCache.values
        .where((element) => element.categoryId == categoryId);
  }

  /// Create new multi choice item in category [categoryId]
  Future<api.CategoryMultiChoice> createMultiChoiceItem(
      int categoryId, String title, String? description) async {
    api.CategoryMultiChoice? item = api.CategoryMultiChoice(
      title: title,
      description: description,
    );
    item = await _apiClient.categoryCategoryIdMultiChoicePost(
      categoryId,
      body: item,
    );
    _mcItemCache[item?.id! as int] = item!;
    notifyListeners();
    return item;
  }

  /// Modify an existing multi choice item
  Future<void> updateMultiChoiceItem(
      int id, String title, String? description) async {
    if (_mcItemCache.containsKey(id)) {
      _mcItemCache[id]?.id = null;
      _mcItemCache[id]?.categoryId = null;
      _mcItemCache[id]?.title = title;
      _mcItemCache[id]?.description = description;
      final result =
          await _apiClient.multiChoiceIdPut(id, body: _mcItemCache[id]!);
      _mcItemCache[id] = result!;
      notifyListeners();
    }
  }

  /// Delete a multi choice item
  Future<void> deleteMultiChoiceItem(int id) async {
    if (_mcItemCache.containsKey(id)) {
      await _apiClient.multiChoiceIdDelete(id);
      _mcItemCache.remove(id);
      notifyListeners();
    }
  }

  /// Retrieve single choice item by its ID
  api.CategorySingleChoiceGroup? getSingleChoiceGroupById(int id) {
    return _scGroupCache[id];
  }

  /// Get a list of all single choice items which are cached in category [categoryId]
  Iterable<api.CategorySingleChoiceGroup> getSingleChoiceGroups(
      int categoryId) {
    return _scGroupCache.values
        .where((element) => element.categoryId == categoryId);
  }

  /// Create new single choice group in category [categoryId]
  Future<api.CategorySingleChoiceGroup> createSingleChoiceGroup(
      int categoryId, String title, String? description) async {
    api.CategorySingleChoiceGroup? item = api.CategorySingleChoiceGroup(
      title: title,
      description: description,
    );
    item = await _apiClient.categoryCategoryIdSingleChoiceGroupPost(
      categoryId,
      body: item,
    );
    _scGroupCache[item?.id! as int] = item!;
    notifyListeners();
    return item;
  }

  /// Modify an existing single choice group
  Future<void> updateSingleChoiceGroup(
      int id, String title, String? description) async {
    if (_scGroupCache.containsKey(id)) {
      _scGroupCache[id]?.id = null;
      _scGroupCache[id]?.categoryId = null;
      _scGroupCache[id]?.title = title;
      _scGroupCache[id]?.description = description;
      final result =
          await _apiClient.singleChoiceGroupIdPut(id, body: _scGroupCache[id]!);
      _scGroupCache[id] = result!;
      notifyListeners();
    }
  }

  /// Delete a single choice group
  Future<void> deleteSingleChoiceGroup(int id) async {
    if (_scGroupCache.containsKey(id)) {
      await _apiClient.singleChoiceGroupIdDelete(id);
      _scGroupCache.remove(id);
      notifyListeners();
    }
  }

  /// Retrieve single choice item by its ID
  api.CategorySingleChoice? getSingleChoiceItemById(int id) {
    return _scItemCache[id];
  }

  /// Get a list of all single choice items which are cached in single choice group [groupId]
  Iterable<api.CategorySingleChoice> getSingleChoiceItems(int groupId) {
    return _scItemCache.values.where((element) => element.groupId == groupId);
  }

  /// Create new single choice item in single choice group [groupId]
  Future<api.CategorySingleChoice> createSingleChoiceItem(
      int groupId, String title, String? description) async {
    api.CategorySingleChoice? item = api.CategorySingleChoice(
      title: title,
      description: description,
    );
    item = await _apiClient.singleChoiceGroupGroupIdSingleChoicePost(
      groupId,
      body: item,
    );
    _scItemCache[item?.id! as int] = item!;
    notifyListeners();
    return item;
  }

  /// Modify an existing single choice item
  Future<void> updateSingleChoiceItem(
      int id, String title, String? description) async {
    if (_scItemCache.containsKey(id)) {
      _scItemCache[id]?.id = null;
      _scItemCache[id]?.groupId = null;
      _scItemCache[id]?.title = title;
      _scItemCache[id]?.description = description;
      final result =
          await _apiClient.singleChoiceIdPut(id, body: _scItemCache[id]!);
      _scItemCache[id] = result!;
      notifyListeners();
    }
  }

  /// Delete a single choice item
  Future<void> deleteSingleChoiceItem(int id) async {
    if (_scItemCache.containsKey(id)) {
      await _apiClient.singleChoiceIdDelete(id);
      _scItemCache.remove(id);
      notifyListeners();
    }
  }
}

/// Generic choice object data for use in ChoiceItemsFacade
class GenericChoiceItem {
  final int id;
  final String title;
  final String description;

  GenericChoiceItem(
      {required this.id, required this.title, required this.description});
}

/// Provide standardized access to choice objects
abstract class ChoiceItemsFacade {
  final CategoriesProxy _proxy;
  final int _parentId;

  /// Creates a facade with is associated with the categories proxy and a parent ID
  ChoiceItemsFacade(CategoriesProxy proxy, int parentId)
      : _proxy = proxy,
        _parentId = parentId;

  /// Get a list of items
  Iterable<GenericChoiceItem> getItems();

  /// Create a new item
  Future<void> create(String title, String description);

  /// Save new values to an item
  Future<void> update(int id, String title, String description);

  /// Delete an item
  Future<void> delete(int id);
}

class MultiChoiceItemsFacade extends ChoiceItemsFacade {
  MultiChoiceItemsFacade(super.proxy, super.parentId);

  @override
  Future<void> delete(int id) {
    return _proxy.deleteMultiChoiceItem(id);
  }

  @override
  Future<void> create(String title, String description) {
    return _proxy.createMultiChoiceItem(_parentId, title, description);
  }

  @override
  Future<void> update(int id, String title, String description) {
    return _proxy.updateMultiChoiceItem(id, title, description);
  }

  @override
  Iterable<GenericChoiceItem> getItems() {
    return _proxy.getMultiChoiceItems(_parentId).map((e) {
      return GenericChoiceItem(
          id: e.id! as int, title: e.title, description: e.description ?? "");
    });
  }
}

class SingleChoiceItemsFacade extends ChoiceItemsFacade {
  SingleChoiceItemsFacade(super.proxy, super.parentId);

  @override
  Future<void> delete(int id) {
    return _proxy.deleteSingleChoiceItem(id);
  }

  @override
  Future<void> create(String title, String description) {
    return _proxy.createSingleChoiceItem(_parentId, title, description);
  }

  @override
  Future<void> update(int id, String title, String description) {
    return _proxy.updateSingleChoiceItem(id, title, description);
  }

  @override
  Iterable<GenericChoiceItem> getItems() {
    return _proxy.getSingleChoiceItems(_parentId).map((e) {
      return GenericChoiceItem(
          id: e.id! as int, title: e.title, description: e.description ?? "");
    });
  }
}
