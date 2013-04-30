#import "LUCauseJSONFactory.h"

SPEC_BEGIN(LUCauseJSONFactorySpec)

describe(@"LUCauseJSONFactory", ^{
  __block LUCauseJSONFactory *factory;

  beforeEach(^{
    factory = [LUCauseJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCause", ^{
      LUCause *cause = [factory createFromAttributes:[LUCause fullJSONObject]];

      [[cause.causeID should] equal:@1];
      [[cause.descriptionHTML should] equal:@"<p>description</p>"];
      [[theValue(cause.employerRequired) should] beNo];
      [[cause.facebookURL should] equal:[NSURL URLWithString:@"http://facebook.com/example"]];
      [[theValue(cause.featured) should] beYes];
      [[theValue(cause.homeAddressRequired) should] beNo];
      [[[cause valueForKey:@"imageURL_1x"] should] equal:[NSURL URLWithString:@"http://example.com/image_url_1x"]];
      [[[cause valueForKey:@"imageURL_2x"] should] equal:[NSURL URLWithString:@"http://example.com/image_url_2x"]];
      [[cause.minimumAgeRequired should] equal:@18];
      [[cause.name should] equal:@"Test Cause"];
      [[cause.partnerSpecificTerms should] equal:@"terms"];
      [[cause.twitterUsername should] equal:@"example"];
      [[cause.websiteURL should] equal:[NSURL URLWithString:@"http://example.com"]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'cause'", ^{
      [[[factory rootKey] should] equal:@"cause"];
    });
  });
});

SPEC_END
