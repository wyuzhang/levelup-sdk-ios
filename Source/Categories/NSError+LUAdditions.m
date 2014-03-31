#import "NSError+LUAdditions.h"

@implementation NSError (LUAdditions)

+ (NSError *)lu_deepLinkAuthErrorWithCode:(LUDeepLinkAuthErrorCode)code description:(NSString *)description {
  return [NSError errorWithDomain:LUDeepLinkAuthErrorDomain
                             code:code
                         userInfo:@{NSLocalizedDescriptionKey: description}];
}

@end
