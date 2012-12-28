#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LULocation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *extendedAddress;
@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSString *locality;
@property (nonatomic, weak, readonly) CLLocation *location;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, weak, readonly) NSString *singleLineAddress;
@property (nonatomic, copy) NSString *streetAddress;

- (NSString *)fullStreetAddress;

@end
