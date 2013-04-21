#import "LUCause.h"

SPEC_BEGIN(LUCauseSpec)

describe(@"LUCause", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCause class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"anyUserRequirements", ^{
    it(@"is YES if one of isEmployerRequired, isHomeAddressRequired, isMinimumAgeRequired or hasPartnerSpecificTerms are true", ^{
      LUCause *cause = [LUCause fakeInstanceWithNoRequirements];
      [[theValue([cause anyUserRequirements]) should] beNo];

      cause = [LUCause fakeInstanceWithEmployerRequirement];
      [[theValue([cause anyUserRequirements]) should] beYes];

      cause = [LUCause fakeInstanceWithHomeAddressRequirement];
      [[theValue([cause anyUserRequirements]) should] beYes];

      cause = [LUCause fakeInstanceWithAgeRequirement:@18];
      [[theValue([cause anyUserRequirements]) should] beYes];

      cause = [LUCause fakeInstanceWithTerms:@"terms"];
      [[theValue([cause anyUserRequirements]) should] beYes];
    });
  });

  describe(@"hasMinimumAgeRequired", ^{
    context(@"when there is no age requirment", ^{
      LUCause *cause = [LUCause fakeInstanceWithNoRequirements];

      it(@"is NO", ^{
        [[theValue([cause hasMinimumAgeRequired]) should] beNo];
      });
    });

    context(@"when the age requirement is 0", ^{
      LUCause *cause = [LUCause fakeInstanceWithAgeRequirement:@0];

      it(@"is NO", ^{
        [[theValue([cause hasMinimumAgeRequired]) should] beNo];
      });
    });

    context(@"when minimumAgeRequired is non-zero", ^{
      LUCause *cause = [LUCause fakeInstanceWithAgeRequirement:@18];

      it(@"is YES", ^{
        [[theValue([cause hasMinimumAgeRequired]) should] beYes];
      });
    });
  });

  describe(@"hasPartnerSpecificTerms", ^{
    context(@"when partnerSpecificTerms is nil", ^{
      LUCause *cause = [LUCause fakeInstanceWithNoRequirements];

      it(@"is NO", ^{
        [[theValue([cause hasPartnerSpecificTerms]) should] beNo];
      });
    });

    context(@"when partnerSpecificTerms is an empty string", ^{
      LUCause *cause = [LUCause fakeInstanceWithTerms:@""];

      it(@"is NO", ^{
        [[theValue([cause hasPartnerSpecificTerms]) should] beNo];
      });
    });

    context(@"when partnerSpecificTerms is a string with length greater than 0", ^{
      LUCause *cause = [LUCause fakeInstanceWithTerms:@"terms"];

      it(@"is YES", ^{
        [[theValue([cause hasPartnerSpecificTerms]) should] beYes];
      });
    });
  });

  describe(@"imageURL", ^{
    NSURL *imageURL_1x = [NSURL URLWithString:@"http://example.com/image.png"];
    NSURL *imageURL_2x = [NSURL URLWithString:@"http://example.com/image@2x.png"];

    LUCause *cause = [LUCause fakeInstanceWithImageURL_1x:imageURL_1x imageURL_2x:imageURL_2x];

    context(@"when the main screen scale is 1.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(1.0)];
      });

      it(@"returns the imageURL at 1x", ^{
        [[[cause imageURL] should] equal:imageURL_1x];
      });
    });

    context(@"when the main screen scale is 2.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];
      });

      it(@"returns the imageURL at 2x", ^{
        [[[cause imageURL] should] equal:imageURL_2x];
      });
    });
  });

  describe(@"twitterURL", ^{
    context(@"when the twitter username is blank", ^{
      LUCause *cause = [LUCause fakeInstanceWithTwitterUsername:@""];

      it(@"is nil", ^{
        [[cause twitterURL] shouldBeNil];
      });
    });

    context(@"when the twitter username is non-empty", ^{
      LUCause *cause = [LUCause fakeInstanceWithTwitterUsername:@"TheLevelUp"];

      it(@"is the twitter URL for the username", ^{
        [[[cause twitterURL] should] equal:[NSURL URLWithString:@"http://twitter.com/TheLevelUp"]];
      });
    });
  });
});

SPEC_END
