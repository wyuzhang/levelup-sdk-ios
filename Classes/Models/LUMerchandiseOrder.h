#import <Foundation/Foundation.h>

@class LUUserAddress;

@interface LUMerchandiseOrder : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *locality;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, strong) LUUserAddress *shippingAddress;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *zip;

- (NSDictionary *)parameters;

@end
