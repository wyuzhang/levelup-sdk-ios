@interface NSArray (LUAdditions)

- (id)lu_firstObject;
- (NSArray *)lu_mappedArrayWithBlock:(id (^)(id obj))block;

@end
