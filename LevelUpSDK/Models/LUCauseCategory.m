#import "LUCauseCategory.h"
#import "LUJSONDeserializer.h"

@implementation LUCauseCategory

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"cause_category"];
  }
}

@end
