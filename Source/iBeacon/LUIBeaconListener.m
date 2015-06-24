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

#import "LUAPIClient.h"
#import "LUIBeaconCheckInRequestFactory.h"
#import "LUIBeaconListener.h"

NSString * const LUIBeaconIdentifier = @"71E77F";
NSTimeInterval const LUIBeaconNotificationMinimumInterval = 60;
NSString * const LUIBeaconUUID = @"56DB0365-A001-4062-9E4D-499D3B8ECCF3";

@interface LUIBeaconListener ()

@property (nonatomic, strong) CBCentralManager *bluetoothManager;
@property (nonatomic, assign) BOOL isMonitoringForBeacons;
@property (nonatomic, strong) NSDate *lastNotificationShownTime;

@end

@implementation LUIBeaconListener

#pragma mark - Lifecycle Methods

- (id)init {
  self = [super init];
  if (!self) return nil;

  _lastNotificationShownTime = [NSDate distantPast];
  _locationManager = [[CLLocationManager alloc] init];
  _locationManager.delegate = self;

  return self;
}

- (void)dealloc {
  _bluetoothManager.delegate = nil;
  _locationManager.delegate = nil;
}

#pragma mark - Public Methods

- (void)startMonitoring {
  self.bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self
                                                               queue:nil
                                                             options:@{CBCentralManagerOptionShowPowerAlertKey: @NO}];
}

- (void)stopMonitoring {
  self.bluetoothManager.delegate = nil;
  self.bluetoothManager = nil;

  [self.locationManager stopMonitoringForRegion:[self iBeaconRegion]];
  [self.locationManager stopRangingBeaconsInRegion:[self iBeaconRegion]];
}

#pragma mark - CBCentralManagerDelegate Methods

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
  if (central.state != CBCentralManagerStatePoweredOn) return;

  CLBeaconRegion *iBeaconRegion = [self iBeaconRegion];
  if (!iBeaconRegion) return;

  iBeaconRegion.notifyOnEntry = YES;
  iBeaconRegion.notifyOnExit = YES;
  iBeaconRegion.notifyEntryStateOnDisplay = YES;

  [self.locationManager startMonitoringForRegion:iBeaconRegion];
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  if ([self shouldRespondToCLRegion:region]) {
    CLBeaconRegion *iBeaconRegion = (CLBeaconRegion *)region;
    [self.locationManager startRangingBeaconsInRegion:iBeaconRegion];
  }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
  if ([self shouldRespondToCLRegion:region]) {
    CLBeaconRegion *iBeaconRegion = (CLBeaconRegion *)region;
    [self.locationManager stopRangingBeaconsInRegion:iBeaconRegion];
  }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
  if ([self shouldRespondToCLRegion:region]) {
    for (CLBeacon *iBeacon in beacons) {
      [self didFindIBeacon:iBeacon];
    }
  }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
  if ([self shouldRespondToCLRegion:region]) {
    self.isMonitoringForBeacons = YES;
  }
}

#pragma mark - Private Methods

- (void)didFindIBeacon:(CLBeacon *)iBeacon {
  if (![self shouldRespondToRangedIBeacon:iBeacon]) return;

  self.lastNotificationShownTime = [NSDate date];

  LUAPIRequest *request = [LUIBeaconCheckInRequestFactory requestToCheckInIBeaconWithMajor:[iBeacon.major stringValue]
                                                                                     minor:[iBeacon.minor stringValue]];
  if (request) {
    [[LUAPIClient sharedClient] performRequest:request success:nil failure:nil];
  }
}

- (CLBeaconRegion *)iBeaconRegion {
  NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:LUIBeaconUUID];
  return [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:LUIBeaconIdentifier];
}

- (BOOL)shouldRespondToCLRegion:(CLRegion *)region {
  return [region isKindOfClass:[CLBeaconRegion class]] && [region.identifier isEqualToString:LUIBeaconIdentifier];
}

- (BOOL)shouldRespondToRangedIBeacon:(CLBeacon *)iBeacon {
  return [[iBeacon.proximityUUID UUIDString] isEqualToString:LUIBeaconUUID] &&
         [[NSDate date] timeIntervalSinceDate:self.lastNotificationShownTime] > LUIBeaconNotificationMinimumInterval;
}

@end
