#import "LUCohort.h"
#import "LULocation.h"
#import "LULoyalty.h"
#import "LUMerchant.h"
#import "LUMonetaryValue.h"
#import "LUUser.h"
#import "NSArray+LUAdditions.h"

NSString * const MerchantWebService = @"MerchantWebService";
NSString * const MerchantYelpService = @"MerchantYelpService";
NSString * const MerchantFacebookService = @"MerchantFacebookService";
NSString * const MerchantTwitterService = @"MerchantTwitterService";
NSString * const MerchantScvngrService = @"MerchantScvngrService";
NSString * const MerchantOpenTableService = @"MerchantOpenTableService";
NSString * const MerchantNewsletterService = @"MerchantNewsletterService";

@interface LUMerchant ()

@property (nonatomic, copy, readonly) NSURL *imageURL_1x;
@property (nonatomic, copy, readonly) NSURL *imageURL_2x;

@end

@implementation LUMerchant {
  NSArray *_webLocations;
}

#pragma mark - Creation

- (id)initWithDescriptionHTML:(NSString *)descriptionHTML earn:(LUMonetaryValue *)earn
           emailCaptureCohort:(LUCohort *)emailCaptureCohort facebookURL:(NSURL *)facebookURL
                     featured:(BOOL)featured imageURL_1x:(NSURL *)imageURL_1x
                  imageURL_2x:(NSURL *)imageURL_2x locations:(NSArray *)locations
                      loyalty:(LULoyalty *)loyalty merchantID:(NSNumber *)merchantID
                         name:(NSString *)name newsletterURL:(NSURL *)newsletterURL
                 opentableURL:(NSURL *)opentableURL publicURL:(NSURL *)publicURL
                    scvngrURL:(NSURL *)scvngrURL spend:(LUMonetaryValue *)spend
              twitterUsername:(NSString *)twitterUsername yelpURL:(NSURL *)yelpURL
                   websiteURL:(NSURL *)websiteURL {
  self = [super init];
  if (!self) return nil;

  _descriptionHTML = descriptionHTML;
  _earn = earn;
  _emailCaptureCohort = emailCaptureCohort;
  _facebookURL = facebookURL;
  _featured = featured;
  _imageURL_1x = imageURL_1x;
  _imageURL_2x = imageURL_2x;
  _locations = locations;
  _loyalty = loyalty;
  _merchantID = merchantID;
  _name = name;
  _newsletterURL = newsletterURL;
  _opentableURL = opentableURL;
  _publicURL = publicURL;
  _scvngrURL = scvngrURL;
  _spend = spend;
  _twitterUsername = twitterUsername;
  _yelpURL = yelpURL;
  _websiteURL = websiteURL;

  return self;
}

#pragma mark - Public Methods

- (LUMonetaryValue *)currentCredit {
  if (self.loyalty.merchantLoyaltyEnabled) {
    return self.loyalty.potentialCredit;
  } else {
    return [LUMonetaryValue monetaryValueWithUSD:@0.0f];
  }
}

- (NSURL *)imageURL {
  if ([UIScreen mainScreen].scale == 1.0f) {
    return self.imageURL_1x;
  } else {
    return self.imageURL_2x;
  }
}

- (LULocation *)locationNearestTo:(CLLocation *)location {
  NSArray *sortedLocations = [self.locations sortedArrayUsingComparator:^(LULocation *obj1, LULocation *obj2) {
    CLLocationDistance distance1 = [[obj1 location] distanceFromLocation:location];
    CLLocationDistance distance2 = [[obj2 location] distanceFromLocation:location];

    return [@(distance1) compare:@(distance2)];
  }];

  return [sortedLocations lu_firstObject];
}

- (NSURL *)twitterURL {
  if (self.twitterUsername.length == 0) return nil;

  return [NSURL URLWithString:[@"http://twitter.com/" stringByAppendingString:self.twitterUsername]];
}

- (NSArray *)webLocations {
  NSMutableArray *mutableWebLocations = [[NSMutableArray alloc] init];

  if (self.websiteURL) [mutableWebLocations addObject:@{@"service" : MerchantWebService, @"url" : self.websiteURL, @"displayName" : @"Website / Menu"}];
  if (self.yelpURL) [mutableWebLocations addObject:@{@"service" : MerchantYelpService, @"url" : self.yelpURL, @"displayName" : @"Yelp"}];
  if (self.facebookURL) [mutableWebLocations addObject:@{@"service" : MerchantFacebookService, @"url" : self.facebookURL, @"displayName" : @"Facebook"}];
  if (self.twitterURL) [mutableWebLocations addObject:@{@"service" : MerchantTwitterService, @"url" : self.twitterURL, @"displayName" : @"Twitter"}];
  if (self.scvngrURL) [mutableWebLocations addObject:@{@"service" : MerchantScvngrService, @"url" : self.scvngrURL, @"displayName" : @"SCVNGR"}];
  if (self.opentableURL) [mutableWebLocations addObject:@{@"service": MerchantOpenTableService, @"url" : self.opentableURL, @"displayName" : @"OpenTable"}];
  if (self.newsletterURL) [mutableWebLocations addObject:@{@"service" : MerchantNewsletterService, @"url" : self.newsletterURL, @"displayName" : @"Newsletter"}];

  return [NSArray arrayWithArray:mutableWebLocations];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUMerchant [descriptionHTML=%@, earn=%@, emailCaptureCohort=%@, facebookURL=%@, featured=%@, ID=%@, imageURL_1x=%@, imageURL_2x=%@, locations=%@, loyalty=%@, name=%@, newsletterURL=%@, opentableURL=%@, publicURL=%@, scvngrURL=%@, spend=%@, twitterUsername=%@, websiteURL=%@, yelpURL=%@]",
          self.descriptionHTML, self.earn, self.emailCaptureCohort, self.facebookURL,
          @(self.featured), self.merchantID, self.imageURL_1x, self.imageURL_2x, self.locations,
          self.loyalty, self.name, self.newsletterURL, self.opentableURL, self.publicURL,
          self.scvngrURL, self.spend, self.twitterUsername, self.websiteURL, self.yelpURL];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUMerchant [ID=%@, name=%@]", self.merchantID, self.name];
}

@end
