// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUClaim.h"
#import "LUMonetaryValue.h"

@implementation LUClaim

#pragma mark - Creation

- (id)initWithCampaignID:(NSNumber *)campaignID claimID:(NSNumber *)claimID code:(NSString *)code
                   value:(LUMonetaryValue *)value valueRemaining:(LUMonetaryValue *)valueRemaining {
  self = [super init];
  if (!self) return nil;

  _campaignID = campaignID;
  _claimID = claimID;
  _code = code;
  _value = value;
  _valueRemaining = valueRemaining;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUClaim [campaignID=%@, code=%@, ID=%@, value=%@, valueRemaining=%@]",
          self.campaignID, self.code, self.claimID, self.value, self.valueRemaining];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUClaim [campaignID=%@, ID=%@]", self.code, self.claimID];
}

@end
