#import "LUAPIModel.h"

/**
 A category to which a merchant can belong.
 */
@interface LUCategory : LUAPIModel

/**
 The name of the category.
 */
@property (nonatomic, copy) NSString *name;

@end
