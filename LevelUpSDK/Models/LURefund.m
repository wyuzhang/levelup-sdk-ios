#import "LUJSONDeserializer.h"
#import "LUOrder.h"
#import "LURefund.h"
#import "NSDate+StringFormats.h"

@interface LURefund ()

@property (nonatomic, copy) NSString *createdAt;

@end

@implementation LURefund

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"refund"];
  }
}

#pragma mark - Properties

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

@end
