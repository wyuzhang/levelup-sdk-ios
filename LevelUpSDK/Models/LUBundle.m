#import "LUBundle.h"
#import "LUJSONDeserializer.h"
#import "LUOrder.h"
#import "LUMonetaryValue.h"

@implementation LUBundle

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"bundle"];
  }
}

@end
