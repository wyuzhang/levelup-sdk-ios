#import <CoreLocation/CoreLocation.h>
#import "LUAPIModel.h"

@interface LUDivision : LUAPIModel

@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSString *name;

- (CLLocation *)location;

@end
