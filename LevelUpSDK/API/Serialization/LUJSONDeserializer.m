#import "LUAPIClient.h"
#import "LUApnDevice.h"
#import "LUBundle.h"
#import "LUCampaign.h"
#import "LUCategory.h"
#import "LUCause.h"
#import "LUCauseCategory.h"
#import "LUClaim.h"
#import "LUCohort.h"
#import "LUCreditCard.h"
#import "LUDivision.h"
#import "LUDonation.h"
#import "LUInterstitialAction.h"
#import "LUJSONDeserializer.h"
#import "LULocation.h"
#import "LULoyalty.h"
#import "LUMerchandiseOrder.h"
#import "LUMerchant.h"
#import "LUMonetaryValue.h"
#import "LUOAuthToken.h"
#import "LUOrder.h"
#import "LUQRCode.h"
#import "LURefund.h"
#import "LUTicket.h"
#import "LUUser.h"
#import "LUUserAddress.h"
#import "NSArray+ObjectAccess.h"

@implementation LUJSONDeserializer

#pragma mark - Public Methods

+ (id)deserializeJSON:(id)JSON {
  if ([JSON isKindOfClass:[NSArray class]]) {
    return [self parseArray:JSON];
  } else if ([JSON isKindOfClass:[NSDictionary class]]) {
    return [self parseDictionary:JSON];
  } else if (![JSON isEqual:[NSNull null]]) {
    return JSON;
  } else {
    return nil;
  }
}

#pragma mark - Private Methods

+ (id)parseArray:(NSArray *)array {
  NSMutableArray *parsed = [NSMutableArray array];
  for (id subJSON in array) {
    [parsed addObject:[self deserializeJSON:subJSON]];
  }

  return parsed;
}

+ (id)parseDictionary:(NSDictionary *)dictionary {
  NSMutableDictionary *parsedValues = [NSMutableDictionary dictionary];

  for (NSString *key in [dictionary allKeys]) {
    parsedValues[key] = [self parseProperties:dictionary[key] intoModel:key];
  }

  if (parsedValues.count == 1) {
    return [[parsedValues allValues] firstObject];
  } else {
    return parsedValues;
  }
}

+ (id)parseProperties:(NSDictionary *)properties intoModel:(NSString *)modelName {
  if (![self registeredModels][modelName]) {
    return properties;
  }

  Class modelClass = [self registeredModels][modelName];
  id model = [[modelClass alloc] init];

  for (NSString *propertyName in properties) {
    id propertyValue = properties[propertyName];

    NSString *propertyNameForModel = [self propertyNameForModel:propertyName];

    if ([model respondsToSelector:NSSelectorFromString(propertyNameForModel)]) {
      id propertyValueForModel;
      if ([propertyValue isKindOfClass:[NSDictionary class]]) {
        propertyValueForModel = [self deserializeJSON:@{propertyName : propertyValue}];
      } else {
        propertyValueForModel = [self deserializeJSON:propertyValue];
      }

      [model setValue:propertyValueForModel forKey:propertyNameForModel];
    }
  }

  return model;
}

+ (NSString *)propertyNameForModel:(NSString *)string {
  if ([string isEqualToString:@"id"]) {
    // Special case since objects can't have properties called "id"
    return @"modelId";
  }

  NSArray *components = [string componentsSeparatedByString:@"_"];
  NSMutableString *output = [NSMutableString string];

  for (NSUInteger i = 0; i < components.count; i++) {
    if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[components[i] characterAtIndex:0]]) {
      [output appendFormat:@"_%@", components[i]];
    } else if (i == 0) {
      [output appendString:components[i]];
    } else {
      [output appendString:[components[i] capitalizedString]];
    }
  }

  return [NSString stringWithString:output];
}

#pragma mark - Private Methods

static NSDictionary *_registeredModels = nil;

+ (NSDictionary *)registeredModels {
  if (!_registeredModels) {
    _registeredModels = @{
      @"amount" : [LUMonetaryValue class],
      @"apn_device" : [LUApnDevice class],
      @"balance" : [LUMonetaryValue class],
      @"bundle" : [LUBundle class],
      @"campaign" : [LUCampaign class],
      @"cause" : [LUCause class],
      @"cause_category" : [LUCauseCategory class],
      @"claim" : [LUClaim class],
      @"cohort" : [LUCohort class],
      @"credit" : [LUMonetaryValue class],
      @"credit_card" : [LUCreditCard class],
      @"division" : [LUDivision class],
      @"donation" : [LUDonation class],
      @"earn" : [LUMonetaryValue class],
      @"email_capture_cohort" : [LUCohort class],
      @"interstitial_action" : [LUInterstitialAction class],
      @"location" : [LULocation class],
      @"loyalty" : [LULoyalty class],
      @"loyalties_savings" : [LUMonetaryValue class],
      @"onboarding" : [LUMonetaryValue class],
      @"merchandise_order" : [LUMerchandiseOrder class],
      @"merchant" : [LUMerchant class],
      @"oauth_token" : [LUOAuthToken class],
      @"onboarding" : [LUMonetaryValue class],
      @"order" : [LUOrder class],
      @"potential_credit": [LUMonetaryValue class],
      @"qr_code" : [LUQRCode class],
      @"refund" : [LURefund class],
      @"savings": [LUMonetaryValue class],
      @"share_cohort" : [LUCohort class],
      @"should_spend": [LUMonetaryValue class],
      @"spend": [LUMonetaryValue class],
      @"spend_remaining": [LUMonetaryValue class],
      @"ticket" : [LUTicket class],
      @"tip": [LUMonetaryValue class],
      @"total": [LUMonetaryValue class],
      @"total_credit_used": [LUMonetaryValue class],
      @"total_volume": [LUMonetaryValue class],
      @"user" : [LUUser class],
      @"user_address" : [LUUserAddress class],
      @"value": [LUMonetaryValue class],
      @"will_earn": [LUMonetaryValue class]
    };
  }

  return _registeredModels;
}

@end
