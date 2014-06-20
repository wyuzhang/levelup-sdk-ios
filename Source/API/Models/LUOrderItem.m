// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUOrderItem.h"

@implementation LUOrderItem

#pragma mark - Creation

- (id)initWithCategory:(NSString *)category chargedPrice:(LUMonetaryValue *)chargedPrice
       itemDescription:(NSString *)itemDescription name:(NSString *)name
              quantity:(NSUInteger)quantity SKU:(NSString *)SKU
         standardPrice:(LUMonetaryValue *)standardPrice UPC:(NSString *)UPC {
  self = [super init];
  if (!self) return nil;

  _category = category;
  _chargedPrice = chargedPrice;
  _itemDescription = itemDescription;
  _name = name;
  _quantity = quantity;
  _SKU = SKU;
  _standardPrice = standardPrice;
  _UPC = UPC;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUOrderItem [address=%p, category=%@, chargedPrice=%@, itemDescription=%@, name=%@, quantity=%@, SKU=%@, standardPrice=%@, UPC=%@]",
          self, self.category, self.chargedPrice, self.itemDescription, self.name, @(self.quantity),
          self.SKU, self.standardPrice, self.UPC];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderItem [address=%p, chargedPrice=%@, quantity=%@, SKU=%@]",
          self, self.chargedPrice, @(self.quantity), self.SKU];
}

@end
