#import "LUAPIModel.h"

/**
 This action is used for interstitials that request the user claim a campaign.
 */
@interface LUInterstitialClaimAction : LUAPIModel

/**
 A campaign code that the user will have the option of claiming.
 */
@property (nonatomic, copy, readonly) NSString *campaignCode;

- (id)initWithCampaignCode:(NSString *)campaignCode;

@end
