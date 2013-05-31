#import "LULocation.h"
#import "LULocationV14JSONFactory.h"
#import "LUWebLocations.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationV14JSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSArray *categoryIDs = [attributes arrayForKey:@"categories"];
  NSString *descriptionHTML = [attributes stringForKey:@"description_html"];
  NSString *extendedAddress = [attributes stringForKey:@"extended_address"];
  NSString *hours = [attributes stringForKey:@"hours"];
  NSNumber *latitude = [attributes numberForKey:@"latitude"];
  NSString *locality = [attributes stringForKey:@"locality"];
  NSNumber *locationID = [attributes numberForKey:@"id"];
  NSNumber *longitude = [attributes numberForKey:@"longitude"];
  NSNumber *merchantID = [attributes numberForKey:@"merchant_id"];
  NSString *merchantName = [attributes stringForKey:@"merchant_name"];
  NSString *name = [attributes stringForKey:@"name"];
  NSString *phone = [attributes stringForKey:@"phone"];
  NSString *postalCode = [attributes stringForKey:@"postal_code"];
  NSString *region = [attributes stringForKey:@"region"];
  BOOL shown = [attributes boolForKey:@"shown"];
  NSString *streetAddress = [attributes stringForKey:@"street_address"];
  LUWebLocations *webLocations = [[LUWebLocations alloc] initWithFacebookAddress:[attributes stringForKey:@"facebook_url"]
                                                                     menuAddress:[attributes stringForKey:@"menu_url"]
                                                               newsletterAddress:[attributes stringForKey:@"newsletter_url"]
                                                                opentableAddress:[attributes stringForKey:@"opentable_url"]
                                                                  twitterAddress:[attributes stringForKey:@"twitter_url"]
                                                                     yelpAddress:[attributes stringForKey:@"yelp_url"]];
  NSDate *updatedAtDate = [attributes dateForKey:@"updated_at"];

  return [[LULocation alloc] initWithCategoryIDs:categoryIDs descriptionHTML:descriptionHTML extendedAddress:extendedAddress
                                           hours:hours latitude:latitude locality:locality locationID:locationID longitude:longitude
                                      merchantID:merchantID merchantName:merchantName name:name phone:phone postalCode:postalCode
                                          region:region shown:shown streetAddress:streetAddress updatedAtDate:updatedAtDate
                                    webLocations:webLocations];
}

- (NSString *)rootKey {
  return @"location";
}

@end
