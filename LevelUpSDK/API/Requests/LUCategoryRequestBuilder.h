@class LUAPIRequest;

@interface LUCategoryRequestBuilder : NSObject

+ (LUAPIRequest *)requestForAllCategories;
+ (LUAPIRequest *)requestForAllCauseCategories;

@end
