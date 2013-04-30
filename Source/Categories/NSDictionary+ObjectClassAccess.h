@interface NSDictionary (ObjectClassAccess)

- (BOOL)boolForKey:(id)aKey;
- (NSDate *)dateForKey:(id)aKey;
- (NSDictionary *)dictionaryForKey:(id)aKey;
- (float)floatForKey:(id)aKey;
- (NSNumber *)numberForKey:(id)aKey;
- (NSString *)stringForKey:(id)aKey;
- (NSURL *)URLForKey:(id)aKey;

@end
