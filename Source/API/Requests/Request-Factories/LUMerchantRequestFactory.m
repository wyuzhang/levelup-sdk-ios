#import <CoreLocation/CoreLocation.h>
#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUCategory.h"
#import "LUMerchantJSONFactory.h"
#import "LUMerchantRequestFactory.h"

@implementation LUMerchantRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForUserMerchantsOnPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/merchants", [LUAPIClient sharedClient].currentUserID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              parameters:@{@"page" : @(page)}
                                            modelFactory:[LUMerchantJSONFactory factory]];
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

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"merchants"
                                 parameters:params
                               modelFactory:[LUMerchantJSONFactory factory]];
}

+ (LUAPIRequest *)requestForMerchantWithId:(NSNumber *)merchantId {
  NSString *path = [NSString stringWithFormat:@"merchants/%@", merchantId];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 parameters:nil
                               modelFactory:[LUMerchantJSONFactory factory]];
}

@end
