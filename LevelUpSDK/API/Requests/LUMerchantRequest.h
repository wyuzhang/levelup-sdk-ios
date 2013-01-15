@class CLLocation;
@class LUAPIRequest;
@class LUCategory;

@interface LUMerchantRequest : NSObject

+ (LUAPIRequest *)getUserMerchantsForPage:(NSUInteger)page;
+ (LUAPIRequest *)getMerchantsNearLocation:(CLLocation *)location page:(NSUInteger)page;
+ (LUAPIRequest *)getMerchantsNearLocation:(CLLocation *)location inCategory:(LUCategory *)category page:(NSUInteger)page;
+ (LUAPIRequest *)getMerchantWithId:(NSNumber *)merchantId;

@end
