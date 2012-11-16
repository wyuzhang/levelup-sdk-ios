#import "LUAPIClient.h"
#import "LUDeviceIdentifier.h"
#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"
#import "LUKeychainAccess.h"
#import "LUOAuthToken.h"

@implementation LUOAuthToken

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"oauth_token"];
  }
}

#pragma mark -
#pragma mark Creation Methods

- (id)init {
  self = [super init];
  if (self) {
    self.clientId = [LUAPIClient sharedClient].levelUpClientId;
  }

  return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)deviceIdentifier {
  return [LUDeviceIdentifier deviceIdentifier];
}

- (NSDictionary *)parameters {
  return [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"clientId", @"deviceIdentifier",
          @"facebookAccessToken", @"grantType", @"password", @"username"]];
}

@end
