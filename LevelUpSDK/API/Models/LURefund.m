#import "LURefund.h"

@implementation LURefund

#pragma mark - Creation

- (id)initWithCreatedDate:(NSDate *)createdDate order:(LUOrder *)order refundID:(NSNumber *)refundID {
  self = [super init];
  if (!self) return nil;

  _createdDate = createdDate;
  _order = order;
  _refundID = refundID;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LURefund [createdDate=%@, ID=%@, order=%@]", self.createdDate,
          self.refundID, self.order];
}

@end
