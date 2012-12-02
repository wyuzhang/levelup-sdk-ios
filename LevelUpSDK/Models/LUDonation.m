#import "LUDonation.h"
#import "LUJSONDeserializer.h"

@implementation LUDonation

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"donation"];
  }
}

@end
