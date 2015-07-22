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

#import "LUUserAddress+Fixtures.h"

@implementation LUUserAddress (Fixtures)

+ (LUUserAddress *)fixture {
  return [[LUUserAddress alloc] initWithAddressID:@1 addressType:@"home"
                                  extendedAddress:@"Apt 1" locality:@"Boston"
                                       postalCode:@"02114" region:@"MA"
                                    streetAddress:@"123 Main St"];
}

@end
