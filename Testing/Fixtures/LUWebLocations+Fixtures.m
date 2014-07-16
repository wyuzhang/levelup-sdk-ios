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

#import "LUWebLocations+Fixtures.h"

@implementation LUWebLocations (Fixtures)

+ (LUWebLocations *)fixture {
  return [[LUWebLocations alloc] initWithFacebookAddress:@"http://facebook.com/pizza"
                                          foodlerAddress:@"http://foodler.com/pizza"
                                             menuAddress:@"http://pizza.com/menu"
                                       newsletterAddress:@"http://pizza.com/newsletter"
                                        opentableAddress:@"http://opentable.com/pizza"
                                          twitterAddress:@"http://twitter.com/pizza"
                                             yelpAddress:@"http://yelp.com/pizza"];
}

@end
