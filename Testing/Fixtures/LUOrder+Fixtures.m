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

#import "LUMonetaryValue.h"
#import "LUOrder+Fixtures.h"
#import "LUOrderItem+Fixtures.h"
#import "NSDate+StringFormats.h"

@implementation LUOrder (Fixtures)

+ (LUOrder *)fixture {
  return [[LUOrder alloc] initWithBalance:[LUMonetaryValue monetaryValueWithUSD:@5.46f]
                         bundleClosedDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                         bundleDescriptor:@"LevelUp"
                             contribution:[LUMonetaryValue monetaryValueWithUSD:@0.49f]
                   contributionTargetName:@"Test Cause"
                              createdDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                                   credit:[LUMonetaryValue monetaryValueWithUSD:@1.0f]
                                     earn:[LUMonetaryValue monetaryValueWithUSD:@2.0f]
                   identifierFromMerchant:nil
                                    items:nil
                  locationExtendedAddress:@"Apt E"
                               locationID:@1
                         locationLocality:@"Boston"
                             locationName:nil
                       locationPostalCode:@"01234"
                           locationRegion:@"MA"
                    locationStreetAddress:@"123 Main St."
                               merchantID:@2
                             merchantName:@"Test Merchant"
                             refundedDate:nil
                                    spend:[LUMonetaryValue monetaryValueWithUSD:@4.99f]
                                      tip:[LUMonetaryValue monetaryValueWithUSD:@0.98f]
                                    total:[LUMonetaryValue monetaryValueWithUSD:@4.48f]
                           transactedDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                                     UUID:@"97067bb0f250013007de3c075468379e"];
}

+ (LUOrder *)fixtureWithBundleOpen {
  LUOrder *order = [self fixture];
  [order setValue:nil forKey:@"bundleClosedDate"];
  return order;
}

+ (LUOrder *)fixtureWithContribution:(LUMonetaryValue *)contribution {
  LUOrder *order = [self fixture];
  [order setValue:contribution forKey:@"contribution"];
  [order setValue:@"Test Charity" forKey:@"contributionTargetName"];
  return order;
}

+ (LUOrder *)fixtureWithCredit:(LUMonetaryValue *)credit {
  LUOrder *order = [self fixture];
  [order setValue:credit forKey:@"credit"];
  return order;
}

+ (LUOrder *)fixtureWithEarn:(LUMonetaryValue *)earn {
  LUOrder *order = [self fixture];
  [order setValue:earn forKey:@"earn"];
  return order;
}

+ (LUOrder *)fixtureWithItems {
  LUOrder *order = [self fixture];
  [order setValue:@[[LUOrderItem fixture]] forKey:@"items"];
  return order;
}

+ (LUOrder *)fixtureWithLocationName:(NSString *)locationName {
  LUOrder *order = [self fixture];
  [order setValue:@"Test Location" forKey:@"locationName"];
  return order;
}

+ (LUOrder *)fixtureWithMultipleMissingAttributes {
  LUOrder *order = [self fixture];
  [order setValue:nil forKey:@"contribution"];
  [order setValue:[LUMonetaryValue monetaryValueWithUSD:@0.0] forKey:@"earn"];
  return order;
}

+ (LUOrder *)fixtureWithOnlySpend {
  LUOrder *order = [self fixture];
  [order setValue:nil forKey:@"credit"];
  [order setValue:nil forKey:@"contribution"];
  [order setValue:nil forKey:@"earn"];
  [order setValue:nil forKey:@"tip"];
  return order;
}

+ (LUOrder *)fixtureWithOnlySpendAndContribution {
  LUOrder *order = [self fixture];
  [order setValue:nil forKey:@"credit"];
  [order setValue:nil forKey:@"earn"];
  [order setValue:nil forKey:@"tip"];
  return order;
}

+ (LUOrder *)fixtureWithRefundedStatus {
  LUOrder *order = [self fixture];
  [order setValue:[NSDate date] forKey:@"refundedDate"];
  return order;
}

+ (LUOrder *)fixtureWithTip:(LUMonetaryValue *)tip {
  LUOrder *order = [self fixture];
  [order setValue:tip forKey:@"tip"];
  return order;
}

+ (LUOrder *)fixtureWithZeroBalance {
  LUOrder *order = [self fixture];
  [order setValue:[LUMonetaryValue monetaryValueWithUSD:@0.0] forKey:@"balance"];
  return order;
}

+ (LUOrder *)fixtureWithoutContribution {
  LUOrder *order = [self fixture];
  [order setValue:nil forKey:@"contribution"];
  [order setValue:nil forKey:@"contributionTargetName"];
  return order;
}

+ (LUOrder *)fixtureWithoutCreditApplied {
  LUOrder *order = [self fixture];
  [order setValue:nil forKey:@"credit"];
  return order;
}

+ (LUOrder *)fixtureWithoutCreditEarned {
  LUOrder *order = [self fixture];
  [order setValue:[LUMonetaryValue monetaryValueWithUSD:@0.0] forKey:@"earn"];
  return order;
}

+ (LUOrder *)fixtureWithoutTip {
  LUOrder *order = [self fixture];
  [order setValue:nil forKey:@"tip"];
  return order;
}

@end
