#import "LUCause.h"
#import "LUCauseAffiliation.h"
#import "LUCauseAffiliationJSONFactory.h"
#import "LUCauseJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCauseAffiliationJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *causeID = [attributes lu_numberForKey:@"cause_id"];
  NSNumber *percentDonation = [attributes lu_numberForKey:@"percent_donation"];

  return [[LUCauseAffiliation alloc] initWithCauseID:causeID percentDonation:percentDonation];
}

- (NSString *)rootKey {
  return @"cause_affiliation";
}

@end
