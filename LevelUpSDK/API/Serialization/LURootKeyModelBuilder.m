#import "LUBundleModelBuilder.h"
#import "LUCampaignModelBuilder.h"
#import "LUCategoryModelBuilder.h"
#import "LUCauseCategoryModelBuilder.h"
#import "LUCauseModelBuilder.h"
#import "LUClaimModelBuilder.h"
#import "LUCohortModelBuilder.h"
#import "LUCreditCardModelBuilder.h"
#import "LUMerchantModelBuilder.h"
#import "LUOrderModelBuilder.h"
#import "LURootKeyModelBuilder.h"
#import "LUUserModelBuilder.h"
#import "NSArray+ObjectAccess.h"

@implementation LURootKeyModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  NSMutableDictionary *models = [NSMutableDictionary dictionary];

  for (NSString *modelKey in attributes) {
    LUAPIModelBuilder *builder;

    if ([modelKey isEqualToString:@"bundle"]) {
      builder = [LUBundleModelBuilder builder];
    } else if ([modelKey isEqualToString:@"campaign"]) {
      builder = [LUCampaignModelBuilder builder];
    } else if ([modelKey isEqualToString:@"category"]) {
      builder = [LUCategoryModelBuilder builder];
    } else if ([modelKey isEqualToString:@"cause"]) {
      builder = [LUCauseModelBuilder builder];
    } else if ([modelKey isEqualToString:@"cause_category"]) {
      builder = [LUCauseCategoryModelBuilder builder];
    } else if ([modelKey isEqualToString:@"claim"]) {
      builder = [LUClaimModelBuilder builder];
    } else if ([modelKey isEqualToString:@"cohort"]) {
      builder = [LUCohortModelBuilder builder];
    } else if ([modelKey isEqualToString:@"credit_card"]) {
      builder = [LUCreditCardModelBuilder builder];
    } else if ([modelKey isEqualToString:@"merchant"]) {
      builder = [LUMerchantModelBuilder builder];
    } else if ([modelKey isEqualToString:@"order"]) {
      builder = [LUOrderModelBuilder builder];
    } else if ([modelKey isEqualToString:@"user"]) {
      builder = [LUUserModelBuilder builder];
    }

    if (builder) {
      models[modelKey] = [builder buildModelFromJSON:attributes[modelKey]];
    } else {
      models[modelKey] = attributes[modelKey];
    }
  }

  if ([models count] == 1) {
    return [[models allValues] firstObject];
  } else {
    return models;
  }
}

@end
