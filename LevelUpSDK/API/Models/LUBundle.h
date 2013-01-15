#import "LUAPIModel.h"

@class LUMonetaryValue;

@interface LUBundle : LUAPIModel

@property (nonatomic, strong) LUMonetaryValue *amount;
@property (nonatomic, copy) NSString *last_4;
@property (nonatomic, strong) NSArray *orders;
@property (nonatomic, strong) NSArray *refunds;
@property (nonatomic, strong) LUMonetaryValue *totalCreditUsed;

- (NSDate *)chargeDate;
- (NSDate *)creationDate;
- (BOOL)hasChargeData;
- (BOOL)hasNonZeroBalance;
- (BOOL)hasSavings;
- (BOOL)isClosed;
- (NSArray *)ordersAndRefunds;

@end
