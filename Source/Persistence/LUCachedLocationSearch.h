@interface LUCachedLocationSearch : NSObject

- (id)initWithCenter:(CLLocation *)center limit:(NSUInteger)limit categoryID:(NSNumber *)categoryID;
- (NSArray *)executeSearch:(NSError **)error;

@end
