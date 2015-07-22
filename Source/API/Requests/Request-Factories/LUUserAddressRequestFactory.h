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

@class LUAPIRequest;
@class LUUserAddress;

/**
 `LUUserAddressRequestFactory` is used to build requests related to users' addresses.
 */
@interface LUUserAddressRequestFactory : NSObject

/**
 Builds a request to return all user addresses added by the current user.

 On success, this request will return an array of `LUUserAddress` instances.

 @warning This request requires an access token with the `LUPermissionManageUserAddresses`
 permission.
 */
+ (LUAPIRequest *)requestForUserAddresses;

/**
 Builds a request to create a user address.

 On success, this request will return the newly created `LUUserAddress`.

 @warning This request requires an access token with the `LUPermissionManageUserAddresses`
 permission.
 @param userAddress The `LUUserAddress` to create.
 */
+ (LUAPIRequest *)requestToCreateUserAddress:(LUUserAddress *)userAddress;

@end
