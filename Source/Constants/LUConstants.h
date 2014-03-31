// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

extern NSString * const LevelUpSDKVersion;

extern NSString * const BraintreePublicKeyDevelopment;
extern NSString * const BraintreePublicKeyProduction;

extern NSString * const LevelUpAPIBaseURLDevelopment;
extern NSString * const LevelUpAPIBaseURLProduction;

#pragma mark - Deep Link Auth URL Hosts & Params

extern NSString * const LUDeepLinkAuthRequestHost;
extern NSString * const LUDeepLinkAuthResponseHost;

#pragma mark - Deep Link Auth Notifications

extern NSString * const LUDeepLinkAuthErrorNotification;
extern NSString * const LUDeepLinkAuthSuccessNotification;

extern NSString * const LUDeepLinkAuthNotificationAccessTokenKey;
extern NSString * const LUDeepLinkAuthNotificationErrorKey;

#pragma mark - API Errors

// See LUAPIClient.h for documentation on these error keys and error codes.
extern NSString * const LUAPIErrorDomain;
extern NSString * const LUAPIErrorKeyAPIErrors;
extern NSString * const LUAPIErrorKeyErrorMessage;
extern NSString * const LUAPIErrorKeyJSONResponse;
extern NSString * const LUAPIErrorKeyOriginalError;
extern NSString * const LUAPIErrorKeyURLResponse;

typedef NS_ENUM(NSInteger, LUAPIErrorCode) {
  LUAPIErrorLoginRequired,
  LUAPIErrorMaintenance,
  LUAPIErrorNetwork,
  LUAPIErrorNotFound,
  LUAPIErrorParsing,
  LUAPIErrorServer,
  LUAPIErrorUpgrade
};

#pragma mark - Deep Link Auth Errors

extern NSString * const LUDeepLinkAuthErrorDomain;

typedef NS_ENUM(NSInteger, LUDeepLinkAuthErrorCode) {
  LUDeepLinkAuthErrorPermissionsRequired = 40000,
  LUDeepLinkAuthErrorReturnURLSchemeRequired,
  LUDeepLinkAuthErrorAppIDRequired,
  LUDeepLinkAuthErrorOneTimePadRequired,
  LUDeepLinkAuthErrorAppNotInstalled,
  LUDeepLinkAuthErrorMalformedResponse,
  LUDeepLinkAuthErrorRequestRejected,
  LUDeepLinkAuthErrorWrongSourceApplication
};
