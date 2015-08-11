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

#import "LUUserAddressTypeTransformer.h"

SPEC_BEGIN(LUUserAddressTypeTransformerSpec)

describe(@"LUUserAddressTypeTransformer", ^{
  __block NSValueTransformer *transformer;

  beforeAll(^{
    [NSValueTransformer setValueTransformer:[[LUUserAddressTypeTransformer alloc] init] forName:LUUserAddressTypeTransformerName];
    transformer = [NSValueTransformer valueTransformerForName:LUUserAddressTypeTransformerName];
  });

  describe(@"transformValue:", ^{
    it(@"returns the proper user address type string", ^{
      NSString *userAddressType = [transformer transformedValue:@(LUUserAddressTypeBilling)];
      [[userAddressType should] equal:@"billing"];
    });
  });

  describe(@"reverseTransformedValue:", ^{
    it(@"returns an NSNumber representation of the proper enumerated value for the user address type string", ^{
      NSNumber *userAddressType = [transformer reverseTransformedValue:@"Billing"];
      [[userAddressType should] equal:@(LUUserAddressTypeBilling)];
    });

    it(@"is case insensitive", ^{
      NSNumber *userAddressType = [transformer reverseTransformedValue:@"billing"];
      [[userAddressType should] equal:@(LUUserAddressTypeBilling)];
    });
  });
});

SPEC_END
