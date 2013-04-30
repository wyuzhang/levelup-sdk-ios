#import "LUInterstitialAction.h"

SPEC_BEGIN(LUInterstitialActionSpec)

describe(@"LUInterstitialAction", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUInterstitialAction class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
