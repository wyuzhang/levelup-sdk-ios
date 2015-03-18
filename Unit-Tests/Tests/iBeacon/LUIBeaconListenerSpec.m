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

#import "LUIBeaconListener.h"

@interface LUIBeaconListener (PrivateProperties)

@property (nonatomic, strong) CBCentralManager *bluetoothManager;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSDate *lastNotificationShownTime;

@end

SPEC_BEGIN(LUIBeaconListenerSpec)

describe(@"LUIBeaconListener", ^{
  __block CBCentralManager *bluetoothManager;
  __block LUIBeaconListener *iBeaconListener;
  __block CLLocationManager *locationManager;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];

    bluetoothManager = [CBCentralManager nullMock];
    [CBCentralManager stub:@selector(alloc) andReturn:bluetoothManager];
    [bluetoothManager stub:@selector(initWithDelegate:queue:options:) andReturn:bluetoothManager];

    locationManager = [CLLocationManager nullMock];
    [CLLocationManager stub:@selector(alloc) andReturn:locationManager];
    [locationManager stub:@selector(init) andReturn:locationManager];

    iBeaconListener = [[LUIBeaconListener alloc] init];
  });

  // Public Methods

  describe(@"startMonitoring", ^{
    it(@"starts a Bluetooth manager with itself as the delegate", ^{
      [[bluetoothManager should] receive:@selector(initWithDelegate:queue:options:)
                           withArguments:iBeaconListener, any(), any()];

      [iBeaconListener startMonitoring];

      [[iBeaconListener.bluetoothManager should] equal:bluetoothManager];
    });
  });

  describe(@"stopMonitoring", ^{
    beforeEach(^{
      [iBeaconListener startMonitoring];
    });

    it(@"clears the Blueooth manager", ^{
      [iBeaconListener stopMonitoring];

      [[iBeaconListener.bluetoothManager should] beNil];
    });

    it(@"stops monitoring iBeacons", ^{
      [[iBeaconListener.locationManager should] receive:@selector(stopMonitoringForRegion:)];

      [iBeaconListener stopMonitoring];
    });

    it(@"stops ranging iBeacons", ^{
      [[iBeaconListener.locationManager should] receive:@selector(stopRangingBeaconsInRegion:)];

      [iBeaconListener stopMonitoring];
    });
  });

  // CBCentralManagerDelegate Methods

  describe(@"centralManagerDidUpdateState:", ^{
    context(@"when the state is CBCentralManagerStatePoweredOn", ^{
      beforeEach(^{
        [bluetoothManager stub:@selector(state) andReturn:theValue(CBCentralManagerStatePoweredOn)];
      });

      it(@"tells its location manager to start monitoring the iBeacon region", ^{
        [[iBeaconListener.locationManager should] receive:@selector(startMonitoringForRegion:)];

        [iBeaconListener centralManagerDidUpdateState:bluetoothManager];
      });
    });

    context(@"when the state is not CBCentralManagerStatePoweredOn", ^{
      beforeEach(^{
        [bluetoothManager stub:@selector(state) andReturn:theValue(CBCentralManagerStatePoweredOff)];
      });

      it(@"doesn't tell its location manager to start monitoring the iBeacon region", ^{
        [[iBeaconListener.locationManager shouldNot] receive:@selector(startMonitoringForRegion:)];

        [iBeaconListener centralManagerDidUpdateState:bluetoothManager];
      });
    });
  });

  // CLLocationManagerDelegate Methods

  describe(@"locationManager:didEnterRegion:", ^{
    __block CLRegion *region;

    context(@"and the region is a CLBeaconRegion", ^{
      beforeEach(^{
        region = [CLBeaconRegion mock];
      });

      it(@"starts ranging in that region", ^{
        [[iBeaconListener.locationManager should] receive:@selector(startRangingBeaconsInRegion:)];

        [iBeaconListener locationManager:nil didEnterRegion:region];
      });
    });

    context(@"and the region is not a CLBeaconRegion", ^{
      beforeEach(^{
        region = [CLRegion mock];
      });

      it(@"does not start ranging in that region", ^{
        [[iBeaconListener.locationManager shouldNot] receive:@selector(startRangingBeaconsInRegion:)];

        [iBeaconListener locationManager:nil didEnterRegion:region];
      });
    });
  });

  describe(@"locationManager:didExitRegion:", ^{
    __block CLRegion *region;

    context(@"and the region is a CLBeaconRegion", ^{
      beforeEach(^{
        region = [CLBeaconRegion mock];
      });

      it(@"stops ranging in that region", ^{
        [[iBeaconListener.locationManager should] receive:@selector(stopRangingBeaconsInRegion:)];

        [iBeaconListener locationManager:nil didExitRegion:region];
      });
    });

    context(@"and the region is not a CLBeaconRegion", ^{
      beforeEach(^{
        region = [CLRegion mock];
      });

      it(@"does not stop ranging in that region", ^{
        [[iBeaconListener.locationManager shouldNot] receive:@selector(stopRangingBeaconsInRegion:)];

        [iBeaconListener locationManager:nil didExitRegion:region];
      });
    });
  });

  describe(@"locationManager:didRangeBeacons:inRegion:", ^{
    __block CLBeaconRegion *region;
    __block CLBeacon *iBeacon;

    beforeEach(^{
      region = [CLBeaconRegion mock];
      iBeacon = [[CLBeacon alloc] init];
      [iBeacon setValue:[NSNumber numberWithInt:1] forKey:@"minor"];
      [iBeacon setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    });

    context(@"when the last notification shown was > 1 minute ago", ^{
      beforeEach(^{
        NSDate *now = [NSDate date];
        NSDate *past = [NSDate dateWithTimeInterval:-75 sinceDate:now];
        [NSDate stub:@selector(date) andReturn:now];
        [iBeaconListener stub:@selector(lastNotificationShownTime) andReturn:past];

        [LUIBeaconCheckInRequestFactory stub:@selector(requestToCheckInIBeaconWithMajor:minor:)
                                   andReturn:[LUAPIRequest mock]];
        [[LUAPIClient sharedClient] stub:@selector(performRequest:success:failure:)];
      });

      it(@"creates an iBeacon checkin request for the discovered iBeacon", ^{
        [[LUIBeaconCheckInRequestFactory should] receive:@selector(requestToCheckInIBeaconWithMajor:minor:)];

        [iBeaconListener locationManager:nil didRangeBeacons:@[iBeacon] inRegion:region];
      });

      it(@"makes a network call for the discovered iBeacon", ^{
        [[[LUAPIClient sharedClient] should] receive:@selector(performRequest:success:failure:)];

        [iBeaconListener locationManager:nil didRangeBeacons:@[iBeacon] inRegion:region];
      });

      it(@"updates lastNotificationShownTime", ^{
        [[iBeaconListener should] receive:@selector(setLastNotificationShownTime:)];

        [iBeaconListener locationManager:nil didRangeBeacons:@[iBeacon] inRegion:region];
      });
    });

    context(@"when the last notification was shown < 1 minute ago", ^{
      beforeEach(^{
        NSDate *now = [NSDate date];
        NSDate *recentPast = [NSDate dateWithTimeInterval:-45 sinceDate:now];
        [NSDate stub:@selector(date) andReturn:now];
        [iBeaconListener stub:@selector(lastNotificationShownTime) andReturn:recentPast];
      });

      it(@"does not create a iBeacon checkin request for the discovered iBeacon", ^{
        [[LUIBeaconCheckInRequestFactory shouldNot] receive:@selector(requestToCheckInIBeaconWithMajor:minor:)];

        [iBeaconListener locationManager:nil didRangeBeacons:@[iBeacon] inRegion:region];
      });

      it(@"does not make a network call for the discovered iBeacon", ^{
        [[[LUAPIClient sharedClient] shouldNot] receive:@selector(performRequest:success:failure:)];

        [iBeaconListener locationManager:nil didRangeBeacons:@[iBeacon] inRegion:region];
      });

      it(@"does not  update lastNotificationShownTime", ^{
        [[iBeaconListener shouldNot] receive:@selector(setLastNotificationShownTime:)];

        [iBeaconListener locationManager:nil didRangeBeacons:@[iBeacon] inRegion:region];
      });
    });
  });

  describe(@"locationManager:didStartMonitoringForRegion:", ^{
    __block CLRegion *region;

    beforeEach(^{
      region = [CLBeaconRegion mock];
    });

    it(@"sets isMonitoringForBeacons to YES", ^{
      [iBeaconListener locationManager:nil didStartMonitoringForRegion:region];

      [[theValue(iBeaconListener.isMonitoringForBeacons) should] beYes];
    });

    it(@"starts ranging", ^{
      [[iBeaconListener.locationManager should] receive:@selector(startRangingBeaconsInRegion:)];

      [iBeaconListener locationManager:nil didStartMonitoringForRegion:region];
    });
  });
});

SPEC_END
