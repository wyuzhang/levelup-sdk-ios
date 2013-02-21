#import "LUAPIModel.h"

@class LUCampaign;

/**
 Some merchants or receipts may be associated with an `LUInterstitalAction`, which shows the user a campaign that they
 may claim and/or share.
 */
@interface LUInterstitialAction : LUAPIModel

/**
 This interstitial action's campaign.
 */
@property (nonatomic, strong) LUCampaign *campaign;

/**
 The unique identifier for this interstitial action.
 */
@property (nonatomic, copy) NSNumber *interstitialActionID;

/**
 A string representing the type of the action.
 */
@property (nonatomic, copy) NSString *type;

/**
 Represents whether this interstitial action is for sharing; the user should be presented with buttons to share
 information about the campaign via email or social networks.
 */
- (BOOL)isCustomerAcquisitionShare;

/**
 An "email capture claim" is an interstitial action that gives the user an option to join a merchant's email list.
 */
- (BOOL)isEmailCaptureClaim;

@end
