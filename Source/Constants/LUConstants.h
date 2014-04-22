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

extern NSString * const LUAPIErrorDomain;

// See LUAPIClient.h for documentation on these error keys.
extern NSString * const LUAPIErrorKeyAPIErrors;
extern NSString * const LUAPIErrorKeyErrorMessage;
extern NSString * const LUAPIErrorKeyJSONResponse;
extern NSString * const LUAPIErrorKeyOriginalError;
extern NSString * const LUAPIErrorKeyURLResponse;

/** A LevelUp API error. */
typedef NS_ENUM(NSInteger, LUAPIErrorCode) {
  /** The client must be logged in to complete the request. */
  LUAPIErrorLoginRequired,

  /** The server is currently down for maintenance. */
  LUAPIErrorMaintenance,

  /** Was unable to get to the server because the network is down. */
  LUAPIErrorNetwork,

  /** The requested resource was not found. */
  LUAPIErrorNotFound,

  /** The server responded with JSON that couldn't be parsed. */
  LUAPIErrorParsing,

  /** The server responded with an error. */
  LUAPIErrorServer,

  /** The SDK needs to be upgraded. */
  LUAPIErrorUpgrade
};

#pragma mark - Deep Link Auth Errors

extern NSString * const LUDeepLinkAuthErrorDomain;

/** A Deep Link Auth error. */
typedef NS_ENUM(NSInteger, LUDeepLinkAuthErrorCode) {
  /** The Deep Link Auth request did not include any permission keys. */
  LUDeepLinkAuthErrorPermissionsRequired = 40000,

  /** The Deep Link Auth request did not include a return URL scheme. */
  LUDeepLinkAuthErrorReturnURLSchemeRequired,

  /** The Deep Link Auth request did not include the requesting app's ID (internal error). */
  LUDeepLinkAuthErrorAppIDRequired,

  /** The Deep Link Auth request did not include a one-time pad (internal error). */
  LUDeepLinkAuthErrorOneTimePadRequired,

  /** The user does not have LevelUp installed. */
  LUDeepLinkAuthErrorAppNotInstalled,

  /** The Deep Link Auth response was not properly formed. */
  LUDeepLinkAuthErrorMalformedResponse,

  /** The user rejected the authorization request. */
  LUDeepLinkAuthErrorRequestRejected,

  /** The Deep Link Auth response did not come from the LevelUp app. */
  LUDeepLinkAuthErrorWrongSourceApplication
};
