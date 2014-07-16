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

#import "LURegistration.h"
#import "LURegistrationJSONFactory.h"

SPEC_BEGIN(LURegistrationJSONFactorySpec)

describe(@"LURegistrationJSONFactory", ^{
  __block LURegistrationJSONFactory *factory;

  beforeEach(^{
    factory = [LURegistrationJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LURegistration", ^{
      NSDictionary *JSON = @{@"app_name": @"App Name", @"description": @"A Description", @"facebook": @YES};
      LURegistration *registration = [factory createFromAttributes:JSON];

      [[registration.appName should] equal:@"App Name"];
      [[theValue(registration.facebook) should] beYes];
      [[registration.registrationDescription should] equal:@"A Description"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'registration'", ^{
      [[[factory rootKey] should] equal:@"registration"];
    });
  });
});

SPEC_END
