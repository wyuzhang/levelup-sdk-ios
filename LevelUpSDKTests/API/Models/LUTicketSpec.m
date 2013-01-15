#import "LUTicket.h"

SPEC_BEGIN(LUTicketSpec)

describe(@"LUTicket", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUTicket class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
