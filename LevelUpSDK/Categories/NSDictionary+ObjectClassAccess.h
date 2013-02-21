@class LUMonetaryValue;

@interface NSDictionary (ObjectClassAccess)

- (BOOL)boolForKey:(id)aKey;
- (NSDate *)dateForKey:(id)aKey;
- (float)floatForKey:(id)aKey;
- (NSNumber *)numberForKey:(id)aKey;
- (LUMonetaryValue *)monetaryValueForKey:(id)aKey;
- (NSString *)stringForKey:(id)aKey;

@end
