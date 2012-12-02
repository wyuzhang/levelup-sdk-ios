#import "BraintreeEncryption.h"
#import "LUBraintreePublicKey.h"
#import "LUCreditCard.h"
#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"

@implementation LUCreditCard

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"credit_card"];
  }
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)displayNumber {
  return [@"*" stringByAppendingString:self.last_4];
}

- (NSDictionary *)parameters {
  BraintreeEncryption *braintree = [[BraintreeEncryption alloc] initWithPublicKey:BRAINTREE_PUBLIC_ENCRYPTION_KEY];

  return @{
    @"cvv" : [braintree encryptString:self.cvv],
    @"expiration_month" : [braintree encryptString:[self.expirationMonth stringValue]],
    @"expiration_year" : [braintree encryptString:[self.expirationYear stringValue]],
    @"number" : [braintree encryptString:self.number],
    @"postal_code" : [braintree encryptString:self.postalCode]
  };
}

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

- (BOOL)isPromoted {
  return [self.promoted boolValue];
}

@end
