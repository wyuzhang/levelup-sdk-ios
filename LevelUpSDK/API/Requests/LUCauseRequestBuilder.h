@class CLLocation;
@class LUAPIRequest;
@class LUCauseCategory;

@interface LUCauseRequestBuilder : NSObject

+ (LUAPIRequest *)requestForAllFeaturedCauses;
+ (LUAPIRequest *)requestForCausesInCategory:(LUCauseCategory *)causeCategory page:(NSUInteger)page;
+ (LUAPIRequest *)requestForCausesNearLocation:(CLLocation *)location page:(NSUInteger)page;
+ (LUAPIRequest *)requestForCausesOnPage:(NSUInteger)page;

@end
