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

  describe(@"confirmationText", ^{
    NSString *expectedText = @"This is a test.";
    LUCampaign *campaign = [LUCampaign fakeInstanceWithConfirmationHTML:[NSString stringWithFormat:@"<p>%@</p>", expectedText]
                                                              offerHTML:nil];

    it(@"returns confirmationHTML with HTML stripped out", ^{
      [[[campaign confirmationText] should] equal:expectedText];
    });
  });

  describe(@"imageURL", ^{
    NSURL *imageURL_1x = [NSURL URLWithString:@"http://example.com/image.png"];
    NSURL *imageURL_2x = [NSURL URLWithString:@"http://example.com/image@2x.png"];

    LUCampaign *campaign = [LUCampaign fakeInstanceWithImageURL_1x:imageURL_1x imageURL_2x:imageURL_2x];

    context(@"when the main screen scale is 1.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(1.0)];
      });

      it(@"returns the imageURL at 1x", ^{
        [[[campaign imageURL] should] equal:imageURL_1x];
      });
    });

    context(@"when the main screen scale is 2.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];
      });

      it(@"returns the imageURL at 2x", ^{
        [[[campaign imageURL] should] equal:imageURL_2x];
      });
    });
  });

  describe(@"offerText", ^{
    NSString *expectedText = @"This is a test.";
    LUCampaign *campaign = [LUCampaign fakeInstanceWithConfirmationHTML:nil
                                                              offerHTML:[NSString stringWithFormat:@"<p>%@</p>", expectedText]];

    it(@"returns offerHTML with HTML stripped out", ^{
      [[[campaign offerText] should] equal:expectedText];
    });
  });

  describe(@"share messages", ^{
    context(@"when the campaign has a referAFriendCohort", ^{
      LUCampaign *campaign = [LUCampaign fakeInstanceWithReferAFriendCohort];
      LUCohort *referAFriendCohort = [LUCohort fakeInstanceForReferAFriend];

      describe(@"shareMessageForEmailBody", ^{
        it(@"is the refer-a-friend email body", ^{
          [[campaign.shareMessageForEmailBody should] equal:referAFriendCohort.emailBody];
        });
      });

      describe(@"shareMessageForEmailSubject", ^{
        it(@"is the refer-a-friend email subject", ^{
          [[campaign.shareMessageForEmailSubject should] equal:referAFriendCohort.messageForEmailSubject];
        });
      });

      describe(@"shareMessageForTwitter", ^{
        it(@"is the refer-a-friend twitter message", ^{
          [[campaign.shareMessageForTwitter should] equal:referAFriendCohort.messageForTwitter];
        });
      });

      describe(@"shareURLForEmail", ^{
        it(@"is the refer-a-friend cohort URL", ^{
          [[campaign.shareURLForEmail should] equal:referAFriendCohort.cohortURL];
        });
      });

      describe(@"shareURLForFacebook", ^{
        it(@"is the refer-a-friend cohort URL", ^{
          [[campaign.shareURLForFacebook should] equal:referAFriendCohort.cohortURL];
        });
      });

      describe(@"shareURLForTwitter", ^{
        it(@"is the refer-a-friend cohort URL", ^{
          [[campaign.shareURLForTwitter should] equal:referAFriendCohort.cohortURL];
        });
      });
    });

    context(@"when the campaign doesn't have a referAFriendCohort", ^{
      LUCampaign *campaign = [LUCampaign fakeInstance];
      LUCohort *emailCohort = [LUCohort fakeInstanceForEmail];
      LUCohort *facebookCohort = [LUCohort fakeInstanceForFacebook];
      LUCohort *twitterCohort = [LUCohort fakeInstanceForTwitter];

      describe(@"shareMessageForEmailBody", ^{
        it(@"is the email cohort's email body", ^{
          [[campaign.shareMessageForEmailBody should] equal:emailCohort.emailBody];
        });
      });

      describe(@"shareMessageForEmailSubject", ^{
        it(@"is the email cohort's email subject", ^{
          [[campaign.shareMessageForEmailSubject should] equal:emailCohort.messageForEmailSubject];
        });
      });

      describe(@"shareMessageForTwitter", ^{
        it(@"is the twitter cohort's twitter message", ^{
          [[campaign.shareMessageForTwitter should] equal:twitterCohort.messageForTwitter];
        });
      });

      describe(@"shareURLForEmail", ^{
        it(@"is the email cohort's URL", ^{
          [[campaign.shareURLForEmail should] equal:emailCohort.cohortURL];
        });
      });

      describe(@"shareURLForFacebook", ^{
        it(@"is the facebook cohort's URL", ^{
          [[campaign.shareURLForFacebook should] equal:facebookCohort.cohortURL];
        });
      });

      describe(@"shareURLForTwitter", ^{
        it(@"is the twitter cohort's URL", ^{
          [[campaign.shareURLForTwitter should] equal:twitterCohort.cohortURL];
        });
      });
    });
  });
});

SPEC_END
