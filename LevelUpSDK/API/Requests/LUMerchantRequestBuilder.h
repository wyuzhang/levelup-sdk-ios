@class CLLocation;
@class LUAPIRequest;
@class LUCategory;

@interface LUMerchantRequestBuilder : NSObject

+ (LUAPIRequest *)requestForUserMerchantsOnPage:(NSUInteger)page;
+ (LUAPIRequest *)requestForMerchantsNearLocation:(CLLocation *)location page:(NSUInteger)page;
+ (LUAPIRequest *)requestForMerchantsNearLocation:(CLLocation *)location inCategory:(LUCategory *)category page:(NSUInteger)page;
+ (LUAPIRequest *)requestForMerchantWithId:(NSNumber *)merchantId;

@end
