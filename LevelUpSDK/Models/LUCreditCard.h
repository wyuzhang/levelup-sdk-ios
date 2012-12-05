#import <Foundation/Foundation.h>

@interface LUCreditCard : NSObject

@property (nonatomic, copy) NSString *cvv;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, weak, readonly) NSString *displayNumber;
@property (nonatomic, copy) NSNumber *expirationMonth;
@property (nonatomic, copy) NSNumber *expirationYear;
@property (nonatomic, copy) NSString *last_4;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSNumber *promoted;
@property (nonatomic, copy) NSString *type;

+ (LUCreditCard *)promotedCardFromCards:(NSArray *)cards;
- (NSUInteger)hash;
- (BOOL)isEqual:(id)otherObject;
- (BOOL)isPromoted;
- (NSDictionary *)parameters;

@end
