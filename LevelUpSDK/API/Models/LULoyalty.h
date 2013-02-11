#import "LUAPIModel.h"

@class LUMonetaryValue;

@interface LULoyalty : LUAPIModel

@property (nonatomic, copy) NSNumber *merchantId;
@property (nonatomic, copy) NSNumber *ordersCount;
@property (nonatomic, strong) LUMonetaryValue *potentialCredit;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) float progressPercent;
@property (nonatomic, strong) LUMonetaryValue *savings;
@property (nonatomic, strong) LUMonetaryValue *shouldSpend;
@property (nonatomic, strong) LUMonetaryValue *spendRemaining;
@property (nonatomic, strong) LUMonetaryValue *totalVolume;
@property (nonatomic, strong) LUMonetaryValue *willEarn;

@end
