#import "LUQRCode.h"

SPEC_BEGIN(LUQRCodeSpec)

describe(@"LUQRCode", ^{
  LUQRCode *qrCodeA = [[LUQRCode alloc] init];
  LUQRCode *qrCodeB = [[LUQRCode alloc] init];
  NSString *codeA = @"12345";
  NSString *codeB = @"54321";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      qrCodeA.data = codeA;
      qrCodeB.data = codeA;

      [[theValue([qrCodeA isEqual:qrCodeB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      qrCodeA.data = codeA;
      qrCodeB.data = codeA;

      [[theValue([qrCodeB isEqual:qrCodeA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      qrCodeA.data = codeA;
      qrCodeB.data = codeA;

      [[theValue([qrCodeA isEqual:qrCodeB]) should] equal:theValue(YES)];

      qrCodeB.data = codeB;

      [[theValue([qrCodeA isEqual:qrCodeB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      qrCodeB.data = codeA;
      qrCodeB.data = codeB;

      [[theValue([qrCodeA isEqual:qrCodeB]) should] equal:theValue(NO)];

      qrCodeB.data = codeA;

      [[theValue([qrCodeA isEqual:qrCodeB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      qrCodeA.data = codeA;
      qrCodeB.data = codeA;

      [[theValue([qrCodeA hash]) should] equal:theValue([qrCodeB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      qrCodeA.data = codeA;
      qrCodeB.data = codeA;

      [[theValue([qrCodeA hash]) should] equal:theValue([qrCodeB hash])];

      qrCodeB.data = codeB;

      [[theValue([qrCodeA hash]) shouldNot] equal:theValue([qrCodeB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      qrCodeA.data = codeA;
      qrCodeB.data = codeB;

      [[theValue([qrCodeA hash]) shouldNot] equal:theValue([qrCodeB hash])];

      qrCodeB.data = codeA;

      [[theValue([qrCodeA hash]) should] equal:theValue([qrCodeB hash])];
    });
  });
});

SPEC_END
