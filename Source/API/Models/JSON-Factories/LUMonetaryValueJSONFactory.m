#import "LUMonetaryValue.h"
#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUMonetaryValueJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *amount = [attributes numberForKey:@"amount"];
  NSString *currencyCode = [attributes stringForKey:@"currency_code"];
  NSString *currencySymbol = [attributes stringForKey:@"currency_symbol"];
  NSString *formattedAmount = [attributes stringForKey:@"formatted_amount"];

  return [[LUMonetaryValue alloc] initWithAmount:amount currencyCode:currencyCode
                                  currencySymbol:currencySymbol formattedAmount:formattedAmount];
}

@end
