/**
 `LUBundleRequestFactory` is used to build requests to retrieve user bundles.
 */
@interface LUBundleRequestFactory : NSObject

/**
 Builds a request to retrieve the user's bundles on the given page.

 On success, this request will return an array of `LUBundle` instances.

 @param page The page of bundles to retrieve.
 */
+ (LUAPIRequest *)requestForBundlesOnPage:(NSUInteger)page;

@end
