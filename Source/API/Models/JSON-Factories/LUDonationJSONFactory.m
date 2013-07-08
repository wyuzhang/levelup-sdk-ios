#import "LUCauseJSONFactory.h"
#import "LUDonation.h"
#import "LUDonationJSONFactory.h"
#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUDonationJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUCause *cause = [[LUCauseJSONFactory factory] fromJSONObject:attributes[@"cause"]];
  NSNumber *donationID = [attributes lu_numberForKey:@"id"];
  LUMonetaryValue *value = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"value"]];

  return [[LUDonation alloc] initWithCause:cause donationID:donationID value:value];
}

- (NSString *)rootKey {
  return @"donation";
}

@end
