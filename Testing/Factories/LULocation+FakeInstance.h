#import "LULocation.h"

@interface LULocation (FakeInstance)

+ (LULocation *)fakeInstance;
+ (LULocation *)fakeInstanceWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;
+ (LULocation *)fakeInstanceWithLocationID:(NSNumber *)locationID;
+ (LULocation *)fakeInstanceWithNoExtendedAddress;

@end
