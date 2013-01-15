#import "LUAPIModel.h"

@class LUBundle;
@class LUDonation;
@class LUInterstitialAction;
@class LULocation;
@class LULoyalty;
@class LUMerchant;
@class LUMonetaryValue;

@interface LUOrder : LUAPIModel

@property (nonatomic, strong) LUMonetaryValue *balance;
@property (nonatomic, strong) LUBundle *bundle;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) LUMonetaryValue *credit;
@property (nonatomic, strong) LUDonation *donation;
@property (nonatomic, strong) LUMonetaryValue *earn;
@property (nonatomic, strong) LUInterstitialAction *interstitialAction;
@property (nonatomic, strong) LULocation *location;
@property (nonatomic, strong) LULoyalty *loyalty;
@property (nonatomic, strong) LUMerchant *merchant;
@property (nonatomic, strong) LUMonetaryValue *spend;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, strong) LUMonetaryValue *tip;
@property (nonatomic, strong) LUMonetaryValue *total;

- (NSDate *)creationDate;
- (BOOL)hasDonation;
- (BOOL)hasEarnedCredit;
- (BOOL)hasNonZeroBalance;
- (BOOL)hasTipApplied;
- (BOOL)hasUsedCredit;
- (BOOL)isClosed;
- (BOOL)wasRefunded;

@end
