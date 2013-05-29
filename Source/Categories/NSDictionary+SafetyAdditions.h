@interface NSDictionary (SafetyAdditions)

- (id)safeValueForKey:(NSString *)key;

@end

@interface NSMutableDictionary (SafetyAdditions)

- (void)setSafeValue:(id)value forKey:(NSString *)key;

@end
