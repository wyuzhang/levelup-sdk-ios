#import "LUCachedLocation.h"
#import "LUCachedLocationSearch.h"
#import "LUCoreDataStack.h"
#import "NSArray+LUAdditions.h"

@interface LUCachedLocationSearch ()

@property (nonatomic, copy) NSNumber *categoryID;
@property (nonatomic, strong) CLLocation *center;
@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation LUCachedLocationSearch

- (id)initWithCenter:(CLLocation *)center limit:(NSUInteger)limit categoryID:(NSNumber *)categoryID {
  self = [super init];
  if (!self) return nil;

  _categoryID = categoryID;
  _center = center;
  _limit = limit;
  _managedObjectContext = [LUCoreDataStack managedObjectContext];

  return self;
}

- (NSArray *)executeSearch:(NSError **)error {
  NSMutableArray *locations = [[self nearbyLocations:error] mutableCopy];
  if (!locations) return nil;

  [locations sortUsingComparator:^(LUCachedLocation *obj1, LUCachedLocation *obj2) {
    return [obj1 compare:obj2 relativeToLocation:self.center];
  }];

  if (locations.count > self.limit) {
    [locations setArray:[locations subarrayWithRange:NSMakeRange(0, self.limit)]];
  }

  return [locations mappedArrayWithBlock:^(LUCachedLocation *cachedLocation) {
    return [cachedLocation toLocation];
  }];
}

#pragma mark - Private Methods (Nearby Locations)

- (NSArray *)nearbyLocations:(NSError **)error {
  NSFetchRequest *fetchRequestForAllLocations = [self fetchRequestForAllLocations];
  NSUInteger totalNumberOfLocations = [self.managedObjectContext countForFetchRequest:fetchRequestForAllLocations
                                                                                error:error];

  if (totalNumberOfLocations == 0) {
    return [NSArray array];
  } else if (totalNumberOfLocations < self.limit) {
    return [self.managedObjectContext executeFetchRequest:fetchRequestForAllLocations error:error];
  }

  static double radiusSanityCheck = 360.0;

  double radius = 0.01;
  NSUInteger count = 0;
  NSFetchRequest *fetchRequest;

  do {
    fetchRequest = [self fetchRequestForLocationsWithinRadius:radius];
    count = [self.managedObjectContext countForFetchRequest:fetchRequest error:error];

    radius *= 2.0;
  } while (count < self.limit && radius < radiusSanityCheck);

  return [self.managedObjectContext executeFetchRequest:fetchRequest error:error];
}

#pragma mark - Private Methods (Fetch Requests)

- (NSFetchRequest *)fetchRequestForAllLocations {
  return [self fetchRequestForLocationsWithinRadius:-1];
}

- (NSFetchRequest *)fetchRequestForLocationsWithinRadius:(double)radius {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LUCachedLocation entityName]];
  fetchRequest.fetchLimit = self.limit;

  NSMutableArray *subpredicates = [NSMutableArray arrayWithObject:[self predicateForShown]];

  if (self.categoryID) {
    [subpredicates addObject:[self predicateForCategoryID]];
  }

  if (radius > 0) {
    [subpredicates addObject:[self predicateForRadius:radius]];
  }

  fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];

  return fetchRequest;
}

#pragma mark - Private Methods (Subpredicates)

- (NSPredicate *)predicateForShown {
  return [NSPredicate predicateWithFormat:@"shown = YES"];
}

- (NSPredicate *)predicateForCategoryID {
  return [NSPredicate predicateWithFormat:@"categoryIDs CONTAINS %@", [NSString stringWithFormat:@"%@|", self.categoryID]];
}

- (NSPredicate *)predicateForRadius:(double)radius {
  double minLatitude = self.center.coordinate.latitude - radius;
  double maxLatitude = self.center.coordinate.latitude + radius;

  if (minLatitude > maxLatitude) {
    double tmp = maxLatitude;
    maxLatitude = minLatitude;
    minLatitude = tmp;
  }

  double longitudeFudge = cos(self.center.coordinate.longitude * M_PI / 180) * radius;
  double minLongitude = self.center.coordinate.longitude - longitudeFudge;
  double maxLongitude = self.center.coordinate.longitude + longitudeFudge;

  if (minLongitude > maxLongitude) {
    double tmp = maxLongitude;
    maxLongitude = minLongitude;
    minLongitude = tmp;
  }

  return [NSPredicate predicateWithFormat:@"(latitude BETWEEN {%@, %@}) AND (longitude BETWEEN {%@, %@})", @(minLatitude), @(maxLatitude), @(minLongitude), @(maxLongitude)];
}

@end
