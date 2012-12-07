#import "LUCampaign.h"

SPEC_BEGIN(LUCampaignSpec)

describe(@"LUCampaign", ^{
  LUCampaign *campaignA = [[LUCampaign alloc] init];
  LUCampaign *campaignB = [[LUCampaign alloc] init];
  NSString *nameA = @"campA";
  NSString *nameB = @"campB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      campaignA.name = nameA;
      campaignB.name = nameA;

      [[theValue([campaignA isEqual:campaignB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      campaignA.name = nameA;
      campaignB.name = nameA;

      [[theValue([campaignB isEqual:campaignA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      campaignA.name = nameA;
      campaignB.name = nameA;

      [[theValue([campaignA isEqual:campaignB]) should] equal:theValue(YES)];

      campaignB.name = nameB;

      [[theValue([campaignA isEqual:campaignB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      campaignB.name = nameA;
      campaignB.name = nameB;

      [[theValue([campaignA isEqual:campaignB]) should] equal:theValue(NO)];

      campaignB.name = nameA;

      [[theValue([campaignA isEqual:campaignB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      campaignA.name = nameA;
      campaignB.name = nameA;

      [[theValue([campaignA hash]) should] equal:theValue([campaignB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      campaignA.name = nameA;
      campaignB.name = nameA;

      [[theValue([campaignA hash]) should] equal:theValue([campaignB hash])];

      campaignB.name = nameB;

      [[theValue([campaignA hash]) shouldNot] equal:theValue([campaignB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      campaignA.name = nameA;
      campaignB.name = nameB;

      [[theValue([campaignA hash]) shouldNot] equal:theValue([campaignB hash])];

      campaignB.name = nameA;

      [[theValue([campaignA hash]) should] equal:theValue([campaignB hash])];
    });
  });
});

SPEC_END
