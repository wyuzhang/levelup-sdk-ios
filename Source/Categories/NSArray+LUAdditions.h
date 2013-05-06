@interface NSArray (LUAdditions)

- (id)firstObject;
- (NSArray *)mappedArrayWithBlock:(id (^)(id obj))block;

@end
