#import <Foundation/Foundation.h>

@class CLLocation;
@class LUAPIRequest;
@class LUCauseCategory;

@interface LUCauseRequest : NSObject

+ (LUAPIRequest *)getCausesInCategory:(LUCauseCategory *)causeCategory page:(NSUInteger)page;
+ (LUAPIRequest *)getCausesNearLocation:(CLLocation *)location page:(NSUInteger)page;
+ (LUAPIRequest *)getCausesOnPage:(NSUInteger)page;
+ (LUAPIRequest *)getFeaturedCauses;

@end
