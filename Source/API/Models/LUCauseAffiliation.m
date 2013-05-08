#import "LUCause.h"
#import "LUCauseAffiliation.h"

@implementation LUCauseAffiliation

#pragma mark - Creation

- (id)initWithCauseID:(NSNumber *)causeID
      percentDonation:(NSNumber *)percentDonation {
  self = [super init];
  if (!self) return nil;

  _causeID = causeID;
  _percentDonation = percentDonation;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:
          @"LUCauseAffiliation [Cause ID=%@, percentDonation=%@]",self.causeID, self.percentDonation];
}

@end
