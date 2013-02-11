#import "LUCampaign.h"
#import "LUCohort.h"
#import "LUMerchant.h"
#import "LUMonetaryValue.h"

SPEC_BEGIN(LUCampaignSpec)

describe(@"LUCampaign", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCampaign class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  __block LUCampaign *campaign;

  beforeEach(^{
    campaign = [[LUCampaign alloc] init];
  });

  describe(@"cohort methods", ^{
    __block LUCohort *emailCohort, *facebookCohort, *twitterCohort;

    beforeEach(^{
      emailCohort = [[LUCohort alloc] init];
      emailCohort.cohortType = @"default_email";

      facebookCohort = [[LUCohort alloc] init];
      facebookCohort.cohortType = @"default_facebook";

      twitterCohort = [[LUCohort alloc] init];
      twitterCohort.cohortType = @"default_twitter";
    });

    describe(@"emailCohort", ^{
      context(@"when the campaign has no email cohorts", ^{
        beforeEach(^{
          campaign.cohorts = @[facebookCohort, twitterCohort];
        });

        it(@"is nil", ^{
          [[campaign emailCohort] shouldBeNil];
        });
      });

      context(@"when the campaign has an email cohort", ^{
        beforeEach(^{
          campaign.cohorts = @[emailCohort, facebookCohort, twitterCohort];
        });

        it(@"returns the email cohort", ^{
          [[[campaign emailCohort] should] equal:emailCohort];
        });
      });
    });

    describe(@"facebookCohort", ^{
      context(@"when the campaign has no facebook cohorts", ^{
        beforeEach(^{
          campaign.cohorts = @[emailCohort, twitterCohort];
        });

        it(@"is nil", ^{
          [[campaign facebookCohort] shouldBeNil];
        });
      });

      context(@"when the campaign has a facebook cohort", ^{
        beforeEach(^{
          campaign.cohorts = @[emailCohort, facebookCohort, twitterCohort];
        });

        it(@"returns the facebook cohort", ^{
          [[[campaign facebookCohort] should] equal:facebookCohort];
        });
      });
    });

    describe(@"twitterCohort", ^{
      context(@"when the campaign has no twitter cohorts", ^{
        beforeEach(^{
          campaign.cohorts = @[emailCohort, facebookCohort];
        });

        it(@"is nil", ^{
          [[campaign twitterCohort] shouldBeNil];
        });
      });

      context(@"when the campaign has a twitter cohort", ^{
        beforeEach(^{
          campaign.cohorts = @[emailCohort, facebookCohort, twitterCohort];
        });

        it(@"returns the twitter cohort", ^{
          [[[campaign twitterCohort] should] equal:twitterCohort];
        });
      });
    });
  });

  describe(@"confirmationText", ^{
    it(@"returns confirmationHtml with HTML stripped out", ^{
      NSString *expectedText = @"This is a test.";
      campaign.confirmationHtml = [NSString stringWithFormat:@"<p>%@</p>", expectedText];

      [[[campaign confirmationText] should] equal:expectedText];
    });
  });

  describe(@"isGlobal", ^{
    context(@"when the campaign is global", ^{
      beforeEach(^{
        campaign.global = YES;
      });

      it(@"is YES", ^{
        [[theValue([campaign isGlobal]) should] beYes];
      });
    });

    context(@"when the campaign is not global but has zero merchants", ^{
      beforeEach(^{
        campaign.global = NO;
        campaign.merchants = @[];
      });

      it(@"is YES", ^{
        [[theValue([campaign isGlobal]) should] beYes];
      });
    });

    context(@"when the campaign is not global and has at least one merchant", ^{
      beforeEach(^{
        campaign.global = NO;
        campaign.merchants = @[[[LUMerchant alloc] init]];
      });

      it(@"is NO", ^{
        [[theValue([campaign isGlobal]) should] beNo];
      });
    });
  });

  describe(@"mobileImageUrl", ^{
    beforeEach(^{
      campaign.mobileImageUrl_320x212_1x = @"mobile_image_1x";
      campaign.mobileImageUrl_320x212_2x = @"mobile_image_2x";
    });

    context(@"when the main screen scale is 1.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(1.0)];
      });

      it(@"returns the mobileImageUrl at 1x", ^{
        [[[campaign mobileImageUrl] should] equal:campaign.mobileImageUrl_320x212_1x];
      });
    });

    context(@"when the main screen scale is 2.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];
      });

      it(@"returns the mobileImageUrl at 2x", ^{
        [[[campaign mobileImageUrl] should] equal:campaign.mobileImageUrl_320x212_2x];
      });
    });
  });

  describe(@"offerText", ^{
    it(@"returns offerHtml with HTML stripped out", ^{
      NSString *expectedText = @"This is a test.";
      campaign.offerHtml = [NSString stringWithFormat:@"<p>%@</p>", expectedText];

      [[[campaign offerText] should] equal:expectedText];
    });
  });

  describe(@"successfulClaimMessageHtml", ^{
    beforeEach(^{
      campaign.confirmationHtml = @"confirmation";
      campaign.offerHtml = @"offer";
    });

    context(@"when the campaign has non-empty confirmationHtml", ^{
      it(@"returns the confirmationHtml", ^{
        [[[campaign successfulClaimMessageHtml] should] equal:campaign.confirmationHtml];
      });
    });

    context(@"when the campaign has no confirmationHtml, but has offerHtml", ^{
      beforeEach(^{
        campaign.confirmationHtml = @"";
      });

      it(@"returns the offerHtml", ^{
        [[[campaign successfulClaimMessageHtml] should] equal:campaign.offerHtml];
      });
    });
  });

  describe(@"successfulClaimMessageText", ^{
    it(@"returns successfulClaimMessageHtml with HTML stripped out", ^{
      NSString *expectedText = @"This is a test.";
      [campaign stub:@selector(successfulClaimMessageHtml) andReturn:[NSString stringWithFormat:@"<p>%@</p>", expectedText]];

      [[[campaign successfulClaimMessageText] should] equal:expectedText];
    });
  });
});

SPEC_END
