// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface NSDictionary (ObjectClassAccess)

- (NSArray *)lu_arrayForKey:(id)aKey;
- (BOOL)lu_boolForKey:(id)aKey;
- (NSDate *)lu_dateForKey:(id)aKey;
- (NSDictionary *)lu_dictionaryForKey:(id)aKey;
- (float)lu_floatForKey:(id)aKey;
- (NSNumber *)lu_numberForKey:(id)aKey;
- (NSString *)lu_stringForKey:(id)aKey;
- (NSURL *)lu_URLForKey:(id)aKey;

@end
