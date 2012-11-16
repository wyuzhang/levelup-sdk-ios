#import <Foundation/Foundation.h>

@interface LUMonetaryValue : NSObject

@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSString *currencyCode;
@property (nonatomic, copy) NSString *currencySymbol;
@property (nonatomic, copy) NSString *formattedAmount;
@property (weak, nonatomic, readonly) NSString *formattedAmountWithSymbol;
@property (nonatomic, copy) NSNumber *modelId;

+ (LUMonetaryValue *)valueOrDefaultFor:(LUMonetaryValue *)value;
- (NSString *)shortFormatWithSymbol;

@end
