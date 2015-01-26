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

/**
 `LUCategoryRequestFactory` is used to check-in when in an app gets in range of a LevelUp iBeacon.

 If your app sends push tokens to LevelUp (see also `LUAPNDeviceRequestFactory`), then users
 may receive a push notification shortly after the beacon check-in, alerting them that they can
 pay with your app at the nearby location. Beacon messages can be configured within [the LevelUp
 Dashboard] [1].

 LevelUp iBeacons have the UUID 56DB0365-A001-4062-9E4D-499D3B8ECCF3. For more information on
 developing with iBeacons, see [Apple's documentation] [2].

 [1]: https://www.thelevelup.com/dashboard/add_ons/beacon_messages
 [2]: https://developer.apple.com/ibeacon/
 */
@interface LUIBeaconCheckInRequestFactory : NSObject

/**
 Builds a request to check-in with the given iBeacon major and minor IDs.

 @warning This request requires an access token with the `LUPermissionBeaconCheckins` permission.
 @param major The string value of the major value of a `CLBeacon`.
 @param minor The string value of the minor value of a `CLBeacon`.
 */
+ (LUAPIRequest *)requestToCheckInIBeaconWithMajor:(NSString *)major minor:(NSString *)minor;

@end
