#import "LUCohort.h"
#import "LULocation.h"
#import "LULoyalty.h"
#import "LUMerchant.h"
#import "LUMonetaryValue.h"
#import "LUUser.h"
#import "NSArray+ObjectAccess.h"

NSString * const MerchantWebService = @"MerchantWebService";
NSString * const MerchantYelpService = @"MerchantYelpService";
NSString * const MerchantFacebookService = @"MerchantFacebookService";
NSString * const MerchantTwitterService = @"MerchantTwitterService";
NSString * const MerchantScvngrService = @"MerchantScvngrService";
NSString * const MerchantOpenTableService = @"MerchantOpenTableService";
NSString * const MerchantNewsletterService = @"MerchantNewsletterService";

@interface LUMerchant ()

@property (nonatomic, copy) NSString *categoryImageUrl_32x32_1x;
@property (nonatomic, copy) NSString *categoryImageUrl_32x32_2x;
@property (nonatomic, copy) NSString *imageUrl_280x128_1x;
@property (nonatomic, copy) NSString *imageUrl_280x128_2x;

@end

@implementation LUMerchant {
  NSArray *_webLocations;
}

#pragma mark - Public Methods

- (NSString *)categoryImageUrl {
  return [self valueForKey:[NSString stringWithFormat:@"categoryImageUrl_32x32_%dx", (int)[UIScreen mainScreen].scale]];
}

- (LUMonetaryValue *)currentCredit {
  if (self.loyalty) {
    return self.loyalty.potentialCredit;
  } else {
    return [LUMonetaryValue monetaryValueWithUSD:@0.0f];
  }
}

- (NSString *)imageUrl {
  return [self valueForKey:[NSString stringWithFormat:@"imageUrl_280x128_%dx", (int)[UIScreen mainScreen].scale]];
}

- (LULocation *)locationNearestTo:(CLLocation *)location {
  NSArray *sortedLocations = [self.locations sortedArrayUsingComparator:^(id obj1, id obj2) {
    CLLocationDistance distance1 = [[obj1 location] distanceFromLocation:location];
    CLLocationDistance distance2 = [[obj2 location] distanceFromLocation:location];

    return [@(distance1) compare:@(distance2)];
  }];

  return [sortedLocations firstObject];
}

- (NSString *)twitterUrl {
  NSString *twitterUrl;

  if (self.twitterUsername.length > 0) {
    twitterUrl = [@"http://twitter.com/" stringByAppendingString:self.twitterUsername];
  } else {
    twitterUrl = nil;
  }

  return twitterUrl;
}

- (NSArray *)webLocations {
  NSMutableArray *mutableWebLocations = [[NSMutableArray alloc] init];

  if ([self.url length] > 0) [mutableWebLocations addObject:@{@"service" : MerchantWebService, @"url" : self.url, @"displayName" : @"Website / Menu"}];
  if ([self.yelpUrl length] > 0) [mutableWebLocations addObject:@{@"service" : MerchantYelpService, @"url" : self.yelpUrl, @"displayName" : @"Yelp"}];
  if ([self.facebookUrl length] > 0) [mutableWebLocations addObject:@{@"service" : MerchantFacebookService, @"url" : self.facebookUrl, @"displayName" : @"Facebook"}];
  if ([self.twitterUrl length] > 0) [mutableWebLocations addObject:@{@"service" : MerchantTwitterService, @"url" : self.twitterUrl, @"displayName" : @"Twitter"}];
  if ([self.scvngrUrl length] > 0) [mutableWebLocations addObject:@{@"service" : MerchantScvngrService, @"url" : self.scvngrUrl, @"displayName" : @"SCVNGR"}];
  if ([self.opentableUrl length] > 0) [mutableWebLocations addObject:@{@"service": MerchantOpenTableService, @"url" : self.opentableUrl, @"displayName" : @"OpenTable"}];
  if ([self.newsletterUrl length] > 0) [mutableWebLocations addObject:@{@"service" : MerchantNewsletterService, @"url" : self.newsletterUrl, @"displayName" : @"Newsletter"}];

  return [NSArray arrayWithArray:mutableWebLocations];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"Merchant [categoryImageUrl_280x128_1x=%@, categoryImageUrl_280x128_2x=%@, descriptionHtml=%@, earn=%@, emailCaptureCohort=%@, facebookUrl=%@, featured=%@, ID=%@, imageUrl_280x128_1x=%@, imageUrl_280x128_2x=%@, locations=%@, loyalty=%@, loyaltyEnabled=%@, name=%@, newsletterUrl=%@, opentableUrl=%@, publicUrl=%@, scvngrUrl=%@, spend=%@, twitterUsername=%@, url=%@, yelpUrl=%@]",
          self.categoryImageUrl_32x32_1x, self.categoryImageUrl_32x32_2x, self.descriptionHtml, self.earn,
          self.emailCaptureCohort, self.facebookUrl, @(self.featured), self.merchantID, self.imageUrl_280x128_1x,
          self.imageUrl_280x128_2x, self.locations, self.loyalty, @(self.loyaltyEnabled), self.name, self.newsletterUrl,
          self.opentableUrl, self.publicUrl, self.scvngrUrl, self.spend, self.twitterUsername, self.url, self.yelpUrl];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Merchant [ID=%@, name=%@]", self.merchantID, self.name];
}

@end
