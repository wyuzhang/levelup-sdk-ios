#import "LUBundle.h"
#import "LUJSONDeserializer.h"
#import "LUOrder.h"
#import "LUMonetaryValue.h"
#import "NSDate+StringFormats.h"

@interface LUBundle ()

@property (nonatomic, copy) NSString *chargedAt;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *state;

@end

@implementation LUBundle

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"bundle"];
  }
}

#pragma mark - Public methods

- (NSDate *)chargeDate {
  return [NSDate dateFromIso8601DateTimeString:self.chargedAt];
}

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

- (BOOL)hasChargeData {
  return (self.chargedAt != nil);
}

- (BOOL)isClosed {
  return [self.state isEqualToString:@"closed"];
}

@end
