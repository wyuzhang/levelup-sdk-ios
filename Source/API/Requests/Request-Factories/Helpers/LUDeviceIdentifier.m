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

#import "LUDeviceIdentifier.h"
#import "LUKeychainAccess.h"

NSString * const DeviceIdentifierKey = @"LUDeviceIdentifier";

@implementation LUDeviceIdentifier

#pragma mark - Public Methods

+ (NSString *)deviceIdentifier {
  NSString *advertisingID = [self advertisingID];
  if (advertisingID) {
    return advertisingID;
  } else {
    return [self randomlyGeneratedID];
  }
}

+ (BOOL)doesAppIncludeAdSupport {
  return [self ASIdentifierManagerClass] != nil;
}

#pragma mark - Private Methods

+ (Class)ASIdentifierManagerClass {
  return NSClassFromString(@"ASIdentifierManager");
}

+ (NSString *)advertisingID {
  if (![self doesAppIncludeAdSupport]) return nil;

  id advertisingManager = [self performSelectorWithName:@"sharedManager"
                                               onObject:[self ASIdentifierManagerClass]];
  NSUUID *advertisingUUID = [self performSelectorWithName:@"advertisingIdentifier"
                                                 onObject:advertisingManager];
  return [advertisingUUID UUIDString];
}

+ (id)performSelectorWithName:(NSString *)selectorName onObject:(id)anObject {
  SEL selector = NSSelectorFromString(selectorName);
  IMP imp = [anObject methodForSelector:selector];
  id (*func)(id, SEL) = (void *)imp;
  return func(anObject, selector);
}

+ (NSString *)randomlyGeneratedID {
  NSString *deviceIdentifier = [[LUKeychainAccess standardKeychainAccess] stringForKey:DeviceIdentifierKey];

  if (deviceIdentifier == nil) {
    deviceIdentifier = [[NSUUID UUID] UUIDString];

    [[LUKeychainAccess standardKeychainAccess] setString:deviceIdentifier forKey:DeviceIdentifierKey];
  }

  return deviceIdentifier;
}

@end
