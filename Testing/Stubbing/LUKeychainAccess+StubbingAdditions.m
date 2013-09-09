// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <objc/runtime.h>
#import "LUKeychainAccess+StubbingAdditions.h"

@implementation LUKeychainAccess (StubbingAdditions)

static NSMutableDictionary *_keychain;

+ (void)stubKeychainAccess {
  [self swapAccessImplementations];
  _keychain = [NSMutableDictionary dictionary];
}

+ (void)clearKeychainData {
  [_keychain removeAllObjects];
}

+ (void)swapAccessImplementations {
  Method realSetMethod = class_getInstanceMethod([self class], @selector(setObject:forKey:));
  Method fakeSetMethod = class_getInstanceMethod([self class], @selector(fakeSetObject:forKey:));

  method_exchangeImplementations(realSetMethod, fakeSetMethod);

  Method realGetMethod = class_getInstanceMethod([self class], @selector(objectForKey:));
  Method fakeGetMethod = class_getInstanceMethod([self class], @selector(fakeObjectForKey:));

  method_exchangeImplementations(realGetMethod, fakeGetMethod);
}

- (id)fakeObjectForKey:(NSString *)key {
  return [_keychain valueForKey:key];
}

- (void)fakeSetObject:(id)object forKey:(NSString *)key {
  [_keychain setValue:object forKey:key];
}

@end
