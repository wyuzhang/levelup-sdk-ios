#import "LURefund+FakeInstance.h"

@implementation LURefund (FakeInstance)

+ (LURefund *)fakeInstance {
  return [[LURefund alloc] initWithCreatedDate:[NSDate date]
                                         order:[LUOrder fakeInstance]
                                      refundID:@1];
}

@end
