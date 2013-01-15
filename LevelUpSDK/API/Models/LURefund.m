#import "LURefund.h"
#import "NSDate+StringFormats.h"

@interface LURefund ()

@property (nonatomic, copy) NSString *createdAt;

@end

@implementation LURefund

#pragma mark - Public Methods

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

@end
