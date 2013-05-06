extern NSString * const LUPersistedObjectsDefaultSqliteName;
extern NSString * const LUPersistedObjectsSqliteName;

@interface LUCoreDataStack : NSObject

+ (NSManagedObjectContext *)managedObjectContext;

@end
