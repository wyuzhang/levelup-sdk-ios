#import <CoreLocation/CoreLocation.h>
#import "LUAPIModel.h"

/**
 A division is a specific region to which a merchant belongs. This is typically a town, city or county.
 */
@interface LUDivision : LUAPIModel

/**
 The division's latitude.
 */
@property (nonatomic, copy) NSNumber *lat;

/**
 The division's longitude.
 */
@property (nonatomic, copy) NSNumber *lng;

/**
 The name of the division.
 */
@property (nonatomic, copy) NSString *name;

/**
 A `CLLocation` instance associated with this division.
 */
- (CLLocation *)location;

@end
