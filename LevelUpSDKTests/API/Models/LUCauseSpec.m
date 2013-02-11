#import "LUCause.h"

SPEC_BEGIN(LUCauseSpec)

describe(@"LUCause", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCause class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  __block LUCause *cause;

  beforeEach(^{
    cause = [[LUCause alloc] init];
  });

  describe(@"anyUserRequirements", ^{
    it(@"is YES if one of isEmployerRequired, isHomeAddressRequired, isMinimumAgeRequired or hasPartnerSpecificTerms are true", ^{
      cause.employerRequired = NO;
      cause.homeAddressRequired = NO;
      cause.minimumAgeRequired = nil;
      cause.partnerSpecificTerms = nil;
      [[theValue([cause anyUserRequirements]) should] beNo];

      cause.employerRequired = YES;
      [[theValue([cause anyUserRequirements]) should] beYes];

      cause.employerRequired = NO;
      cause.homeAddressRequired = YES;
      [[theValue([cause anyUserRequirements]) should] beYes];

      cause.homeAddressRequired = NO;
      cause.minimumAgeRequired = @18;
      [[theValue([cause anyUserRequirements]) should] beYes];

      cause.minimumAgeRequired = nil;
      cause.partnerSpecificTerms = @"terms";
      [[theValue([cause anyUserRequirements]) should] beYes];
    });
  });

  describe(@"hasMinimumAgeRequired", ^{
    context(@"when minimumAgeRequired is nil", ^{
      beforeEach(^{
        cause.minimumAgeRequired = nil;
      });

      it(@"is NO", ^{
        [[theValue([cause hasMinimumAgeRequired]) should] beNo];
      });
    });

    context(@"when minimumAgeRequired is 0", ^{
      beforeEach(^{
        cause.minimumAgeRequired = @0;
      });

      it(@"is NO", ^{
        [[theValue([cause hasMinimumAgeRequired]) should] beNo];
      });
    });

    context(@"when minimumAgeRequired is non-zero", ^{
      beforeEach(^{
        cause.minimumAgeRequired = @18;
      });

      it(@"is YES", ^{
        [[theValue([cause hasMinimumAgeRequired]) should] beYes];
      });
    });
  });

  describe(@"hasPartnerSpecificTerms", ^{
    context(@"when partnerSpecificTerms is nil", ^{
      beforeEach(^{
        cause.partnerSpecificTerms = nil;
      });

      it(@"is NO", ^{
        [[theValue([cause hasPartnerSpecificTerms]) should] beNo];
      });
    });

    context(@"when partnerSpecificTerms is an empty string", ^{
      beforeEach(^{
        cause.partnerSpecificTerms = @"";
      });

      it(@"is NO", ^{
        [[theValue([cause hasPartnerSpecificTerms]) should] beNo];
      });
    });

    context(@"when partnerSpecificTerms is a string with length greater than 0", ^{
      beforeEach(^{
        cause.partnerSpecificTerms = @"terms";
      });

      it(@"is YES", ^{
        [[theValue([cause hasPartnerSpecificTerms]) should] beYes];
      });
    });
  });

  describe(@"imageUrl", ^{
    beforeEach(^{
      cause.imageUrl_320x212_1x = @"image_1x";
      cause.imageUrl_320x212_2x = @"image_2x";
    });

    context(@"when the main screen scale is 1.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(1.0)];
      });

      it(@"returns the imageUrl at 1x", ^{
        [[[cause imageUrl] should] equal:cause.imageUrl_320x212_1x];
      });
    });

    context(@"when the main screen scale is 2.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];
      });

      it(@"returns the imageUrl at 2x", ^{
        [[[cause imageUrl] should] equal:cause.imageUrl_320x212_2x];
      });
    });
  });

  describe(@"twitterUrl", ^{
    context(@"when the twitter username is blank", ^{
      beforeEach(^{
        cause.twitterUsername = @"";
      });

      it(@"is nil", ^{
        [[cause twitterUrl] shouldBeNil];
      });

      context(@"when the twitter username is non-empty", ^{
        beforeEach(^{
          cause.twitterUsername = @"TheLevelUp";
        });

        it(@"is the twitter URL for the username", ^{
          [[[cause twitterUrl] should] equal:@"http://twitter.com/TheLevelUp"];
        });
      });
    });
  });
});

SPEC_END
