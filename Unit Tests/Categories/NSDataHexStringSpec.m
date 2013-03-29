#import "NSData+HexString.h"

SPEC_BEGIN(NSDataHexStringSpec)

describe(@"NSData", ^{
  describe(@"hexString", ^{
    const unsigned char bytes[16] = { 0xA6, 0x0F, 0x7D, 0xB9, 0x5A, 0xEE, 0x64, 0xC0, 0x8E, 0xF5, 0xDB, 0xE2, 0xD2, 0xBC, 0x00, 0xA1 };
    NSData *data = [NSData dataWithBytes:bytes length:16];

    it(@"returns the data as a hex string", ^{
      NSString *expected = @"A60F7DB95AEE64C08EF5DBE2D2BC00A1";

      [[[data hexString] should] equal:expected];
    });
  });
});

SPEC_END
