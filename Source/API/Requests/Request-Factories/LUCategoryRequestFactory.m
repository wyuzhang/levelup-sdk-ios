// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LUCategoryJSONFactory.h"
#import "LUCategoryRequestFactory.h"

@implementation LUCategoryRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForAllCategories {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"categories"
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCategoryJSONFactory factory]];
}

@end
