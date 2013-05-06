/**
 Contains an array of location summaries along with the URL for the next page of results.
 */
@interface LULocationSummaries : NSObject

@property (nonatomic, strong, readonly) NSArray *locations;
@property (nonatomic, copy, readonly) NSURL *nextPageURL;

- (id)initWithLocations:(NSArray *)locations nextPageURL:(NSURL *)nextPageURL;

@end
