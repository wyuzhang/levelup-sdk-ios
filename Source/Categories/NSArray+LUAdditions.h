// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface NSArray (LUAdditions)

- (id)lu_firstObject;
- (NSArray *)lu_mappedArrayWithBlock:(id (^)(id obj))block;

@end
