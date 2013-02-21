#import "LUAPIModel.h"

/**
 A category to which a cause can belong.
 */
@interface LUCauseCategory : LUAPIModel

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy) NSNumber *causeCategoryID;

/**
 The name of the category.
 */
@property (nonatomic, copy) NSString *name;

@end
