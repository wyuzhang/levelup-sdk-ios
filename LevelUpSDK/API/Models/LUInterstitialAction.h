#import "LUAPIModel.h"

@class LUCampaign;

@interface LUInterstitialAction : LUAPIModel

@property (nonatomic, strong) LUCampaign *campaign;
@property (nonatomic, strong) NSString *type;

- (BOOL)isCustomerAcquisitionShare;
- (BOOL)isEmailCaptureClaim;

@end
