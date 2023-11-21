# hta_api.api.LoginApi

## Load the API package
```dart
import 'package:hta_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**oidcInfoGet**](LoginApi.md#oidcinfoget) | **GET** /oidc_info | Obtain information about OpenID Connect
[**userGet**](LoginApi.md#userget) | **GET** /user/ | 


# **oidcInfoGet**
> OidcInfo oidcInfoGet()

Obtain information about OpenID Connect

### Example
```dart
import 'package:hta_api/api.dart';

final api_instance = LoginApi();

try {
    final result = api_instance.oidcInfoGet();
    print(result);
} catch (e) {
    print('Exception when calling LoginApi->oidcInfoGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**OidcInfo**](OidcInfo.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userGet**
> User userGet()



### Example
```dart
import 'package:hta_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OauthSecurity
//defaultApiClient.getAuthentication<OAuth>('OauthSecurity').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: BearerToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('BearerToken').apiKeyPrefix = 'Bearer';

final api_instance = LoginApi();

try {
    final result = api_instance.userGet();
    print(result);
} catch (e) {
    print('Exception when calling LoginApi->userGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[OauthSecurity](../README.md#OauthSecurity), [BearerToken](../README.md#BearerToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

