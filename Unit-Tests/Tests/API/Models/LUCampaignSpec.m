// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCampaign.h"
#import "LUMonetaryValue.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LUCampaignSpec)

describe(@"LUCampaign", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCampaign class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"confirmationText", ^{
    NSString *expectedText = @"This is a test.";
    LUCampaign *campaign = [LUCampaign fixtureWithConfirmationHTML:[NSString stringWithFormat:@"<p>%@</p>", expectedText]
                                                         offerHTML:nil];

    it(@"returns confirmationHTML with HTML stripped out", ^{
      [[[campaign confirmationText] should] equal:expectedText];
    });
  });

  describe(@"imageURL", ^{
    LUCampaign *campaign = [LUCampaign fixtureWithCampaignID:@1];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/path/to/image"];

    beforeEach(^{
      [NSURL stub:@selector(lu_imageURLForCampaignWithID:) andReturn:URL withArguments:@1];
    });

    it(@"returns the URL of the location image request", ^{
      [[[campaign imageURL] should] equal:URL];
    });
  });

  describe(@"offerText", ^{
    NSString *expectedText = @"This is a test.";
    LUCampaign *campaign = [LUCampaign fixtureWithConfirmationHTML:nil
                                                         offerHTML:[NSString stringWithFormat:@"<p>%@</p>", expectedText]];

    it(@"returns offerHTML with HTML stripped out", ^{
      [[[campaign offerText] should] equal:expectedText];
    });
  });
});

SPEC_END
