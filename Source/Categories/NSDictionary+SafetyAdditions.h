// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface NSDictionary (SafetyAdditions)

- (id)lu_safeValueForKey:(NSString *)key;

@end

@interface NSMutableDictionary (SafetyAdditions)

- (void)lu_setSafeValue:(id)value forKey:(NSString *)key;

@end
