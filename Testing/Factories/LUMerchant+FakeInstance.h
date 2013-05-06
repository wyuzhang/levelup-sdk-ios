#import "LUMerchant.h"

@interface LUMerchant (FakeInstance)

+ (LUMerchant *)fakeInstance;
+ (LUMerchant *)fakeInstanceWithImageURL_1x:(NSURL *)imageURL_1x imageURL_2x:(NSURL *)imageURL_2x;
+ (LUMerchant *)fakeInstanceWithLocations:(NSArray *)locations;
+ (LUMerchant *)fakeInstanceWithNoLocations;
+ (LUMerchant *)fakeInstanceWithTwitterUsername:(NSString *)twitterUsername;
+ (LUMerchant *)fakeInstanceWithWebLocations;
+ (LUMerchant *)fakeInstanceWithoutLoyaltyEnabled;

@end
