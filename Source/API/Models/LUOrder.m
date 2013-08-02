#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSURL+LUAdditions.h"

@implementation LUOrder

#pragma mark - Creation

- (id)initWithBalance:(LUMonetaryValue *)balance bundleClosedDate:(NSDate *)bundleClosedDate
     bundleDescriptor:(NSString *)bundleDescriptor contribution:(LUMonetaryValue *)contribution
contributionTargetName:(NSString *)contributionTargetName createdDate:(NSDate *)createdDate
               credit:(LUMonetaryValue *)credit earn:(LUMonetaryValue *)earn
locationExtendedAddress:(NSString *)locationExtendedAddress locationID:(NSNumber *)locationID
     locationLocality:(NSString *)locationLocality locationPostalCode:(NSString *)locationPostalCode
       locationRegion:(NSString *)locationRegion locationStreetAddress:(NSString *)locationStreetAddress
           merchantID:(NSNumber *)merchantID merchantName:(NSString *)merchantName refundedDate:(NSDate *)refundedDate
                spend:(LUMonetaryValue *)spend tip:(LUMonetaryValue *)tip total:(LUMonetaryValue *)total
       transactedDate:(NSDate *)transactedDate UUID:(NSString *)UUID {
  self = [super init];
  if (!self) return nil;

  _balance = balance;
  _bundleClosedDate = bundleClosedDate;
  _bundleDescriptor = bundleDescriptor;
  _contribution = contribution;
  _contributionTargetName = contributionTargetName;
  _createdDate = createdDate;
  _credit = credit;
  _earn = earn;
  _locationExtendedAddress = locationExtendedAddress;
  _locationID = locationID;
  _locationLocality = locationLocality;
  _locationPostalCode = locationPostalCode;
  _locationRegion = locationRegion;
  _locationStreetAddress = locationStreetAddress;
  _merchantID = merchantID;
  _merchantName = merchantName;
  _refundedDate = refundedDate;
  _spend = spend;
  _tip = tip;
  _total = total;
  _transactedDate = transactedDate;
  _UUID = UUID;

  return self;
}

#pragma mark - Public Methods

- (BOOL)closed {
  return self.bundleClosedDate != nil;
}

- (BOOL)hasContribution {
  return [self.contribution.amount floatValue] > 0.0f;
}

- (BOOL)hasEarnedCredit {
  return [self.earn.amount floatValue] > 0.0f;
}

- (BOOL)hasNonZeroBalance {
  return [self.balance.amount floatValue] != 0.0f;
}

- (BOOL)hasTipApplied {
  return [self.tip.amount floatValue] > 0.0f;
}

- (BOOL)hasUsedCredit {
  return [self.credit.amount floatValue] > 0.0f;
}

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForLocationWithID:self.locationID];
}

- (NSString *)singleLineAddress {
  NSString *fullStreetAddress;

  if (self.locationExtendedAddress.length > 0) {
    fullStreetAddress = [NSString stringWithFormat:@"%@, %@", self.locationStreetAddress, self.locationExtendedAddress];
  } else {
    fullStreetAddress = self.locationStreetAddress;
  }

  return [NSString stringWithFormat:@"%@, %@, %@ %@", fullStreetAddress, self.locationLocality, self.locationRegion,
          self.locationPostalCode];
}

- (BOOL)wasRefunded {
  return self.refundedDate != nil;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUOrder [balance=%@, bundleClosedDate=%@, bundleDescriptor=%@, contribution=%@, contributionTargetName=%@, createdDate=%@, credit=%@, earn=%@, locationExtendedAddress=%@, locationID=%@, locationLocality=%@, locationPostalCode=%@, locationRegion=%@, locationStreetAddress=%@, merchantID=%@, merchantName=%@, refundedDate=%@, spend=%@, tip=%@, total=%@, transactedDate=%@, UUID=%@]",
          self.balance, self.bundleClosedDate, self.bundleDescriptor, self.contribution, self.contributionTargetName,
          self.createdDate, self.credit, self.earn, self.locationExtendedAddress, self.locationID, self.locationLocality,
          self.locationPostalCode, self.locationRegion, self.locationStreetAddress, self.merchantID, self.merchantName,
          self.refundedDate, self.spend, self.tip, self.total, self.transactedDate, self.UUID];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrder [merchantName=%@, total=%@, UUID=%@]", self.merchantName, self.total,
          self.UUID];
}

@end
