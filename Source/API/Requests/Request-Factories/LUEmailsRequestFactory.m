#import "LUAuthenticatedAPIRequest.h"
#import "LUEmailsRequestFactory.h"

@implementation LUEmailsRequestFactory

+ (LUAPIRequest *)requestToSendEmailWithID:(NSNumber *)emailID {
  NSString *path = [NSString stringWithFormat:@"emails/%@/send", [emailID stringValue]];

  return [[LUAuthenticatedAPIRequest alloc] initWithMethod:@"POST"
                                                      path:path
                                                apiVersion:LUAPIVersion13
                                                parameters:nil
                                              modelFactory:nil];
}

@end
