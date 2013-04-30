#import "LUAPIClient.h"
#import "LUAPIErrorBuilder.h"

@implementation LUAPIErrorBuilder

+ (NSError *)error:(NSError *)error withMessagesFromJSON:(id)JSON {
  NSMutableDictionary *userInfo = [error.userInfo mutableCopy];

  if (JSON) {
    userInfo[LUAPIFailingJSONResponseErrorKey] = JSON;

    if ([JSON isKindOfClass:[NSDictionary class]]) {
      NSDictionary *responseDict = (NSDictionary *)JSON;

      if (responseDict[@"error_description"]) {
        userInfo[LUAPIFailingErrorMessageErrorKey] = responseDict[@"error_description"];
      } else if(responseDict[@"error"]) {
        userInfo[LUAPIFailingErrorMessageErrorKey] = responseDict[@"error"];
      }
    }
  }

  return [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
}

@end
