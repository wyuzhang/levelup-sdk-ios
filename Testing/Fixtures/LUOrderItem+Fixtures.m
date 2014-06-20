// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValue.h"
#import "LUOrderItem+Fixtures.h"

@implementation LUOrderItem (Fixtures)

+ (LUOrderItem *)fixture {
  return [[LUOrderItem alloc] initWithCategory:@"Fruit"
                                  chargedPrice:[LUMonetaryValue monetaryValueWithUSD:@5]
                               itemDescription:@"An apple"
                                          name:@"Apple"
                                      quantity:1
                                           SKU:@"ABC123"
                                 standardPrice:[LUMonetaryValue monetaryValueWithUSD:@5]
                                           UPC:@"123456789999"];
}

@end
