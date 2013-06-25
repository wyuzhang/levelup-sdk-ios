extern NSString * const LevelUpSDKVersion;

extern NSString * const BraintreePublicKeyDevelopment;
extern NSString * const BraintreePublicKeyProduction;

extern NSString * const LevelUpAPIBaseURLDevelopment;
extern NSString * const LevelUpAPIBaseURLProduction;

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
