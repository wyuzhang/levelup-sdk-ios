#import <Foundation/Foundation.h>

@class LUDonation;
@class LUInterstitialAction;
@class LULocation;
@class LULoyalty;
@class LUMerchant;
@class LUMonetaryValue;

@interface LUOrder : NSObject

@property (nonatomic, strong) LUMonetaryValue *balance;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, strong) LUMonetaryValue *credit;
@property (nonatomic, weak, readonly) NSDate *creationDate;
@property (nonatomic, strong) LUDonation *donation;
@property (nonatomic, strong) LUMonetaryValue *earn;
@property (nonatomic, strong) LUInterstitialAction *interstitialAction;
@property (nonatomic, strong) LULocation *location;
@property (nonatomic, strong) LULoyalty *loyalty;
@property (nonatomic, strong) LUMerchant *merchant;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, strong) LUMonetaryValue *spend;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, strong) LUMonetaryValue *tip;
@property (nonatomic, strong) LUMonetaryValue *total;

- (BOOL)hasDonation;
- (BOOL)hasEarnCredit;

@end
