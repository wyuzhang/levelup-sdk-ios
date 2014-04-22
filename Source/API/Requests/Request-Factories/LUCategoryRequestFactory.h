// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LUCategoryRequestFactory` is used to build requests related to categories.
 */
@interface LUCategoryRequestFactory : NSObject

/**
 Builds a request to return the list of all merchant categories.

 On success, this request will return an array of `LUCategory` instances.
 */
+ (LUAPIRequest *)requestForAllCategories;

@end
