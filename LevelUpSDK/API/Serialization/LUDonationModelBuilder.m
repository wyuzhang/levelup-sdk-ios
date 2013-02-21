#import "LUCauseModelBuilder.h"
#import "LUDonation.h"
#import "LUDonationModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUDonationModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"donation"]) {
    attributes = attributes[@"donation"];
  }

  LUDonation *donation = [[LUDonation alloc] init];
  donation.cause = [[LUCauseModelBuilder builder] buildModelFromJSON:attributes[@"cause"]];
  donation.donationID = [attributes numberForKey:@"id"];
  donation.value = [attributes monetaryValueForKey:@"value"];

  return donation;
}

@end
