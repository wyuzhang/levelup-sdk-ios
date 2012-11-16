#import "LUJSONDeserializer.h"
#import "LUQRCode.h"

@implementation LUQRCode

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"qr_code"];
  }
}

@end
