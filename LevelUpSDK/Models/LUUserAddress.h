#import <Foundation/Foundation.h>

@interface LUUserAddress : NSObject

@property (nonatomic, copy) NSString *addressType;
@property (nonatomic, copy) NSString *extendedAddress;
@property (nonatomic, copy) NSString *locality;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *streetAddress;

- (BOOL)isHomeAddress;
- (BOOL)isOtherAddress;
- (BOOL)isWorkAddress;

@end
