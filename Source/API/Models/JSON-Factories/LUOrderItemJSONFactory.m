// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValue.h"
#import "LUOrderItem.h"
#import "LUOrderItemJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderItemJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *category = [attributes lu_stringForKey:@"category"];
  LUMonetaryValue *chargedPrice = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"charged_price_amount"]];
  NSString *itemDescription = [attributes lu_stringForKey:@"description"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  NSUInteger quantity = [[attributes lu_numberForKey:@"quantity"] unsignedIntegerValue];
  NSString *SKU = [attributes lu_stringForKey:@"sku"];
  LUMonetaryValue *standardPrice = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"standard_price_amount"]];
  NSString *UPC = [attributes lu_stringForKey:@"upc"];

  return [[LUOrderItem alloc] initWithCategory:category chargedPrice:chargedPrice
                               itemDescription:itemDescription name:name quantity:quantity SKU:SKU
                                 standardPrice:standardPrice UPC:UPC];
}

- (NSString *)rootKey {
  return @"item";
}

@end
