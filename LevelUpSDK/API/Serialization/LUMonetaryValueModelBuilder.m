#import "LUMonetaryValue.h"
#import "LUMonetaryValueModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUMonetaryValueModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *monetaryValue = [[LUMonetaryValue alloc] init];
  monetaryValue.amount = [attributes numberForKey:@"amount"];
  monetaryValue.currencyCode = [attributes stringForKey:@"currency_code"];
  monetaryValue.currencySymbol = [attributes stringForKey:@"currency_symbol"];
  monetaryValue.formattedAmount = [attributes stringForKey:@"formatted_amount"];

  return monetaryValue;
}

@end
