// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface LUCoreDataStack : NSObject

+ (NSManagedObjectContext *)managedObjectContext;

+ (NSString *)metadataStringForKey:(NSString *)key;
+ (void)setMetadataString:(NSString *)string forKey:(NSString *)key;

@end
