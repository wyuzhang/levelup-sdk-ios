#import "LURefund.h"

@implementation LURefund

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"Refund [createdAt=%@, ID=%@, order=%@]", self.createdAt, self.refundID,
          self.order];
}

@end
