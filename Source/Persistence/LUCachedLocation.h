// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LULocation;

@interface LUCachedLocation : NSManagedObject

@property (nonatomic, copy) NSString *categoryIDs;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *locationID;
@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, copy) NSNumber *merchantID;
@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, copy) NSNumber *shown;
@property (nonatomic, copy) NSDate *updatedAtDate;

+ (NSString *)entityName;
+ (LUCachedLocation *)findOrBuildWithLocationID:(NSNumber *)locationID
                           managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (NSComparisonResult)compare:(LUCachedLocation *)otherLocation relativeToLocation:(CLLocation *)center;
- (LULocation *)toLocation;
- (void)updatePropertiesFromLocation:(LULocation *)location;

@end
