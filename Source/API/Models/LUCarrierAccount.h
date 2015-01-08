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

#import "LUAPIModel.h"

typedef NS_ENUM(NSInteger, LUCarrierAccountState) {
  LUCarrierAccountStateIdentifying,
  LUCarrierAccountStateIdentified,
  LUCarrierAccountStateCheckingEligibility,
  LUCarrierAccountStateActive,
  LUCarrierAccountStateInactive,
};

@interface LUCarrierAccount : LUAPIModel

@property (nonatomic, copy, readonly) NSNumber *carrierAccountID;
@property (nonatomic, copy, readonly) NSString *carrierName;
@property (nonatomic, copy, readonly) NSNumber *creditCardID;
@property (nonatomic, copy, readonly) NSURL *EVURL;
@property (nonatomic, copy, readonly) NSString *mobileDeviceNumber;
@property (nonatomic, assign, readonly) LUCarrierAccountState state;

+ (LUCarrierAccountState)carrierAccountStateForStateString:(NSString *)stateString;
+ (NSString *)stringForCarrierAccountState:(LUCarrierAccountState)state;

- (id)initWithCarrierAccountID:(NSNumber *)carrierAccountID
                   carrierName:(NSString *)carrierName
                  creditCardID:(NSNumber *)creditCardID
                         EVURL:(NSURL *)EVURL
            mobileDeviceNumber:(NSString *)mobileDeviceNumber
                         state:(LUCarrierAccountState)state;

@end
