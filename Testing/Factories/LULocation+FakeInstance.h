#import "LULocation.h"

@interface LULocation (FakeInstance)

+ (LULocation *)fakeInstance;
+ (LULocation *)fakeInstanceWithLat:(NSNumber *)lat lng:(NSNumber *)lng;
+ (LULocation *)fakeInstanceWithNoExtendedAddress;

@end
