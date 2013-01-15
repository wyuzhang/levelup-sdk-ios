#import "LUCreditCard.h"

@implementation LUCreditCard

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

@end
