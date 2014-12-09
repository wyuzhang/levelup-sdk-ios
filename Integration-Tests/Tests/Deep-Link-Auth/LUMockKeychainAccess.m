#import "LUMockKeychainAccess.h"

@implementation LUMockKeychainAccess

- (id)init {
  self = [super init];
  if (!self) return nil;

  _storage = [NSMutableDictionary dictionary];

  return self;
}

- (NSData *)dataForKey:(NSString *)key {
  return self.storage[key];
}

- (void)setData:(NSData *)data forKey:(NSString *)key {
  self.storage[key] = data;
}

@end
