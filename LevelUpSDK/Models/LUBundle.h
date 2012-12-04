@class LUMonetaryValue;

@interface LUBundle : NSObject

@property (nonatomic, strong) LUMonetaryValue *amount;
@property (nonatomic, copy) NSString *chargedAt;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *last_4;
@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, strong) NSArray *orders;
@property (nonatomic, strong) NSArray *refunds;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, strong) LUMonetaryValue *totalCreditEarned;

@end
