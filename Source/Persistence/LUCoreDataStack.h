extern NSString * const LUPersistedObjectsDefaultSqliteName;
extern NSString * const LUPersistedObjectsSqliteName;

@interface LUCoreDataStack : NSObject

+ (NSManagedObjectContext *)managedObjectContext;
+ (NSString *)metadataStringForKey:(NSString *)key;
+ (void)setMetadataString:(NSString *)string forKey:(NSString *)key;

@end
