// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "NSData+LUAdditions.h"

SPEC_BEGIN(NSDataLUAdditionsSpec)

describe(@"NSData", ^{
  const unsigned char bytes[] = { 0xA6, 0x0F, 0x7D, 0xB9, 0x5A, 0xEE, 0x64, 0xC0, 0x8E, 0xF5,
    0xDB, 0xE2, 0xD2, 0xBC, 0x00, 0xA1 };
  NSData *testData = [NSData dataWithBytes:bytes length:sizeof(bytes)];
  NSString *testDataBase64 = @"pg99uVruZMCO9dvi0rwAoQ==";

  describe(@"lu_dataWithBase64EncodedString", ^{
    it(@"decodes a Base64 string and returns the encoded data", ^{
      [[[NSData lu_dataWithBase64EncodedString:testDataBase64] should] equal:testData];
    });
  });

  describe(@"lu_randomDataOfLength:", ^{
    it(@"returns an NSData with random bytes of the given length", ^{
      int8_t stubbedRandomBytes[] = {10, 20};

      [NSData stub:@selector(lu_randomByte)
         andReturn:theValue(stubbedRandomBytes[0])
             times:@1
   afterThatReturn:theValue(stubbedRandomBytes[1])];

      NSUInteger length = sizeof(stubbedRandomBytes);
      NSData *expected = [NSData dataWithBytes:stubbedRandomBytes length:length];
      [[[NSData lu_randomDataOfLength:length] should] equal:expected];
    });
  });

  describe(@"lu_base64Encoding", ^{
    it(@"returns the data encoded in Base64", ^{
      [[[testData lu_base64Encoding] should] equal:testDataBase64];
    });
  });

  describe(@"lu_hexString", ^{
    it(@"returns the data as a hex string", ^{
      NSString *expected = @"A60F7DB95AEE64C08EF5DBE2D2BC00A1";

      [[[testData lu_hexString] should] equal:expected];
    });
  });

  describe(@"lu_XORDataWithSecret:", ^{
    int8_t secretBytes[] = {10, 50, 100, 200};
    NSData *secret = [NSData dataWithBytes:secretBytes length:sizeof(secretBytes)];

    context(@"when the secret is larger than the data", ^{
      it(@"XORs the entire length of the data", ^{
        int8_t dataBytes[] = {1, 2, 3};
        NSData *data = [NSData dataWithBytes:dataBytes length:sizeof(dataBytes)];

        int8_t expectedBytes[] = {11, 48, 103};
        NSData *expected = [NSData dataWithBytes:expectedBytes length:sizeof(expectedBytes)];
        [[[data lu_XORDataWithSecret:secret] should] equal:expected];
      });
    });

    context(@"when the secret is shorter than the data", ^{
      it(@"XORs bytes up to the length of the secret and doesn't change the rest", ^{
        int8_t dataBytes[] = {1, 2, 3, 4, 5};
        NSData *data = [NSData dataWithBytes:dataBytes length:sizeof(dataBytes)];

        int8_t expectedBytes[] = {11, 48, 103, 204, 5};
        NSData *expected = [NSData dataWithBytes:expectedBytes length:sizeof(expectedBytes)];
        [[[data lu_XORDataWithSecret:secret] should] equal:expected];
      });
    });
  });
});

SPEC_END
