#import "LUAPIModel.h"

@interface LUMonetaryValue : LUAPIModel

@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSString *currencyCode;
@property (nonatomic, copy) NSString *currencySymbol;
@property (nonatomic, copy) NSString *formattedAmount;

+ (LUMonetaryValue *)valueOrDefaultFor:(LUMonetaryValue *)value;
- (NSString *)formattedAmountWithSymbol;
- (NSString *)shortFormatWithSymbol;

@end