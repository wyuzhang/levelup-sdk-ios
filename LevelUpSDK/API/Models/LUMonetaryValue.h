#import "LUAPIModel.h"

@interface LUMonetaryValue : LUAPIModel

@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSString *currencyCode;
@property (nonatomic, copy) NSString *currencySymbol;
@property (nonatomic, copy) NSString *formattedAmount;

+ (LUMonetaryValue *)monetaryValueWithUSD:(NSNumber *)amount;
- (NSString *)formattedAmountWithSymbol;
- (NSString *)shortFormatWithSymbol;

@end
