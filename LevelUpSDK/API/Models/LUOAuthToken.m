#import "LUAPIClient.h"
#import "LUDeviceIdentifier.h"
#import "LUOAuthToken.h"

@implementation LUOAuthToken

#pragma mark - Creation Methods

- (id)init {
  self = [super init];
  if (self) {
    self.clientId = [LUAPIClient sharedClient].apiKey;
  }

  return self;
}

#pragma mark - Public Methods

- (NSString *)deviceIdentifier {
  return [LUDeviceIdentifier deviceIdentifier];
}

@end
