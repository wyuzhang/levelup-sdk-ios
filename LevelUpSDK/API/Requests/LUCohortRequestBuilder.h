/**
 `LUCohortRequestBuilder` is used to build requests related to cohorts.
 */
@class LUAPIRequest;

@interface LUCohortRequestBuilder : NSObject

/**
 Builds a request to retrieve a cohort.

 On success, this request will return an instance of `LUCohort`.

 @param code The cohort's code. Often this will come from a QR code that the user has scanned.
 */
+ (LUAPIRequest *)requestForCohortWithCode:(NSString *)code;

@end
