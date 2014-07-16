/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
