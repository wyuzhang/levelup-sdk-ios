#import "LUCampaign.h"
#import "LUCampaignJSONFactory.h"
#import "LUMonetaryValue.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCampaignJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *campaignID = [attributes lu_numberForKey:@"id"];
  NSString *confirmationHTML = [attributes lu_stringForKey:@"confirmation_html"];
  BOOL global = [attributes lu_boolForKey:@"applies_to_all_merchants"];
  NSString *messageForEmailBody = [attributes lu_stringForKey:@"message_for_email_body"];
  NSString *messageForEmailSubject = [attributes lu_stringForKey:@"message_for_email_subject"];
  NSString *messageForFacebook = [attributes lu_stringForKey:@"message_for_facebook"];
  NSString *messageForTwitter = [attributes lu_stringForKey:@"message_for_twitter"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  NSString *offerHTML = [attributes lu_stringForKey:@"offer_html"];
  BOOL shareable = [attributes lu_boolForKey:@"shareable"];
  NSURL *shareURLEmail = [attributes lu_URLForKey:@"share_url_email"];
  NSURL *shareURLFacebook = [attributes lu_URLForKey:@"share_url_facebook"];
  NSURL *shareURLTwitter = [attributes lu_URLForKey:@"share_url_twitter"];
  NSString *sponsor = [attributes lu_stringForKey:@"sponsor"];
  LUMonetaryValue *value = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"value_amount"]];

  return [[LUCampaign alloc] initWithCampaignID:campaignID confirmationHTML:confirmationHTML global:global
                            messageForEmailBody:messageForEmailBody messageForEmailSubject:messageForEmailSubject
                             messageForFacebook:messageForFacebook messageForTwitter:messageForTwitter name:name
                                      offerHTML:offerHTML shareable:shareable shareURLEmail:shareURLEmail
                                          shareURLFacebook:shareURLFacebook shareURLTwitter:shareURLTwitter
                                        sponsor:sponsor value:value];
}

- (NSString *)rootKey {
  return @"campaign";
}

@end
