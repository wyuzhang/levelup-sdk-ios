// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULocationCreditJSONFactory.h"
#import "LUMonetaryValue.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationCreditJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  return [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"total_amount"]];
}

- (NSString *)rootKey {
  return @"credit";
}

@end
