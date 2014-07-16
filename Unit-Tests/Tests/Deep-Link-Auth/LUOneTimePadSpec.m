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

#import "LUKeychainAccess.h"
#import "LUOneTimePad.h"
#import "NSData+LUAdditions.h"

SPEC_BEGIN(LUOneTimePadSpec)

describe(@"LUOneTimePad", ^{
  LUOneTimePad *pad = [LUOneTimePad fixture];
  NSString *testDataBase64 = [LUOneTimePad fixtureDataBase64];

  beforeEach(^{
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[LUKeychainAccess nullMock]];
  });

  // Factory Methods

  describe(@"loadOneTimePad", ^{
    context(@"when a one-time pad is stored in the Keychain", ^{
      beforeEach(^{
        [[LUKeychainAccess standardKeychainAccess] stub:@selector(dataForKey:) andReturn:pad.data];
      });

      it(@"loads the last saved one-time pad from the Keychain", ^{
        LUOneTimePad *loadedPad = [LUOneTimePad loadOneTimePad];

        [[loadedPad should] equal:pad];
      });
    });

    context(@"when a one-time pad is not stored in the Keychain", ^{
      beforeEach(^{
        [[LUKeychainAccess standardKeychainAccess] stub:@selector(dataForKey:) andReturn:nil];
      });

      it(@"returns nil", ^{
        [[[LUOneTimePad loadOneTimePad] should] beNil];
      });
    });
  });

  describe(@"oneTimePadWithBase64EncodedString:", ^{
    it(@"uses the data encoded in the string", ^{
      LUOneTimePad *newPad = [LUOneTimePad oneTimePadWithBase64EncodedString:testDataBase64];

      [[newPad should] equal:pad];
    });
  });

  describe(@"saveNewOneTimePad", ^{
    NSData *testData = [LUOneTimePad fixtureData];

    beforeEach(^{
      [NSData stub:@selector(lu_randomDataOfLength:) andReturn:testData];
    });

    it(@"generates a new one-time pad of random bytes", ^{
      LUOneTimePad *pad = [LUOneTimePad saveNewOneTimePad];

      [[pad.data should] equal:testData];
    });

    it(@"stores the pad in the Keychain", ^{
      LUOneTimePad *pad = [LUOneTimePad oneTimePadWithBase64EncodedString:testDataBase64];

      [[[LUKeychainAccess standardKeychainAccess] should] receive:@selector(setData:forKey:)
                                                    withArguments:pad.data, any()];

      [[[LUOneTimePad saveNewOneTimePad] should] equal:pad];
    });
  });

  // Public Methods

  describe(@"base64Encoding", ^{
    it(@"returns the underlying data encoded in Base64", ^{
      [[[pad base64Encoding] should] equal:testDataBase64];
    });
  });

  describe(@"length", ^{
    it(@"is the length of the underlying data", ^{
      [[theValue([pad length]) should] equal:theValue([pad.data length])];
    });
  });

  // Encoding/decoding Methods

  describe(@"decodeString:", ^{
    LUOneTimePad *pad = [LUOneTimePad fixture];
    NSString *string = @"a test string";

    it(@"decodes a previously encoded string", ^{
      NSString *encodedString = [pad encodeString:string];
      NSString *decodedString = [pad decodeString:encodedString];

      [[decodedString should] equal:string];
    });
  });

  describe(@"encodeString:", ^{
    LUOneTimePad *pad = [LUOneTimePad fixture];
    NSString *string = @"a test string";

    it(@"encodes a string into a Base64 encoded string", ^{
      NSString *encodedString = [pad encodeString:string];

      NSString *reBase64Encoded = [[NSData lu_dataWithBase64EncodedString:encodedString] base64Encoding];
      [[reBase64Encoded should] equal:encodedString];
    });
  });

  // NSObject Methods

  describe(@"isEqual:", ^{
    context(@"a pad with the same data", ^{
      LUOneTimePad *other = [LUOneTimePad oneTimePadWithBase64EncodedString:testDataBase64];

      it(@"should be equal", ^{
        [[pad should] equal:other];
      });
    });

    context(@"a pad with different data", ^{
      LUOneTimePad *other = [LUOneTimePad oneTimePadWithBase64EncodedString:[testDataBase64 substringFromIndex:1]];

      it(@"should not be equal", ^{
        [[pad shouldNot] equal:other];
      });
    });
  });
});

SPEC_END
