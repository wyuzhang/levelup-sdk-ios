#import "LUAPIClient.h"
#import "LUDeepLinkAuthInstallAlert.h"

SPEC_BEGIN(LUDeepLinkAuthInstallAlertSpec)

describe(@"LUDeepLinkAuthInstallAlert", ^{
  __block LUDeepLinkAuthInstallAlert *alert;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    alert = [[LUDeepLinkAuthInstallAlert alloc] init];
  });

  // Object Lifecycle Methods

  describe(@"init", ^{
    it(@"creates an alert view", ^{
      [[alert.alertView shouldNot] beNil];
    });

    it(@"sets the alert view's delegate to itself", ^{
      [[alert.alertView.delegate should] equal:alert];
    });

    it(@"sets the alert's properties to those configured in LUAPIClient", ^{
      LUAPIClient *client = [LUAPIClient sharedClient];
      [[alert.alertView.title should] equal:client.deepLinkAuthInstallTitle];
      [[alert.alertView.message should] equal:client.deepLinkAuthInstallMessage];
      [[[alert.alertView buttonTitleAtIndex:alert.alertView.cancelButtonIndex] should] equal:client.deepLinkAuthInstallNegativeButtonTitle];
      [[[alert.alertView buttonTitleAtIndex:alert.alertView.firstOtherButtonIndex] should] equal:client.deepLinkAuthInstallPositiveButtonTitle];
    });
  });

  // Public Methods

  describe(@"shouldShowForError:", ^{
    __block NSError *error;

    beforeEach(^{
      error = [NSError errorWithDomain:LUDeepLinkAuthErrorDomain
                                  code:LUDeepLinkAuthErrorAppNotInstalled
                              userInfo:nil];
      [LUAPIClient sharedClient].deepLinkAuthShowInstallAlert = YES;
    });

    context(@"when the error code is not LUDeepLinkAuthErrorAppNotInstalled", ^{
      beforeEach(^{
        error = [NSError errorWithDomain:LUDeepLinkAuthErrorDomain
                                    code:LUDeepLinkAuthErrorRequestRejected
                                userInfo:nil];
      });

      it(@"is NO", ^{
        [[theValue([LUDeepLinkAuthInstallAlert shouldShowForError:error]) should] beNo];
      });
    });

    context(@"when deepLinkAuthShowInstallAlert is NO", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].deepLinkAuthShowInstallAlert = NO;
      });

      it(@"is NO", ^{
        [[theValue([LUDeepLinkAuthInstallAlert shouldShowForError:error]) should] beNo];
      });
    });

    context(@"when the error code is LUDeepLinkAuthErrorAppNotInstalled and deepLinkAuthShowInstallAlert is YES", ^{
      it(@"is YES", ^{
        [[theValue([LUDeepLinkAuthInstallAlert shouldShowForError:error]) should] beYes];
      });
    });
  });

  describe(@"show", ^{
    beforeEach(^{
      [alert.alertView stub:@selector(show)];
    });

    it(@"shows the alert", ^{
      [[alert.alertView should] receive:@selector(show)];

      [alert show];
    });

    it(@"prevents itself from being released while the alert is showing", ^{
      __weak LUDeepLinkAuthInstallAlert *weakAlert = alert;

      [alert show];
      alert = nil;

      [[weakAlert shouldNot] beNil];
    });
  });

  // UIAlertViewDelegate Methods

  describe(@"alertView:clickedButtonAtIndex:", ^{
    beforeEach(^{
      [UIApplication stub:@selector(sharedApplication) andReturn:[UIApplication mock]];
    });

    context(@"when the alert has been shown", ^{
      beforeEach(^{
        [alert.alertView stub:@selector(show)];
        [alert show];
      });

      context(@"when the cancel button is clicked", ^{
        it(@"doesn't open a URL", ^{
          [[[UIApplication sharedApplication] shouldNot] receive:@selector(openURL:)];

          [alert alertView:alert.alertView clickedButtonAtIndex:alert.alertView.cancelButtonIndex];
        });
      });

      context(@"when the other button is clicked", ^{
        it(@"opens a URL to the App Store", ^{
          [[[UIApplication sharedApplication] should] receive:@selector(openURL:)
                                                withArguments:[LUAPIClient sharedClient].deepLinkAuthInstallAppStoreURL];

          [alert alertView:alert.alertView clickedButtonAtIndex:alert.alertView.firstOtherButtonIndex];
        });
      });

      it(@"allows itself to be released", ^{
        __weak LUDeepLinkAuthInstallAlert *weakAlert = alert;

        [alert alertView:alert.alertView clickedButtonAtIndex:alert.alertView.cancelButtonIndex];
        alert = nil;

        [[weakAlert should] beNil];
      });
    });
  });
});

SPEC_END
