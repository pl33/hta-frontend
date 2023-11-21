//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CategoryApi {
  CategoryApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /category/{category_id}/multi_choice/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [int] first:
  ///
  /// * [int] limit:
  Future<Response> categoryCategoryIdMultiChoiceGetWithHttpInfo(int categoryId, { int? first, int? limit, }) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{category_id}/multi_choice/'
      .replaceAll('{category_id}', categoryId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (first != null) {
      queryParams.addAll(_queryParams('', 'first', first));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [int] first:
  ///
  /// * [int] limit:
  Future<List<CategoryMultiChoice>?> categoryCategoryIdMultiChoiceGet(int categoryId, { int? first, int? limit, }) async {
    final response = await categoryCategoryIdMultiChoiceGetWithHttpInfo(categoryId,  first: first, limit: limit, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<CategoryMultiChoice>') as List)
        .cast<CategoryMultiChoice>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'POST /category/{category_id}/multi_choice/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [CategoryMultiChoice] body:
  Future<Response> categoryCategoryIdMultiChoicePostWithHttpInfo(int categoryId, { CategoryMultiChoice? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{category_id}/multi_choice/'
      .replaceAll('{category_id}', categoryId.toString());

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [CategoryMultiChoice] body:
  Future<CategoryMultiChoice?> categoryCategoryIdMultiChoicePost(int categoryId, { CategoryMultiChoice? body, }) async {
    final response = await categoryCategoryIdMultiChoicePostWithHttpInfo(categoryId,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategoryMultiChoice',) as CategoryMultiChoice;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /category/{category_id}/single_choice_group/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [int] first:
  ///
  /// * [int] limit:
  Future<Response> categoryCategoryIdSingleChoiceGroupGetWithHttpInfo(int categoryId, { int? first, int? limit, }) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{category_id}/single_choice_group/'
      .replaceAll('{category_id}', categoryId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (first != null) {
      queryParams.addAll(_queryParams('', 'first', first));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [int] first:
  ///
  /// * [int] limit:
  Future<List<CategorySingleChoiceGroup>?> categoryCategoryIdSingleChoiceGroupGet(int categoryId, { int? first, int? limit, }) async {
    final response = await categoryCategoryIdSingleChoiceGroupGetWithHttpInfo(categoryId,  first: first, limit: limit, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<CategorySingleChoiceGroup>') as List)
        .cast<CategorySingleChoiceGroup>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'POST /category/{category_id}/single_choice_group/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [CategorySingleChoiceGroup] body:
  Future<Response> categoryCategoryIdSingleChoiceGroupPostWithHttpInfo(int categoryId, { CategorySingleChoiceGroup? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{category_id}/single_choice_group/'
      .replaceAll('{category_id}', categoryId.toString());

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [CategorySingleChoiceGroup] body:
  Future<CategorySingleChoiceGroup?> categoryCategoryIdSingleChoiceGroupPost(int categoryId, { CategorySingleChoiceGroup? body, }) async {
    final response = await categoryCategoryIdSingleChoiceGroupPostWithHttpInfo(categoryId,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategorySingleChoiceGroup',) as CategorySingleChoiceGroup;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /category/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] first:
  ///
  /// * [int] limit:
  Future<Response> categoryGetWithHttpInfo({ int? first, int? limit, }) async {
    // ignore: prefer_const_declarations
    final path = r'/category/';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (first != null) {
      queryParams.addAll(_queryParams('', 'first', first));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] first:
  ///
  /// * [int] limit:
  Future<List<Category>?> categoryGet({ int? first, int? limit, }) async {
    final response = await categoryGetWithHttpInfo( first: first, limit: limit, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Category>') as List)
        .cast<Category>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'DELETE /category/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> categoryIdDeleteWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<void> categoryIdDelete(int id,) async {
    final response = await categoryIdDeleteWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /category/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> categoryIdGetWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Category?> categoryIdGet(int id,) async {
    final response = await categoryIdGetWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Category',) as Category;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /category/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [Category] body:
  Future<Response> categoryIdPutWithHttpInfo(int id, { Category? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/category/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [Category] body:
  Future<Category?> categoryIdPut(int id, { Category? body, }) async {
    final response = await categoryIdPutWithHttpInfo(id,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Category',) as Category;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /category/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Category] body:
  Future<Response> categoryPostWithHttpInfo({ Category? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/category/';

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [Category] body:
  Future<Category?> categoryPost({ Category? body, }) async {
    final response = await categoryPostWithHttpInfo( body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Category',) as Category;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /multi_choice/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> multiChoiceIdDeleteWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/multi_choice/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<void> multiChoiceIdDelete(int id,) async {
    final response = await multiChoiceIdDeleteWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /multi_choice/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> multiChoiceIdGetWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/multi_choice/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<CategoryMultiChoice?> multiChoiceIdGet(int id,) async {
    final response = await multiChoiceIdGetWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategoryMultiChoice',) as CategoryMultiChoice;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /multi_choice/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [CategoryMultiChoice] body:
  Future<Response> multiChoiceIdPutWithHttpInfo(int id, { CategoryMultiChoice? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/multi_choice/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [CategoryMultiChoice] body:
  Future<CategoryMultiChoice?> multiChoiceIdPut(int id, { CategoryMultiChoice? body, }) async {
    final response = await multiChoiceIdPutWithHttpInfo(id,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategoryMultiChoice',) as CategoryMultiChoice;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /single_choice_group/{group_id}/single_choice/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///
  /// * [int] first:
  ///
  /// * [int] limit:
  Future<Response> singleChoiceGroupGroupIdSingleChoiceGetWithHttpInfo(int groupId, { int? first, int? limit, }) async {
    // ignore: prefer_const_declarations
    final path = r'/single_choice_group/{group_id}/single_choice/'
      .replaceAll('{group_id}', groupId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (first != null) {
      queryParams.addAll(_queryParams('', 'first', first));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///
  /// * [int] first:
  ///
  /// * [int] limit:
  Future<List<CategorySingleChoice>?> singleChoiceGroupGroupIdSingleChoiceGet(int groupId, { int? first, int? limit, }) async {
    final response = await singleChoiceGroupGroupIdSingleChoiceGetWithHttpInfo(groupId,  first: first, limit: limit, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<CategorySingleChoice>') as List)
        .cast<CategorySingleChoice>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'POST /single_choice_group/{group_id}/single_choice/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///
  /// * [CategorySingleChoice] body:
  Future<Response> singleChoiceGroupGroupIdSingleChoicePostWithHttpInfo(int groupId, { CategorySingleChoice? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/single_choice_group/{group_id}/single_choice/'
      .replaceAll('{group_id}', groupId.toString());

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] groupId (required):
  ///
  /// * [CategorySingleChoice] body:
  Future<CategorySingleChoice?> singleChoiceGroupGroupIdSingleChoicePost(int groupId, { CategorySingleChoice? body, }) async {
    final response = await singleChoiceGroupGroupIdSingleChoicePostWithHttpInfo(groupId,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategorySingleChoice',) as CategorySingleChoice;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /single_choice_group/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> singleChoiceGroupIdDeleteWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/single_choice_group/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<void> singleChoiceGroupIdDelete(int id,) async {
    final response = await singleChoiceGroupIdDeleteWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /single_choice_group/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> singleChoiceGroupIdGetWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/single_choice_group/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<CategorySingleChoiceGroup?> singleChoiceGroupIdGet(int id,) async {
    final response = await singleChoiceGroupIdGetWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategorySingleChoiceGroup',) as CategorySingleChoiceGroup;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /single_choice_group/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [CategorySingleChoiceGroup] body:
  Future<Response> singleChoiceGroupIdPutWithHttpInfo(int id, { CategorySingleChoiceGroup? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/single_choice_group/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [CategorySingleChoiceGroup] body:
  Future<CategorySingleChoiceGroup?> singleChoiceGroupIdPut(int id, { CategorySingleChoiceGroup? body, }) async {
    final response = await singleChoiceGroupIdPutWithHttpInfo(id,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategorySingleChoiceGroup',) as CategorySingleChoiceGroup;
    
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /single_choice/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> singleChoiceIdDeleteWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/single_choice/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<void> singleChoiceIdDelete(int id,) async {
    final response = await singleChoiceIdDeleteWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /single_choice/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  Future<Response> singleChoiceIdGetWithHttpInfo(int id,) async {
    // ignore: prefer_const_declarations
    final path = r'/single_choice/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  Future<CategorySingleChoice?> singleChoiceIdGet(int id,) async {
    final response = await singleChoiceIdGetWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategorySingleChoice',) as CategorySingleChoice;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /single_choice/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [CategorySingleChoice] body:
  Future<Response> singleChoiceIdPutWithHttpInfo(int id, { CategorySingleChoice? body, }) async {
    // ignore: prefer_const_declarations
    final path = r'/single_choice/{id}'
      .replaceAll('{id}', id.toString());

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [CategorySingleChoice] body:
  Future<CategorySingleChoice?> singleChoiceIdPut(int id, { CategorySingleChoice? body, }) async {
    final response = await singleChoiceIdPutWithHttpInfo(id,  body: body, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CategorySingleChoice',) as CategorySingleChoice;
    
    }
    return null;
  }
}
