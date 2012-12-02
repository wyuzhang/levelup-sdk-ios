#import <Foundation/Foundation.h>

@class LUMonetaryValue;

@interface LULoyalty : NSObject

@property (nonatomic, copy) NSNumber *merchantId;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSNumber *onboardingEligible;
@property (nonatomic, copy) NSNumber *ordersCount;
@property (nonatomic, strong) LUMonetaryValue *potentialCredit;
@property (nonatomic, readonly) float progress;
@property (nonatomic, copy) NSNumber *progressPercent;
@property (nonatomic, strong) LUMonetaryValue *savings;
@property (nonatomic, strong) LUMonetaryValue *spendRemaining;

- (BOOL)isOnboardingEligible;

@end
