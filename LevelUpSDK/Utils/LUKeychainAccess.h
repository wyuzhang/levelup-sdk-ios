#import <Foundation/Foundation.h>

// Adapted from https://github.com/lolay/locksmith

@interface LUKeychainAccess : NSObject

+ (BOOL)deleteStringForKey:(NSString *)key;
+ (BOOL)saveString:(NSString *)inputString forKey:(NSString	*)key;
+ (NSString *)stringForKey:(NSString *)key;

@end
