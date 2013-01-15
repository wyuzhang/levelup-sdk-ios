#import "LUAPIModel.h"

@class LUUserAddress;

@interface LUMerchandiseOrder : LUAPIModel

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *locality;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, strong) LUUserAddress *shippingAddress;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *zip;

@end
