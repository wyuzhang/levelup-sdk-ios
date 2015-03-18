/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

/**
 Use `LUIBeaconListener` to monitor for LevelUp iBeacons.

 `LUIBeaconListener` requires the app to have Location Services permission in the background, and
 for Bluetooth to be enabled on the device. If the app doesn't have Location Services permission,
 this class will not request permission.

 When a LevelUp iBeacon is detected, a check-in will be made to the LevelUp server. See
 `LUIBeaconCheckInRequestFactory` for more details on beacon check-ins.
 */
@interface LUIBeaconListener : NSObject <CBCentralManagerDelegate, CLLocationManagerDelegate>

/**
 Specifies if the `LUIBeaconListener` is currently monitoring for beacons.
 */
@property (nonatomic, assign, readonly) BOOL isMonitoringForBeacons;

/**
 Start monitoring for beacons.
 */
- (void)startMonitoring;

/**
 Stop monitoring for beacons.
 */
- (void)stopMonitoring;

@end
