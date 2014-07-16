/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
