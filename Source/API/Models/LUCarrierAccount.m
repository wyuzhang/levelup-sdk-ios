/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUCarrierAccount.h"
#import "LUCarrierAccountStateTransformer.h"

@implementation LUCarrierAccount

+ (void)load {
  [NSValueTransformer setValueTransformer:[[LUCarrierAccountStateTransformer alloc] init] forName:LUCarrierAccountStateTransformerName];
}

+ (LUCarrierAccountState)carrierAccountStateForStateString:(NSString *)stateString {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUCarrierAccountStateTransformerName];
  return [[transformer reverseTransformedValue:stateString] integerValue];
}

+ (NSString *)stringForCarrierAccountState:(LUCarrierAccountState)state {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUCarrierAccountStateTransformerName];
  return [transformer transformedValue:@(state)];
}

- (id)initWithCarrierAccountID:(NSNumber *)carrierAccountID
                   carrierName:(NSString *)carrierName
                  creditCardID:(NSNumber *)creditCardID
                         EVURL:(NSURL *)EVURL
            mobileDeviceNumber:(NSString *)mobileDeviceNumber
                         state:(LUCarrierAccountState)state {
  self = [super init];
  if (!self) return nil;

  _carrierAccountID = carrierAccountID;
  _carrierName = carrierName;
  _creditCardID = creditCardID;
  _EVURL = EVURL;
  _mobileDeviceNumber = mobileDeviceNumber;
  _state = state;

  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCarrierAccount [address=%p, carrierAccountID=%@, carrierName=%@, creditCardID=%@, EVURL=%@, mobileDeviceNumber=%@, state=%@]",
          self, self.carrierAccountID, self.carrierName, self.creditCardID, self.EVURL, self.mobileDeviceNumber,
          [LUCarrierAccount stringForCarrierAccountState:self.state]];
}

@end
