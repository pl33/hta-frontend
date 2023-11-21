# hta_api.api.CategoryApi

## Load the API package
```dart
import 'package:hta_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**categoryCategoryIdMultiChoiceGet**](CategoryApi.md#categorycategoryidmultichoiceget) | **GET** /category/{category_id}/multi_choice/ | 
[**categoryCategoryIdMultiChoicePost**](CategoryApi.md#categorycategoryidmultichoicepost) | **POST** /category/{category_id}/multi_choice/ | 
[**categoryCategoryIdSingleChoiceGroupGet**](CategoryApi.md#categorycategoryidsinglechoicegroupget) | **GET** /category/{category_id}/single_choice_group/ | 
[**categoryCategoryIdSingleChoiceGroupPost**](CategoryApi.md#categorycategoryidsinglechoicegrouppost) | **POST** /category/{category_id}/single_choice_group/ | 
[**categoryGet**](CategoryApi.md#categoryget) | **GET** /category/ | 
[**categoryIdDelete**](CategoryApi.md#categoryiddelete) | **DELETE** /category/{id} | 
[**categoryIdGet**](CategoryApi.md#categoryidget) | **GET** /category/{id} | 
[**categoryIdPut**](CategoryApi.md#categoryidput) | **PUT** /category/{id} | 
[**categoryPost**](CategoryApi.md#categorypost) | **POST** /category/ | 
[**multiChoiceIdDelete**](CategoryApi.md#multichoiceiddelete) | **DELETE** /multi_choice/{id} | 
[**multiChoiceIdGet**](CategoryApi.md#multichoiceidget) | **GET** /multi_choice/{id} | 
[**multiChoiceIdPut**](CategoryApi.md#multichoiceidput) | **PUT** /multi_choice/{id} | 
[**singleChoiceGroupGroupIdSingleChoiceGet**](CategoryApi.md#singlechoicegroupgroupidsinglechoiceget) | **GET** /single_choice_group/{group_id}/single_choice/ | 
[**singleChoiceGroupGroupIdSingleChoicePost**](CategoryApi.md#singlechoicegroupgroupidsinglechoicepost) | **POST** /single_choice_group/{group_id}/single_choice/ | 
[**singleChoiceGroupIdDelete**](CategoryApi.md#singlechoicegroupiddelete) | **DELETE** /single_choice_group/{id} | 
[**singleChoiceGroupIdGet**](CategoryApi.md#singlechoicegroupidget) | **GET** /single_choice_group/{id} | 
[**singleChoiceGroupIdPut**](CategoryApi.md#singlechoicegroupidput) | **PUT** /single_choice_group/{id} | 
[**singleChoiceIdDelete**](CategoryApi.md#singlechoiceiddelete) | **DELETE** /single_choice/{id} | 
[**singleChoiceIdGet**](CategoryApi.md#singlechoiceidget) | **GET** /single_choice/{id} | 
[**singleChoiceIdPut**](CategoryApi.md#singlechoiceidput) | **PUT** /single_choice/{id} | 


# **categoryCategoryIdMultiChoiceGet**
> List<CategoryMultiChoice> categoryCategoryIdMultiChoiceGet(categoryId, first, limit)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final categoryId = 789; // int | 
final first = 56; // int | 
final limit = 56; // int | 

try {
    final result = api_instance.categoryCategoryIdMultiChoiceGet(categoryId, first, limit);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->categoryCategoryIdMultiChoiceGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**|  | 
 **first** | **int**|  | [optional] [default to 0]
 **limit** | **int**|  | [optional] 

### Return type

[**List<CategoryMultiChoice>**](CategoryMultiChoice.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoryCategoryIdMultiChoicePost**
> CategoryMultiChoice categoryCategoryIdMultiChoicePost(categoryId, body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final categoryId = 789; // int | 
final body = CategoryMultiChoice(); // CategoryMultiChoice | 

try {
    final result = api_instance.categoryCategoryIdMultiChoicePost(categoryId, body);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->categoryCategoryIdMultiChoicePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**|  | 
 **body** | [**CategoryMultiChoice**](CategoryMultiChoice.md)|  | [optional] 

### Return type

[**CategoryMultiChoice**](CategoryMultiChoice.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoryCategoryIdSingleChoiceGroupGet**
> List<CategorySingleChoiceGroup> categoryCategoryIdSingleChoiceGroupGet(categoryId, first, limit)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final categoryId = 789; // int | 
final first = 56; // int | 
final limit = 56; // int | 

try {
    final result = api_instance.categoryCategoryIdSingleChoiceGroupGet(categoryId, first, limit);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->categoryCategoryIdSingleChoiceGroupGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**|  | 
 **first** | **int**|  | [optional] [default to 0]
 **limit** | **int**|  | [optional] 

### Return type

[**List<CategorySingleChoiceGroup>**](CategorySingleChoiceGroup.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoryCategoryIdSingleChoiceGroupPost**
> CategorySingleChoiceGroup categoryCategoryIdSingleChoiceGroupPost(categoryId, body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final categoryId = 789; // int | 
final body = CategorySingleChoiceGroup(); // CategorySingleChoiceGroup | 

try {
    final result = api_instance.categoryCategoryIdSingleChoiceGroupPost(categoryId, body);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->categoryCategoryIdSingleChoiceGroupPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**|  | 
 **body** | [**CategorySingleChoiceGroup**](CategorySingleChoiceGroup.md)|  | [optional] 

### Return type

[**CategorySingleChoiceGroup**](CategorySingleChoiceGroup.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoryGet**
> List<Category> categoryGet(first, limit)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final first = 56; // int | 
final limit = 56; // int | 

try {
    final result = api_instance.categoryGet(first, limit);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->categoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **first** | **int**|  | [optional] [default to 0]
 **limit** | **int**|  | [optional] 

### Return type

[**List<Category>**](Category.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoryIdDelete**
> categoryIdDelete(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 

try {
    api_instance.categoryIdDelete(id);
} catch (e) {
    print('Exception when calling CategoryApi->categoryIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoryIdGet**
> Category categoryIdGet(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 

try {
    final result = api_instance.categoryIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->categoryIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**Category**](Category.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoryIdPut**
> Category categoryIdPut(id, body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 
final body = Category(); // Category | 

try {
    final result = api_instance.categoryIdPut(id, body);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->categoryIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **body** | [**Category**](Category.md)|  | [optional] 

### Return type

[**Category**](Category.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoryPost**
> Category categoryPost(body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final body = Category(); // Category | 

try {
    final result = api_instance.categoryPost(body);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->categoryPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Category**](Category.md)|  | [optional] 

### Return type

[**Category**](Category.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **multiChoiceIdDelete**
> multiChoiceIdDelete(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 

try {
    api_instance.multiChoiceIdDelete(id);
} catch (e) {
    print('Exception when calling CategoryApi->multiChoiceIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **multiChoiceIdGet**
> CategoryMultiChoice multiChoiceIdGet(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 

try {
    final result = api_instance.multiChoiceIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->multiChoiceIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**CategoryMultiChoice**](CategoryMultiChoice.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **multiChoiceIdPut**
> CategoryMultiChoice multiChoiceIdPut(id, body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 
final body = CategoryMultiChoice(); // CategoryMultiChoice | 

try {
    final result = api_instance.multiChoiceIdPut(id, body);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->multiChoiceIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **body** | [**CategoryMultiChoice**](CategoryMultiChoice.md)|  | [optional] 

### Return type

[**CategoryMultiChoice**](CategoryMultiChoice.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **singleChoiceGroupGroupIdSingleChoiceGet**
> List<CategorySingleChoice> singleChoiceGroupGroupIdSingleChoiceGet(groupId, first, limit)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final groupId = 789; // int | 
final first = 56; // int | 
final limit = 56; // int | 

try {
    final result = api_instance.singleChoiceGroupGroupIdSingleChoiceGet(groupId, first, limit);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->singleChoiceGroupGroupIdSingleChoiceGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **first** | **int**|  | [optional] [default to 0]
 **limit** | **int**|  | [optional] 

### Return type

[**List<CategorySingleChoice>**](CategorySingleChoice.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **singleChoiceGroupGroupIdSingleChoicePost**
> CategorySingleChoice singleChoiceGroupGroupIdSingleChoicePost(groupId, body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final groupId = 789; // int | 
final body = CategorySingleChoice(); // CategorySingleChoice | 

try {
    final result = api_instance.singleChoiceGroupGroupIdSingleChoicePost(groupId, body);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->singleChoiceGroupGroupIdSingleChoicePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **int**|  | 
 **body** | [**CategorySingleChoice**](CategorySingleChoice.md)|  | [optional] 

### Return type

[**CategorySingleChoice**](CategorySingleChoice.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **singleChoiceGroupIdDelete**
> singleChoiceGroupIdDelete(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 

try {
    api_instance.singleChoiceGroupIdDelete(id);
} catch (e) {
    print('Exception when calling CategoryApi->singleChoiceGroupIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **singleChoiceGroupIdGet**
> CategorySingleChoiceGroup singleChoiceGroupIdGet(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 

try {
    final result = api_instance.singleChoiceGroupIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->singleChoiceGroupIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**CategorySingleChoiceGroup**](CategorySingleChoiceGroup.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **singleChoiceGroupIdPut**
> CategorySingleChoiceGroup singleChoiceGroupIdPut(id, body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 
final body = CategorySingleChoiceGroup(); // CategorySingleChoiceGroup | 

try {
    final result = api_instance.singleChoiceGroupIdPut(id, body);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->singleChoiceGroupIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **body** | [**CategorySingleChoiceGroup**](CategorySingleChoiceGroup.md)|  | [optional] 

### Return type

[**CategorySingleChoiceGroup**](CategorySingleChoiceGroup.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **singleChoiceIdDelete**
> singleChoiceIdDelete(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 

try {
    api_instance.singleChoiceIdDelete(id);
} catch (e) {
    print('Exception when calling CategoryApi->singleChoiceIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **singleChoiceIdGet**
> CategorySingleChoice singleChoiceIdGet(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 

try {
    final result = api_instance.singleChoiceIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->singleChoiceIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**CategorySingleChoice**](CategorySingleChoice.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **singleChoiceIdPut**
> CategorySingleChoice singleChoiceIdPut(id, body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = CategoryApi();
final id = 789; // int | 
final body = CategorySingleChoice(); // CategorySingleChoice | 

try {
    final result = api_instance.singleChoiceIdPut(id, body);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->singleChoiceIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **body** | [**CategorySingleChoice**](CategorySingleChoice.md)|  | [optional] 

### Return type

[**CategorySingleChoice**](CategorySingleChoice.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

