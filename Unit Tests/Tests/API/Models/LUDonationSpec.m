#import "LUDonation.h"

SPEC_BEGIN(LUDonationSpec)

describe(@"LUDonation", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUDonation class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
