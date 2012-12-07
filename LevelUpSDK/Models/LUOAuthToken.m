#import "LUAPIClient.h"
#import "LUDeviceIdentifier.h"
#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"
#import "LUKeychainAccess.h"
#import "LUOAuthToken.h"

@implementation LUOAuthToken

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"oauth_token"];
  }
}

#pragma mark - Creation Methods

- (id)init {
  self = [super init];
  if (self) {
    self.clientId = [LUAPIClient sharedClient].levelUpClientId;
  }

  return self;
}

#pragma mark - Public Methods

- (NSString *)deviceIdentifier {
  return [LUDeviceIdentifier deviceIdentifier];
}

- (NSDictionary *)parameters {
  return [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"clientId", @"deviceIdentifier",
          @"facebookAccessToken", @"grantType", @"password", @"username"]];
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.accessToken) {
    total += [self.accessToken hash] * 11;
  }
  if (self.clientId) {
    total += [self.clientId hash] * 13;
  }
  if (self.facebookAccessToken) {
    total += [self.facebookAccessToken hash] * 17;
  }
  if (self.grantType) {
    total += [self.grantType hash] * 19;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 23;
  }
  if (self.password) {
    total += [self.password hash] * 29;
  }
  if (self.username) {
    total += [self.username hash] * 31;
  }
  if (self.xUserId) {
    total += [self.xUserId intValue] * 37;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUOAuthToken class]]) {
    LUOAuthToken *otherOAuthToken = (LUOAuthToken *)otherObject;

    BOOL accessTokenEqual = ((!otherOAuthToken.accessToken && !self.accessToken) ||
        (otherOAuthToken.accessToken && self.accessToken &&
        [otherOAuthToken.accessToken isEqualToString:self.accessToken]));

    BOOL clientIdEqual = ((!otherOAuthToken.clientId && !self.clientId) ||
        (otherOAuthToken.clientId && self.clientId &&
        [otherOAuthToken.clientId isEqualToString:self.clientId]));

    BOOL facebookAccessTokenEqual = ((!otherOAuthToken.facebookAccessToken && !self.facebookAccessToken) ||
        (otherOAuthToken.facebookAccessToken && self.facebookAccessToken &&
        [otherOAuthToken.facebookAccessToken isEqualToString:self.facebookAccessToken]));

    BOOL grantTypeEqual = ((!otherOAuthToken.grantType && !self.grantType) ||
        (otherOAuthToken.grantType && self.grantType &&
        [otherOAuthToken.grantType isEqualToString:self.grantType]));

    BOOL modelIdEqual = ((!otherOAuthToken.modelId && !self.modelId) ||
        (otherOAuthToken.modelId && self.modelId &&
        [otherOAuthToken.modelId intValue] == [self.modelId intValue]));

    BOOL passwordEqual = ((!otherOAuthToken.password && !self.password) ||
        (otherOAuthToken.password && self.password &&
        [otherOAuthToken.password isEqualToString:self.password]));

    BOOL usernameEqual = ((!otherOAuthToken.username && !self.username) ||
        (otherOAuthToken.username && self.username &&
        [otherOAuthToken.username isEqualToString:self.username]));

    BOOL xUserIdEqual = ((!otherOAuthToken.xUserId && !self.xUserId) ||
        (otherOAuthToken.xUserId && self.xUserId &&
        [otherOAuthToken.xUserId intValue] == [self.xUserId intValue]));

    return accessTokenEqual && clientIdEqual && facebookAccessTokenEqual && grantTypeEqual &&
        modelIdEqual && passwordEqual && usernameEqual && xUserIdEqual;
  }

  return NO;
}

@end
