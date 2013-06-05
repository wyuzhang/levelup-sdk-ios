#import "LUAccessToken+FakeInstance.h"

@implementation LUAccessToken (FakeInstance)

+ (LUAccessToken *)fakeInstance {
  return [[LUAccessToken alloc] initWithToken:@"token" userID:@1];
}

@end
