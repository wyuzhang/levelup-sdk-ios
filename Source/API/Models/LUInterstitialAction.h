#import "LUAPIModel.h"

/**
 Some merchants or receipts may be associated with an `LUInterstitalAction`, which shows the user a campaign that they
 may claim and/or share.
 */

typedef NS_ENUM(NSInteger, LUInterstitialActionType) {
  LUInterstitialActionTypeNone,
  LUInterstitialActionTypeCustomerAcquisitionShare,
  LUInterstitialActionTypeEmailCaptureClaim
};

@class LUCampaign;

@interface LUInterstitialAction : LUAPIModel

/**
 This interstitial action's campaign.
 */
@property (nonatomic, strong, readonly) LUCampaign *campaign;

/**
 The unique identifier for this interstitial action.
 */
@property (nonatomic, copy, readonly) NSNumber *interstitialActionID;

/**
 A string representing the type of the action.

 The type may be one of:

 - Customer acquisition share: this interstitial action is for sharing; the user should be presented with buttons to
 share information about the campaign via email or social networks.
 - Email capture claim: this is an interstitial action that gives the user an option to join a merchant's email list.
 */
@property (nonatomic, assign, readonly) LUInterstitialActionType type;

- (id)initWithCampaign:(LUCampaign *)campaign interstitialActionID:(NSNumber *)interstitialActionID
                  type:(LUInterstitialActionType)type;

@end
