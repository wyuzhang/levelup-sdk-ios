@class LUMonetaryValue;

@interface LUPaymentStringGenerator : NSObject

+ (NSString *)paymentStringWithToken:(NSString *)token tipAmountInUSCents:(NSInteger)tipAmount glowColorID:(NSInteger)glowColorID;
+ (NSString *)paymentStringWithToken:(NSString *)token tipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID;

@end
