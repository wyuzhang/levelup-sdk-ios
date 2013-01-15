#import "LUAPIModel.h"

@interface LUCreditCard : LUAPIModel

@property (nonatomic, copy) NSString *cvv;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSNumber *expirationMonth;
@property (nonatomic, copy) NSNumber *expirationYear;
@property (nonatomic, copy) NSString *last_4;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSNumber *promoted;
@property (nonatomic, copy) NSString *type;

+ (LUCreditCard *)promotedCardFromCards:(NSArray *)cards;
- (NSString *)displayNumber;
- (BOOL)isPromoted;

@end