// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

/**
 A category to which a merchant can belong.
 */
@interface LUCategory : LUAPIModel

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy, readonly) NSNumber *categoryID;

/**
 The name of the category.
 */
@property (nonatomic, copy, readonly) NSString *name;

- (id)initWithCategoryID:(NSNumber *)categoryID name:(NSString *)name;

@end
