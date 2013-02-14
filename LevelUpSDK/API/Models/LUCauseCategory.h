#import "LUAPIModel.h"

/**
 A category to which a cause can belong.
 */
@interface LUCauseCategory : LUAPIModel

/**
 The name of the category.
 */
@property (nonatomic, copy) NSString *name;

@end
