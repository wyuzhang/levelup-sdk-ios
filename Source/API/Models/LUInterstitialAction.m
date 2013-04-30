#import "LUInterstitialAction.h"

@implementation LUInterstitialAction

#pragma mark - Creation

- (id)initWithCampaign:(LUCampaign *)campaign interstitialActionID:(NSNumber *)interstitialActionID
                  type:(LUInterstitialActionType)type {
  self = [super init];
  if (!self) return nil;

  _campaign = campaign;
  _interstitialActionID = interstitialActionID;
  _type = type;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat: @"LUInterstitialAction [campaign=%@, ID=%@, type=%@]", self.campaign,
          self.interstitialActionID, [self typeString]];
}

#pragma mark - Private Methods

- (NSString *)typeString {
  switch (self.type) {
    case LUInterstitialActionTypeCustomerAcquisitionShare:
      return @"customer acquisition share";

    case LUInterstitialActionTypeEmailCaptureClaim:
      return @"email capture claim";

    default:
      return nil;
  }
}

@end
