#import "LULoyalty.h"

SPEC_BEGIN(LULoyaltySpec)

describe(@"LULoyalty", ^{
  it(@"is an LUAPIModel", ^{
    [[[LULoyalty class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  __block LULoyalty *loyalty;

  beforeEach(^{
    loyalty = [[LULoyalty alloc] init];
  });

  describe(@"progress", ^{
    it(@"returns the progressPercent as a ratio", ^{
      loyalty.progressPercent = 50.0f;

      [[theValue(loyalty.progress) should] equal:theValue(0.5f)];
    });
  });

  describe(@"setProgress:", ^{
    it(@"sets the progressPercent", ^{
      loyalty.progress = 0.25f;

      [[theValue(loyalty.progressPercent) should] equal:theValue(25.0f)];
    });
  });
});

SPEC_END
