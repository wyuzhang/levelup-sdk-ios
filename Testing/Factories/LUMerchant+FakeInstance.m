#import "LUMerchant+FakeInstance.h"

@implementation LUMerchant (FakeInstance)

+ (LUMerchant *)fakeInstance {
  return [[LUMerchant alloc] initWithDescriptionHTML:nil earn:nil emailCaptureCohort:nil facebookURL:nil featured:NO
                                         imageURL_1x:[NSURL URLWithString:@"http://placekitten.com/g/280/128"]
                                         imageURL_2x:[NSURL URLWithString:@"http://placekitten.com/g/560/256"]
                                           locations:@[[LULocation fakeInstance]]
                                             loyalty:[LULoyalty fakeInstance]
                                      loyaltyEnabled:YES
                                          merchantID:@1
                                                name:@"Test Merchant"
                                       newsletterURL:nil opentableURL:nil publicURL:nil scvngrURL:nil spend:nil
                                     twitterUsername:nil yelpURL:nil websiteURL:nil];
}

+ (LUMerchant *)fakeInstanceWithImageURL_1x:(NSURL *)imageURL_1x imageURL_2x:(NSURL *)imageURL_2x {
  LUMerchant *merchant = [self fakeInstance];
  [merchant setValue:imageURL_1x forKey:@"imageURL_1x"];
  [merchant setValue:imageURL_2x forKey:@"imageURL_2x"];
  return merchant;
}

+ (LUMerchant *)fakeInstanceWithLocations:(NSArray *)locations {
  LUMerchant *merchant = [self fakeInstance];
  [merchant setValue:locations forKey:@"locations"];
  return merchant;
}

+ (LUMerchant *)fakeInstanceWithNoLocations {
  return [self fakeInstanceWithLocations:nil];
}

+ (LUMerchant *)fakeInstanceWithTwitterUsername:(NSString *)twitterUsername {
  LUMerchant *merchant = [self fakeInstance];
  [merchant setValue:twitterUsername forKey:@"twitterUsername"];
  return merchant;
}

+ (LUMerchant *)fakeInstanceWithWebLocations {
  LUMerchant *merchant = [self fakeInstance];
  [merchant setValue:[NSURL URLWithString:@"http://facebook.com/example"] forKey:@"facebookURL"];
  [merchant setValue:[NSURL URLWithString:@"http://example.com/newsletter"] forKey:@"newsletterURL"];
  [merchant setValue:[NSURL URLWithString:@"http://opentable.com/example"] forKey:@"opentableURL"];
  [merchant setValue:[NSURL URLWithString:@"http://scvngr.com/example"] forKey:@"scvngrURL"];
  [merchant setValue:@"example" forKey:@"twitterUsername"];
  [merchant setValue:[NSURL URLWithString:@"http://example.com"] forKey:@"websiteURL"];
  [merchant setValue:[NSURL URLWithString:@"http://yelp.com/example"] forKey:@"yelpURL"];
  return merchant;
}

+ (LUMerchant *)fakeInstanceWithoutLoyaltyEnabled {
  LUMerchant *merchant = [LUMerchant fakeInstance];
  [merchant setValue:nil forKey:@"loyalty"];
  [merchant setValue:@NO forKey:@"loyaltyEnabled"];
  return merchant;
}

@end
