// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

/**
 `LUCachedLocationSearch` is used to query a locally cached database of information on all LevelUp
 locations.

 This database is a local SQLite file managed via Core Data. The SDK will contain an initial seed of
 the database, and then the `LULocationCacheUpdater` class can be used to keep the location cache
 up-to-date.

 To use `LUCachedLocationSearch`, create an instance along with a `CLLocation` around which to order
 the locations, a maximum number of results, and an optional category ID upon which to filter.
 */
@interface LUCachedLocationSearch : NSObject

/**
 Creates an instance of `LUCachedLocationSearch` with the specified search criteria.

 @param center The center point of the search. Searches with progressively higher radii will be
 performed until at least `limit` results are found.
 @param limit The desired number of results.
 @param categoryID An optional category ID to filter on. May be `nil`.
 */
- (id)initWithCenter:(CLLocation *)center limit:(NSUInteger)limit categoryID:(NSNumber *)categoryID;

/**
 Performs the search.

 @param error If an error occurs during the search, `error` will be updated to point to an instance
 of `NSError` with error info.
 */
- (NSArray *)executeSearch:(NSError **)error;

@end
