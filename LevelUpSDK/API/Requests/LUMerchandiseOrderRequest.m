#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUMerchandiseOrder.h"
#import "LUMerchandiseOrderRequest.h"
#import "LUParameterSerializer.h"

@implementation LUMerchandiseOrderRequest

+ (LUAPIRequest *)createMerchandiseOrder:(LUMerchandiseOrder *)merchandiseOrder {
  NSString *path = [NSString stringWithFormat:@"users/%@/merchandise_orders", [LUAPIClient sharedClient].currentUserId];

  NSDictionary *parameters = [LUParameterSerializer parametersForModel:merchandiseOrder attributes:@[@"address", @"firstName", @"lastName", @"locality", @"region", @"unit", @"zip"]];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"merchandise_order" : parameters}];
}

@end
