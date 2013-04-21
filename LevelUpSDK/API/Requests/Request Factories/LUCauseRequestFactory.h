/**
 `LUCauseRequestFactory` builds requests to retrieve causes.
 */
@class CLLocation;
@class LUAPIRequest;
@class LUCauseCategory;

@interface LUCauseRequestFactory : NSObject

/**
 Builds a request to retrieve all causes that have been marked as "featured".

 On success, this request will return an array of `LUCause` instances.
 */
+ (LUAPIRequest *)requestForAllFeaturedCauses;

/**
 Builds a request to retrieve a set of causes in a category on a specific page.

 On success, this request will return an array of `LUCause` instances.

 @param causeCategory The `LUCauseCategory` of causes to retrieve.
 @param page The page of causes to retrieve.
 */
+ (LUAPIRequest *)requestForCausesInCategory:(LUCauseCategory *)causeCategory page:(NSUInteger)page;

/**
 Builds a request to retrieve a page of causes near a location. The exact radius may change, but is currently 50 miles.

 On success, this request will return an array of `LUCause` instances.

 @param location A `CLLocation` to use as the center of the search circle.
 @param page The page of causes to retrieve.
 */
+ (LUAPIRequest *)requestForCausesNearLocation:(CLLocation *)location page:(NSUInteger)page;

/**
 Builds a request to retrieve all causes on the given page.

 On success, this request will return an array of `LUCause` instances.

 @param page The page of causes to retrieve.
 */
+ (LUAPIRequest *)requestForCausesOnPage:(NSUInteger)page;

@end
