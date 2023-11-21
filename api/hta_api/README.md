# hta_api
Track Health Parameters

This Dart package is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 1.0.0
- Build package: org.openapitools.codegen.languages.DartClientCodegen

## Requirements

Dart 2.12 or later

## Installation & Usage

### Github
If this Dart package is published to Github, add the following dependency to your pubspec.yaml
```
dependencies:
  hta_api:
    git: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
```

### Local
To use the package in your local drive, add the following dependency to your pubspec.yaml
```
dependencies:
  hta_api:
    path: /path/to/hta_api
```

## Tests

TODO

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

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

## Documentation for API Endpoints

All URIs are relative to *http://localhost:8080*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*CategoryApi* | [**categoryCategoryIdMultiChoiceGet**](doc//CategoryApi.md#categorycategoryidmultichoiceget) | **GET** /category/{category_id}/multi_choice/ | 
*CategoryApi* | [**categoryCategoryIdMultiChoicePost**](doc//CategoryApi.md#categorycategoryidmultichoicepost) | **POST** /category/{category_id}/multi_choice/ | 
*CategoryApi* | [**categoryCategoryIdSingleChoiceGroupGet**](doc//CategoryApi.md#categorycategoryidsinglechoicegroupget) | **GET** /category/{category_id}/single_choice_group/ | 
*CategoryApi* | [**categoryCategoryIdSingleChoiceGroupPost**](doc//CategoryApi.md#categorycategoryidsinglechoicegrouppost) | **POST** /category/{category_id}/single_choice_group/ | 
*CategoryApi* | [**categoryGet**](doc//CategoryApi.md#categoryget) | **GET** /category/ | 
*CategoryApi* | [**categoryIdDelete**](doc//CategoryApi.md#categoryiddelete) | **DELETE** /category/{id} | 
*CategoryApi* | [**categoryIdGet**](doc//CategoryApi.md#categoryidget) | **GET** /category/{id} | 
*CategoryApi* | [**categoryIdPut**](doc//CategoryApi.md#categoryidput) | **PUT** /category/{id} | 
*CategoryApi* | [**categoryPost**](doc//CategoryApi.md#categorypost) | **POST** /category/ | 
*CategoryApi* | [**multiChoiceIdDelete**](doc//CategoryApi.md#multichoiceiddelete) | **DELETE** /multi_choice/{id} | 
*CategoryApi* | [**multiChoiceIdGet**](doc//CategoryApi.md#multichoiceidget) | **GET** /multi_choice/{id} | 
*CategoryApi* | [**multiChoiceIdPut**](doc//CategoryApi.md#multichoiceidput) | **PUT** /multi_choice/{id} | 
*CategoryApi* | [**singleChoiceGroupGroupIdSingleChoiceGet**](doc//CategoryApi.md#singlechoicegroupgroupidsinglechoiceget) | **GET** /single_choice_group/{group_id}/single_choice/ | 
*CategoryApi* | [**singleChoiceGroupGroupIdSingleChoicePost**](doc//CategoryApi.md#singlechoicegroupgroupidsinglechoicepost) | **POST** /single_choice_group/{group_id}/single_choice/ | 
*CategoryApi* | [**singleChoiceGroupIdDelete**](doc//CategoryApi.md#singlechoicegroupiddelete) | **DELETE** /single_choice_group/{id} | 
*CategoryApi* | [**singleChoiceGroupIdGet**](doc//CategoryApi.md#singlechoicegroupidget) | **GET** /single_choice_group/{id} | 
*CategoryApi* | [**singleChoiceGroupIdPut**](doc//CategoryApi.md#singlechoicegroupidput) | **PUT** /single_choice_group/{id} | 
*CategoryApi* | [**singleChoiceIdDelete**](doc//CategoryApi.md#singlechoiceiddelete) | **DELETE** /single_choice/{id} | 
*CategoryApi* | [**singleChoiceIdGet**](doc//CategoryApi.md#singlechoiceidget) | **GET** /single_choice/{id} | 
*CategoryApi* | [**singleChoiceIdPut**](doc//CategoryApi.md#singlechoiceidput) | **PUT** /single_choice/{id} | 
*EntryApi* | [**entriesGet**](doc//EntryApi.md#entriesget) | **GET** /entries/ | 
*EntryApi* | [**entriesIdDelete**](doc//EntryApi.md#entriesiddelete) | **DELETE** /entries/{id} | 
*EntryApi* | [**entriesIdGet**](doc//EntryApi.md#entriesidget) | **GET** /entries/{id} | 
*EntryApi* | [**entriesIdPut**](doc//EntryApi.md#entriesidput) | **PUT** /entries/{id} | 
*EntryApi* | [**entriesPost**](doc//EntryApi.md#entriespost) | **POST** /entries/ | 
*LoginApi* | [**oidcInfoGet**](doc//LoginApi.md#oidcinfoget) | **GET** /oidc_info | Obtain information about OpenID Connect
*LoginApi* | [**userGet**](doc//LoginApi.md#userget) | **GET** /user/ | 


## Documentation For Models

 - [Category](doc//Category.md)
 - [CategoryMultiChoice](doc//CategoryMultiChoice.md)
 - [CategorySingleChoice](doc//CategorySingleChoice.md)
 - [CategorySingleChoiceGroup](doc//CategorySingleChoiceGroup.md)
 - [Entry](doc//Entry.md)
 - [Error](doc//Error.md)
 - [OidcInfo](doc//OidcInfo.md)
 - [User](doc//User.md)


## Documentation For Authorization


Authentication schemes defined for the API:
### BearerToken

- **Type**: API key
- **API key parameter name**: x-token
- **Location**: HTTP header

### OauthSecurity

- **Type**: OAuth
- **Flow**: accessCode
- **Authorization URL**: https://auth.philipple.de/auth/realms/Testing/protocol/openid-connect/auth
- **Scopes**: 
 - **openid**: OpenID Connect
 - **admin**: Admin scope
 - **user**: User scope


## Author


