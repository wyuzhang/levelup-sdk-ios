#import "LUAPIModel.h"

/**
 A category to which a cause can belong.
 */
@interface LUCauseCategory : LUAPIModel

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy, readonly) NSNumber *causeCategoryID;

/**
 The name of the category.
 */
@property (nonatomic, copy, readonly) NSString *name;

- (id)initWithCauseCategoryID:(NSNumber *)causeCategoryID name:(NSString *)name;

@end
