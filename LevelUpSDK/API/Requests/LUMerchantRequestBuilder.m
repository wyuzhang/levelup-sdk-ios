#import <CoreLocation/CoreLocation.h>
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCategory.h"
#import "LUMerchantRequestBuilder.h"

@implementation LUMerchantRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForUserMerchantsOnPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/merchants", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:@{@"page" : @(page)}];
}

+ (LUAPIRequest *)requestForMerchantsNearLocation:(CLLocation *)location page:(NSUInteger)page {
  return [self requestForMerchantsNearLocation:location inCategory:nil page:page];
}

+ (LUAPIRequest *)requestForMerchantsNearLocation:(CLLocation *)location inCategory:(LUCategory *)category page:(NSUInteger)page {
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{
                                   @"lat" : @(location.coordinate.latitude),
                                   @"lng" : @(location.coordinate.longitude),
                                   @"page" : @(page)
                                 }];

  if (category) {
    params[@"category_ids"] = category.categoryID;
  }

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"merchants" parameters:params];
}

+ (LUAPIRequest *)requestForMerchantWithId:(NSNumber *)merchantId {
  NSString *path = [NSString stringWithFormat:@"merchants/%@", merchantId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

@end
