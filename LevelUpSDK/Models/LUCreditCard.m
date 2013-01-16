#import "BraintreeEncryption.h"
#import "LUAPIClient.h"
#import "LUConstants.h"
#import "LUCreditCard.h"
#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"

@implementation LUCreditCard

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"credit_card"];
  }
}

#pragma mark - Public Methods

+ (LUCreditCard *)promotedCardFromCards:(NSArray *)cards {
  LUCreditCard *promotedCard = nil;

  for (LUCreditCard *card in cards) {
    if ([card isPromoted]) {
      promotedCard = card;
      break;
    }
  }

  return promotedCard;
}

- (NSString *)displayNumber {
  if (self.last_4) {
    return [@"*" stringByAppendingString:self.last_4];
  } else {
    return nil;
  }
}

- (BOOL)isPromoted {
  return [self.promoted boolValue];
}

- (NSDictionary *)parameters {
  NSString *braintreePublicKey;
  if ([LUAPIClient sharedClient].developmentMode) {
    braintreePublicKey = BraintreePublicKeyDevelopment;
  } else {
    braintreePublicKey = BraintreePublicKeyProduction;
  }

  BraintreeEncryption *braintree = [[BraintreeEncryption alloc] initWithPublicKey:braintreePublicKey];
  return @{
    @"cvv" : [braintree encryptString:self.cvv],
    @"expiration_month" : [braintree encryptString:[self.expirationMonth stringValue]],
    @"expiration_year" : [braintree encryptString:[self.expirationYear stringValue]],
    @"number" : [braintree encryptString:self.number],
    @"postal_code" : [braintree encryptString:self.postalCode]
  };
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.cvv) {
    total += [self.cvv hash] * 11;
  }
  if (self.description) {
    total += [self.description hash] * 13;
  }
  if (self.expirationMonth) {
    total += [self.expirationMonth intValue] * 17;
  }
  if (self.expirationYear) {
    total += [self.expirationYear intValue] * 19;
  }
  if (self.last_4) {
    total += [self.last_4 hash] * 23;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 29;
  }
  if (self.number) {
    total += [self.number hash] * 31;
  }
  if (self.postalCode) {
    total += [self.postalCode hash] * 37;
  }
  if (self.promoted) {
    total += [self.promoted intValue] * 41;
  }
  if (self.type) {
    total += [self.type hash] * 43;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUCreditCard class]]) {
    LUCreditCard *otherCreditCard = (LUCreditCard *)otherObject;

    BOOL cvvEqual = ((!otherCreditCard.cvv && !self.cvv) ||
        (otherCreditCard.cvv && self.cvv &&
        [otherCreditCard.cvv isEqualToString:self.cvv]));

    BOOL descriptionEqual = ((!otherCreditCard.description && !self.description) ||
        (otherCreditCard.description && self.description &&
        [otherCreditCard.description isEqualToString:self.description]));

    BOOL expirationMonthEqual = ((!otherCreditCard.expirationMonth && !self.expirationMonth) ||
        (otherCreditCard.expirationMonth && self.expirationMonth &&
        [otherCreditCard.expirationMonth intValue] == [self.expirationMonth intValue]));

    BOOL expirationYearEqual = ((!otherCreditCard.expirationYear && !self.expirationYear) ||
        (otherCreditCard.expirationYear && self.expirationYear &&
        [otherCreditCard.expirationYear intValue] == [self.expirationYear intValue]));

    BOOL last_4Equal = ((!otherCreditCard.last_4 && !self.last_4) ||
        (otherCreditCard.last_4 && self.last_4 &&
        [otherCreditCard.last_4 isEqualToString:self.last_4]));

    BOOL modelIdEqual = ((!otherCreditCard.modelId && !self.modelId) ||
        (otherCreditCard.modelId && self.modelId &&
        [otherCreditCard.modelId intValue] == [self.modelId intValue]));

    BOOL numberEqual = ((!otherCreditCard.number && !self.number) ||
        (otherCreditCard.number && self.number &&
        [otherCreditCard.number isEqualToString:self.number]));

    BOOL postalCodeEqual = ((!otherCreditCard.postalCode && !self.postalCode) ||
        (otherCreditCard.postalCode && self.postalCode &&
        [otherCreditCard.postalCode isEqualToString:self.postalCode]));

    BOOL promotedEqual = ((!otherCreditCard.promoted && !self.promoted) ||
        (otherCreditCard.promoted && self.promoted &&
        [otherCreditCard.promoted intValue] == [self.promoted intValue]));

    BOOL typeEqual = ((!otherCreditCard.type && !self.type) ||
        (otherCreditCard.type && self.type &&
        [otherCreditCard.type isEqualToString:self.type]));

    return cvvEqual && descriptionEqual && expirationMonthEqual &&
        expirationYearEqual && last_4Equal && modelIdEqual && numberEqual &&
        postalCodeEqual && promotedEqual && typeEqual;
  }

  return NO;
}

@end
