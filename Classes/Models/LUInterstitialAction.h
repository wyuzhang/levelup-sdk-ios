#import <Foundation/Foundation.h>

@class LUCampaign;

@interface LUInterstitialAction : NSObject

@property (nonatomic, strong) LUCampaign *campaign;
@property (nonatomic, strong) NSString *type;

- (BOOL)isCustomerAcquisitionShare;
- (BOOL)isEmailCaptureClaim;

@end
