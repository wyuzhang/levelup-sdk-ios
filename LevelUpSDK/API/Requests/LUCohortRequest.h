@class LUAPIRequest;

@interface LUCohortRequest : NSObject

+ (LUAPIRequest *)getCohortWithCode:(NSString *)code;

@end
