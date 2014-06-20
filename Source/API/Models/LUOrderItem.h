// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

@class LUMonetaryValue;

/**
 An `LUOrderItem` represents a single item that was part of an order.
 */
@interface LUOrderItem : LUAPIModel

/**
 An optional category for this item.
 */
@property (nonatomic, copy, readonly) NSString *category;

/**
 The price for this item that was charged to the customer.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *chargedPrice;

/**
 An optional description of the item.
 */
@property (nonatomic, copy, readonly) NSString *itemDescription;

/**
 The name of the item.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 The quantity of the item that was purchased.
 */
@property (nonatomic, assign, readonly) NSUInteger quantity;

/**
 An optional SKU (Stock Keeping Unit) code for this item.
 */
@property (nonatomic, copy, readonly) NSString *SKU;

/**
 An optional standard price for the item.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *standardPrice;

/**
 An optional UPC (Universal Product Code) for this item.
 */
@property (nonatomic, copy, readonly) NSString *UPC;

- (id)initWithCategory:(NSString *)category chargedPrice:(LUMonetaryValue *)chargedPrice
       itemDescription:(NSString *)itemDescription name:(NSString *)name
              quantity:(NSUInteger)quantity SKU:(NSString *)SKU
         standardPrice:(LUMonetaryValue *)standardPrice UPC:(NSString *)UPC;

@end
