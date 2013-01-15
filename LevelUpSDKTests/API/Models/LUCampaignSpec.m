#import "LUCampaign.h"

SPEC_BEGIN(LUCampaignSpec)

describe(@"LUCampaign", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUCampaign class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
