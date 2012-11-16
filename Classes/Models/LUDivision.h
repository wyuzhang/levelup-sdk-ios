#import <Foundation/Foundation.h>

@class CLLocation;

@interface LUDivision : NSObject

@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *name;

- (CLLocation *)location;

@end
