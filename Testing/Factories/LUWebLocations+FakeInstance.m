#import "LUWebLocations+FakeInstance.h"

@implementation LUWebLocations (FakeInstance)

+ (LUWebLocations *)fakeInstance {
  return [[LUWebLocations alloc] initWithFacebookAddress:@"http://facebook.com/pizza"
                                             menuAddress:@"http://pizza.com/menu"
                                       newsletterAddress:@"http://pizza.com/newsletter"
                                        opentableAddress:@"http://opentable.com/pizza"
                                          twitterAddress:@"http://twitter.com/pizza"
                                             yelpAddress:@"http://yelp.com/pizza"];
}

@end
