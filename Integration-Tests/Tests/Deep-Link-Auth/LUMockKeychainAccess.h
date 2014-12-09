#import "LUKeychainAccess.h"

@interface LUMockKeychainAccess : LUKeychainAccess

@property (nonatomic, strong, readonly) NSMutableDictionary *storage;

@end
