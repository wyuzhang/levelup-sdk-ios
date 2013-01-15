#import <CoreLocation/CoreLocation.h>
#import "LUAPIModel.h"
#import <MapKit/MapKit.h>

@interface LULocation : LUAPIModel <MKAnnotation>

@property (nonatomic, copy) NSString *extendedAddress;
@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSString *locality;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *streetAddress;

- (NSString *)fullStreetAddress;
- (CLLocation *)location;
- (NSString *)singleLineAddress;

@end
