#import "LUInterstitialShareAction.h"

@implementation LUInterstitialShareAction

#pragma mark - Creation

- (id)initWithMessageForEmailBody:(NSString *)messageForEmailBody
           messageForEmailSubject:(NSString *)messageForEmailSubject messageForFacebook:(NSString *)messageForFacebook
                messageForTwitter:(NSString *)messageForTwitter shareURLEmail:(NSURL *)shareURLEmail
                 shareURLFacebook:(NSURL *)shareURLFacebook shareURLTwitter:(NSURL *)shareURLTwitter {
  self = [super init];
  if (!self) return nil;

  _messageForEmailBody = messageForEmailBody;
  _messageForEmailSubject = messageForEmailSubject;
  _messageForFacebook = messageForFacebook;
  _messageForTwitter = messageForTwitter;
  _shareURLEmail = shareURLEmail;
  _shareURLFacebook = shareURLFacebook;
  _shareURLTwitter = shareURLTwitter;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUInterstitialShareAction [messageForEmailBody=%@, messageForEmailSubject=%@, messageForFacebook=%@, messageForTwitter=%@, shareURLEmail=%@, shareURLFacebook=%@, shareURLTwitter=%@]",
          self.messageForEmailBody, self.messageForEmailSubject, self.messageForFacebook, self.messageForTwitter,
          self.shareURLEmail, self.shareURLFacebook, self.shareURLTwitter];
}

@end
