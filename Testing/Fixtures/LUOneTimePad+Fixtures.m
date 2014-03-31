// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUOneTimePad+Fixtures.h"

@implementation LUOneTimePad (Fixtures)

+ (LUOneTimePad *)fixture {
  return [LUOneTimePad oneTimePadWithBase64EncodedString:[self fixtureDataBase64]];
}

+ (NSData *)fixtureData {
  const unsigned char bytes[] = { 0xA6, 0x0F, 0x7D, 0xB9, 0x5A, 0xEE, 0x64, 0xC0, 0x8E, 0xF5,
    0xDB, 0xE2, 0xD2, 0xBC, 0x00, 0xA1 };
  return [NSData dataWithBytes:bytes length:sizeof(bytes)];
}

+ (NSString *)fixtureDataBase64 {
  return @"pg99uVruZMCO9dvi0rwAoQ==";
}

@end
