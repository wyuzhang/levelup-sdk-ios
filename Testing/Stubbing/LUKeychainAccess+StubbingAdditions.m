// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <objc/runtime.h>
#import "LUKeychainAccess+StubbingAdditions.h"

@implementation LUKeychainAccess (StubbingAdditions)

static NSMutableDictionary *_keychainData;
static BOOL _isKeychainStubbed;

#pragma mark - Public Methods

+ (void)clearKeychainData {
  [_keychainData removeAllObjects];
}

+ (NSDictionary *)keychainData {
  return _keychainData;
}

+ (void)stubKeychainAccess {
  if (!_isKeychainStubbed) [self swapAccessImplementations];
  _keychainData = [NSMutableDictionary dictionary];
}

#pragma mark - Private Methods

- (NSData *)fakeDataForKey:(NSString *)key {
  return [_keychainData valueForKey:key];
}

- (void)fakeSetData:(NSData *)data forKey:(NSString *)key {
  [_keychainData setValue:data forKey:key];
}

+ (void)swapAccessImplementations {
  Method realSetMethod = class_getInstanceMethod([self class], @selector(setData:forKey:));
  Method fakeSetMethod = class_getInstanceMethod([self class], @selector(fakeSetData:forKey:));

  method_exchangeImplementations(realSetMethod, fakeSetMethod);

  Method realGetMethod = class_getInstanceMethod([self class], @selector(dataForKey:));
  Method fakeGetMethod = class_getInstanceMethod([self class], @selector(fakeDataForKey:));

  method_exchangeImplementations(realGetMethod, fakeGetMethod);

  _isKeychainStubbed = YES;
}

@end
