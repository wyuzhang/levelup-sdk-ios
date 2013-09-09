// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValue.h"
#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUMonetaryValueJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *amount = [attributes lu_numberForKey:@"amount"];
  NSString *currencyCode = [attributes lu_stringForKey:@"currency_code"];
  NSString *currencySymbol = [attributes lu_stringForKey:@"currency_symbol"];
  NSString *formattedAmount = [attributes lu_stringForKey:@"formatted_amount"];

  return [[LUMonetaryValue alloc] initWithAmount:amount currencyCode:currencyCode
                                  currencySymbol:currencySymbol formattedAmount:formattedAmount];
}

@end
