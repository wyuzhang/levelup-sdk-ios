#import <CoreLocation/CoreLocation.h>
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCategory.h"
#import "LUMerchantRequest.h"

@implementation LUMerchantRequest

+ (LUAPIRequest *)getUserMerchantsForPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/merchants", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:@{@"page" : @(page)}];
}

+ (LUAPIRequest *)getMerchantsNearLocation:(CLLocation *)location page:(NSUInteger)page {
  return [self getMerchantsNearLocation:location inCategory:nil page:page];
}

+ (LUAPIRequest *)getMerchantsNearLocation:(CLLocation *)location inCategory:(LUCategory *)category page:(NSUInteger)page {
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{
                                 @"lat" : @(location.coordinate.latitude),
                                 @"lng" : @(location.coordinate.longitude),
                                 @"page" : @(page) }];

  if (category) {
    params[@"category_ids"] = category.modelId;
  }

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"merchants" parameters:params];
}

+ (LUAPIRequest *)getMerchantWithId:(NSNumber *)merchantId {
  NSString *path = [NSString stringWithFormat:@"merchants/%@", merchantId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

@end
