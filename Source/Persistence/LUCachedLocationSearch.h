/**
 `LUCachedLocationSearch` is used to query a locally cached database of information on all LevelUp locations.

 This database is a local SQLite file managed via Core Data. The SDK will contain an initial seed of the database, and
 then the `LULocationCacheUpdater` class can be used to keep the location cache up-to-date.

 To use `LUCachedLocationSearch`, create an instance along with a `CLLocation` around which to order the locations, a 
 maximum number of results, and an optional category ID upon which to filter.
 */

@interface LUCachedLocationSearch : NSObject

/**
 Creates an instance of `LUCachedLocationSearch` with the specified search criteria.
 */
- (id)initWithCenter:(CLLocation *)center limit:(NSUInteger)limit categoryID:(NSNumber *)categoryID;

/**
 Performs the search. If an error occurs during the search, `nil` will be returned, and the `error` parameter will be
 updated to point to an instance of `NSError` with error info.
 */
- (NSArray *)executeSearch:(NSError **)error;

@end
