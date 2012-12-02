#import <Foundation/Foundation.h>

@class LUAPIRequest;

@interface LUCohortRequest : NSObject

+ (LUAPIRequest *)getCohortWithCode:(NSString *)code;

@end
