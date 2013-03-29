#import "LUQRCode.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUUserSpec)

describe(@"LUUser", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUUser class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  __block LUUser *user;

  beforeEach(^{
    user = [[LUUser alloc] init];
  });

  // Property Getters

  describe(@"birthday", ^{
    it(@"returns bornAt as an NSDate", ^{
      NSDate *date = [NSDate date];
      NSString *dateString = [date iso8601DateTimeString];
      [user setValue:dateString forKey:@"bornAt"];

      [[theValue([[user birthday] timeIntervalSince1970]) should] equal:[date timeIntervalSince1970] withDelta:1.0];
    });
  });

  describe(@"isFemale", ^{
    context(@"when the gender is 'female'", ^{
      beforeEach(^{
        [user setValue:@"female" forKey:@"gender"];
      });

      it(@"is YES", ^{
        [[theValue([user isFemale]) should] beYes];
      });
    });

    context(@"when the gender is not 'female'", ^{
      beforeEach(^{
        [user setValue:@"male" forKey:@"gender"];
      });

      it(@"is NO", ^{
        [[theValue([user isFemale]) should] beNo];
      });
    });
  });

  describe(@"isMale", ^{
    context(@"when the gender is 'male'", ^{
      beforeEach(^{
        [user setValue:@"male" forKey:@"gender"];
      });

      it(@"is YES", ^{
        [[theValue([user isMale]) should] beYes];
      });
    });

    context(@"when the gender is not 'male'", ^{
      beforeEach(^{
        [user setValue:@"female" forKey:@"gender"];
      });

      it(@"is NO", ^{
        [[theValue([user isMale]) should] beNo];
      });
    });
  });

  describe(@"termsAcceptedTime", ^{
    it(@"returns termsAcceptedAt as an NSDate", ^{
      NSDate *date = [NSDate date];
      NSString *dateString = [date iso8601DateTimeString];
      [user setValue:dateString forKey:@"termsAcceptedAt"];

      [[theValue([[user termsAcceptedTime] timeIntervalSince1970]) should] equal:[date timeIntervalSince1970] withDelta:1.0];
    });
  });

  // Property Setters

  describe(@"setBirthday:", ^{
    it(@"sets bornAt to the ISO-8601 string of the date", ^{
      NSDate *date = [NSDate date];
      user.birthday = date;

      NSString *dateString = [date iso8601DateTimeString];
      [[[user valueForKey:@"bornAt"] should] equal:dateString];
    });
  });

  describe(@"setIsFemale:", ^{
    it(@"sets the gender to 'female'", ^{
      user.isFemale = YES;

      [[[user valueForKey:@"gender"] should] equal:@"female"];
    });
  });

  describe(@"setIsMale:", ^{
    it(@"sets the gender to 'male'", ^{
      user.isMale = YES;

      [[[user valueForKey:@"gender"] should] equal:@"male"];
    });
  });

  describe(@"setTermsAcceptedTime:", ^{
    it(@"sets termsAcceptedAt to the ISO-8601 string of the date", ^{
      NSDate *date = [NSDate date];
      user.termsAcceptedTime = date;

      NSString *dateString = [date iso8601DateTimeString];
      [[[user valueForKey:@"termsAcceptedAt"] should] equal:dateString];
    });
  });

  // Public Methods

  describe(@"hasValidQRCode", ^{
    context(@"when the user is payment eligible and has non-blank QR code data", ^{
      beforeEach(^{
        user.paymentEligible = YES;
        user.qrCode = [[LUQRCode alloc] init];
        user.qrCode.data = @"abc-123";
      });

      it(@"is YES", ^{
        [[theValue([user hasValidQRCode]) should] beYes];
      });
    });

    context(@"when the user has non-blank QR code data but is not payment eligible", ^{
      beforeEach(^{
        user.paymentEligible = NO;
        user.qrCode = [[LUQRCode alloc] init];
        user.qrCode.data = @"abc-123";
      });

      it(@"is NO", ^{
        [[theValue([user hasValidQRCode]) should] beNo];
      });
    });

    context(@"when the user is payment eligible but has no QR code", ^{
      beforeEach(^{
        user.paymentEligible = YES;
        user.qrCode = nil;
      });

      it(@"is NO", ^{
        [[theValue([user hasValidQRCode]) should] beNo];
      });
    });

    context(@"when the user is payment eligible but has blank QR code data", ^{
      beforeEach(^{
        user.paymentEligible = YES;
        user.qrCode = [[LUQRCode alloc] init];
        user.qrCode.data = @"";
      });

      it(@"is NO", ^{
        [[theValue([user hasValidQRCode]) should] beNo];
      });
    });
  });

  describe(@"homeAddress", ^{
    context(@"when the user has no addresses", ^{
      beforeEach(^{
        user.userAddresses = nil;
      });

      it(@"is nil", ^{
        [[user homeAddress] shouldBeNil];
      });
    });

    context(@"when the user has no home addresses", ^{
      beforeEach(^{
        LUUserAddress *workAddress = [[LUUserAddress alloc] init];
        workAddress.addressType = @"work";
        user.userAddresses = @[workAddress];
      });

      it(@"is nil", ^{
        [[user homeAddress] shouldBeNil];
      });
    });

    context(@"when the user has a home address", ^{
      __block LUUserAddress *homeAddress;

      beforeEach(^{
        LUUserAddress *workAddress = [[LUUserAddress alloc] init];
        workAddress.addressType = @"work";
        homeAddress = [[LUUserAddress alloc] init];
        homeAddress.addressType = @"home";
        user.userAddresses = @[workAddress, homeAddress];
      });

      it(@"is the home address", ^{
        [[[user homeAddress] should] equal:homeAddress];
      });
    });

    context(@"when the user has multiple home addresses", ^{
      __block LUUserAddress *homeAddress1;

      beforeEach(^{
        LUUserAddress *workAddress = [[LUUserAddress alloc] init];
        workAddress.addressType = @"work";
        homeAddress1 = [[LUUserAddress alloc] init];
        homeAddress1.addressType = @"home";
        LUUserAddress *homeAddress2 = [[LUUserAddress alloc] init];
        homeAddress2.addressType = @"home";
        user.userAddresses = @[workAddress, homeAddress1, homeAddress2];
      });

      it(@"is the first home address", ^{
        [[[user homeAddress] should] equal:homeAddress1];
      });
    });
  });
});

SPEC_END
