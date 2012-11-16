#import "LUClaim.h"
#import "LUJSONDeserializer.h"

@implementation LUClaim

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"claim"];
  }
}

@end
