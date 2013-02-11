#import "LUInterstitialAction.h"

SPEC_BEGIN(LUInterstitialActionSpec)

describe(@"LUInterstitialAction", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUInterstitialAction class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  __block LUInterstitialAction *interstitialAction;

  beforeEach(^{
    interstitialAction = [[LUInterstitialAction alloc] init];
  });

  describe(@"isCustomerAcquisitionShare", ^{
    context(@"when the type is 'customer_acquisition_share'", ^{
      beforeEach(^{
        interstitialAction.type = @"customer_acquisition_share";
      });

      it(@"is YES", ^{
        [[theValue([interstitialAction isCustomerAcquisitionShare]) should] beYes];
      });
    });

    context(@"when the type is not 'customer_acquisition_share'", ^{
      beforeEach(^{
        interstitialAction.type = @"other";
      });

      it(@"is NO", ^{
        [[theValue([interstitialAction isCustomerAcquisitionShare]) should] beNo];
      });
    });
  });

  describe(@"isEmailCaptureClaim", ^{
    context(@"when the type is 'email_capture_claim'", ^{
      beforeEach(^{
        interstitialAction.type = @"email_capture_claim";
      });

      it(@"is YES", ^{
        [[theValue([interstitialAction isEmailCaptureClaim]) should] beYes];
      });
    });

    context(@"when the type is not 'email_capture_claim'", ^{
      beforeEach(^{
        interstitialAction.type = @"other";
      });

      it(@"is NO", ^{
        [[theValue([interstitialAction isEmailCaptureClaim]) should] beNo];
      });
    });
  });
});

SPEC_END
