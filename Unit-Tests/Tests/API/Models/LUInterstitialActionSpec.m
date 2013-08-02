#import "LUInterstitial.h"

SPEC_BEGIN(LUInterstitialActionSpec)

describe(@"LUInterstitialAction", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUInterstitial class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
