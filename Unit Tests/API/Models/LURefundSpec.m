#import "LURefund.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LURefundSpec)

describe(@"LURefund", ^{
  it(@"is an LUAPIModel", ^{
    [[[LURefund class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  __block LURefund *refund;

  beforeEach(^{
    refund = [[LURefund alloc] init];
  });

  describe(@"creationDate", ^{
    it(@"returns createdAt as an NSDate", ^{
      NSDate *date = [NSDate date];
      NSString *dateString = [date iso8601DateTimeString];
      [refund setValue:dateString forKey:@"createdAt"];

      [[theValue([[refund creationDate] timeIntervalSince1970]) should] equal:[date timeIntervalSince1970] withDelta:1.0];
    });
  });
});

SPEC_END
