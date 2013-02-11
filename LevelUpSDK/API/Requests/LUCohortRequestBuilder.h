@class LUAPIRequest;

@interface LUCohortRequestBuilder : NSObject

+ (LUAPIRequest *)requestForCohortWithCode:(NSString *)code;

@end
