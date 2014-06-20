// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "LUOrderItemJSONFactory.h"
#import "LUOrderJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderJSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *balance = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"balance_amount"]];
  NSDate *bundleClosedDate = [attributes lu_dateForKey:@"bundle_closed_at"];
  NSString *bundleDescriptor = [attributes lu_stringForKey:@"bundle_descriptor"];
  LUMonetaryValue *contribution = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"contribution_amount"]];
  NSString *contributionTargetName = [attributes lu_stringForKey:@"contribution_target_name"];
  NSDate *createdDate = [attributes lu_dateForKey:@"created_at"];
  LUMonetaryValue *credit = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"credit_applied_amount"]];
  LUMonetaryValue *earn = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"credit_earned_amount"]];

  NSArray *items;
  NSArray *itemsJSON = [attributes lu_arrayForKey:@"items"];
  if (itemsJSON) {
    items = [[LUOrderItemJSONFactory factory] fromArray:itemsJSON];
  }

  NSString *locationExtendedAddress = [attributes lu_stringForKey:@"location_extended_address"];
  NSNumber *locationID = [attributes lu_numberForKey:@"location_id"];
  NSString *locationLocality = [attributes lu_stringForKey:@"location_locality"];
  NSString *locationPostalCode = [attributes lu_stringForKey:@"location_postal_code"];
  NSString *locationRegion = [attributes lu_stringForKey:@"location_region"];
  NSString *locationStreetAddress = [attributes lu_stringForKey:@"location_street_address"];
  NSNumber *merchantID = [attributes lu_numberForKey:@"merchant_id"];
  NSString *merchantName = [attributes lu_stringForKey:@"merchant_name"];
  NSDate *refundedDate = [attributes lu_dateForKey:@"refunded_at"];
  LUMonetaryValue *spend = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"spend_amount"]];
  LUMonetaryValue *tip = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"tip_amount"]];
  LUMonetaryValue *total = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"total_amount"]];
  NSDate *transactedDate = [attributes lu_dateForKey:@"transacted_at"];
  NSString *UUID = [attributes lu_stringForKey:@"uuid"];

  return [[LUOrder alloc] initWithBalance:balance bundleClosedDate:bundleClosedDate bundleDescriptor:bundleDescriptor
                             contribution:contribution contributionTargetName:contributionTargetName
                              createdDate:createdDate credit:credit earn:earn items:items
                  locationExtendedAddress:locationExtendedAddress locationID:locationID
                         locationLocality:locationLocality locationPostalCode:locationPostalCode
                           locationRegion:locationRegion locationStreetAddress:locationStreetAddress
                               merchantID:merchantID merchantName:merchantName refundedDate:refundedDate spend:spend
                                      tip:tip total:total transactedDate:transactedDate UUID:UUID];
}

- (NSString *)rootKey {
  return @"order";
}

@end
