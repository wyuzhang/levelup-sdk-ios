#import <CoreLocation/CoreLocation.h>
#import "LUAPIModel.h"
#import <MapKit/MapKit.h>

/**
 A LevelUp merchant has one or more locations. Take the example of a chain restaurant with multiple franchises. This
 restaurant would have a single `LUMerchant` associated with it, but each store would have its own `LULocation`.

 ## MapKit

 `LULocation` implements the `MKAnnotation` protocol. This provides annotation-related information to a map view. The
 title of the annotation is the result of `fullStreetAddress`.
 */
@interface LULocation : LUAPIModel <MKAnnotation>

/**
 An optional "extended" address for the location. An example would be an apartment number.
 */
@property (nonatomic, copy) NSString *extendedAddress;

/**
 An optional string representing the hours during which this location is open. The format of this string is determined
 by the location.
 */
@property (nonatomic, copy) NSString *hours;

/**
 The latitude of the location.
 */
@property (nonatomic, copy) NSNumber *lat;

/**
 The location's town or city.
 */
@property (nonatomic, copy) NSString *locality;

/**
 The longitude of the location.
 */
@property (nonatomic, copy) NSNumber *lng;

/**
 An optional phone number for the location.
 */
@property (nonatomic, copy) NSString *phone;

/**
 The location's postal code.
 */
@property (nonatomic, copy) NSString *postalCode;

/**
 The location's region, such as a state or province.
 */
@property (nonatomic, copy) NSString *region;

/**
 The location's address. If the location's address has a second line (such as an apartment number), this will be
 stored separately in the `extendedAddress` field.
 */
@property (nonatomic, copy) NSString *streetAddress;

/**
 If the location has both a `streetAddress` and an `extendedAddress`, this will return both values joined by a comma.
 For example, "123 Main Street, Apt 2A". When an `extendedAddress` is not present, only the `streetAddress` will be
 returned.
 */
- (NSString *)fullStreetAddress;

/**
 A `CLLocation` instance associated with this division.
 */
- (CLLocation *)location;

/**
 A helper method which returns all the address fields in one line. The format is "<full street address>, <locality>,
 <region> <postal code>". For example: "123 Main Street, Apt 2A, Boston, MA 01234".
 */
- (NSString *)singleLineAddress;

@end
