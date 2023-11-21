# hta_api.api.EntryApi

## Load the API package
```dart
import 'package:hta_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**entriesGet**](EntryApi.md#entriesget) | **GET** /entries/ | 
[**entriesIdDelete**](EntryApi.md#entriesiddelete) | **DELETE** /entries/{id} | 
[**entriesIdGet**](EntryApi.md#entriesidget) | **GET** /entries/{id} | 
[**entriesIdPut**](EntryApi.md#entriesidput) | **PUT** /entries/{id} | 
[**entriesPost**](EntryApi.md#entriespost) | **POST** /entries/ | 


# **entriesGet**
> List<Entry> entriesGet(first, limit)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = EntryApi();
final first = 56; // int | 
final limit = 56; // int | 

try {
    final result = api_instance.entriesGet(first, limit);
    print(result);
} catch (e) {
    print('Exception when calling EntryApi->entriesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **first** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**List<Entry>**](Entry.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdDelete**
> entriesIdDelete(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = EntryApi();
final id = 789; // int | 

try {
    api_instance.entriesIdDelete(id);
} catch (e) {
    print('Exception when calling EntryApi->entriesIdDelete: $e\n');
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

# **entriesIdGet**
> Entry entriesIdGet(id)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = EntryApi();
final id = 789; // int | 

try {
    final result = api_instance.entriesIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling EntryApi->entriesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**Entry**](Entry.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdPut**
> Entry entriesIdPut(id, body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = EntryApi();
final id = 789; // int | 
final body = Entry(); // Entry | 

try {
    final result = api_instance.entriesIdPut(id, body);
    print(result);
} catch (e) {
    print('Exception when calling EntryApi->entriesIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **body** | [**Entry**](Entry.md)|  | [optional] 

### Return type

[**Entry**](Entry.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesPost**
> Entry entriesPost(body)



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = EntryApi();
final body = Entry(); // Entry | 

try {
    final result = api_instance.entriesPost(body);
    print(result);
} catch (e) {
    print('Exception when calling EntryApi->entriesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Entry**](Entry.md)|  | [optional] 

### Return type

[**Entry**](Entry.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

