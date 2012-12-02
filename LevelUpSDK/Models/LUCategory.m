#import "LUCategory.h"
#import "LUJSONDeserializer.h"

@implementation LUCategory

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"category"];
  }
}

@end
