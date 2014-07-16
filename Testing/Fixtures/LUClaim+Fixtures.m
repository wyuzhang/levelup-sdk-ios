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

#import "LUClaim+Fixtures.h"
#import "LUMonetaryValue.h"

@implementation LUClaim (Fixtures)

+ (LUClaim *)fixture {
  return [self fixtureForCampaignWithCode:@"code"];
}

+ (LUClaim *)fixtureForCampaignWithCode:(NSString *)code {
  return [[LUClaim alloc] initWithCampaignID:@2
                                     claimID:@1
                                        code:code
                                       value:[LUMonetaryValue monetaryValueWithUSD:@5]
                              valueRemaining:[LUMonetaryValue monetaryValueWithUSD:@2]];
}

@end
