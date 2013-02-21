#import "LUAPIModel.h"

/**
 A category to which a merchant can belong.
 */
@interface LUCategory : LUAPIModel

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy) NSNumber *categoryID;

/**
 The name of the category.
 */
@property (nonatomic, copy) NSString *name;

@end
