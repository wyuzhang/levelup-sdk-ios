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

#import "LUDeviceIdentifier.h"
#import "LUKeychainAccess.h"

SPEC_BEGIN(LUDeviceIdentifierSpec)

describe(@"LUDeviceIdentifier", ^{
  // Public Methods

  describe(@"deviceIdentifier", ^{
    beforeEach(^{
      [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[LUKeychainAccess nullMock]];
    });

    context(@"when a device identifier has not been stored", ^{
      beforeEach(^{
        [[LUKeychainAccess standardKeychainAccess] stub:@selector(stringForKey:) withArguments:DeviceIdentifierKey, nil];
      });

      it(@"returns a new UUID", ^{
        NSString *UUID1 = [LUDeviceIdentifier deviceIdentifier];
        NSString *UUID2 = [LUDeviceIdentifier deviceIdentifier];

        [[UUID1 shouldNot] equal:UUID2];
      });
    });

    context(@"when a device identifier has been previously stored", ^{
      NSString *UUID = @"c5d0d1fefaf12815bf60413f9f81c07c";

      beforeEach(^{
        [[LUKeychainAccess standardKeychainAccess] stub:@selector(stringForKey:) andReturn:UUID withArguments:DeviceIdentifierKey, nil];
      });

      it(@"returns the stored device identifier", ^{
        [[[LUDeviceIdentifier deviceIdentifier] should] equal:UUID];
      });
    });
  });
});

SPEC_END
