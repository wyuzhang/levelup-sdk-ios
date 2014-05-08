// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUConstants.h"
#import "LUDeepLinkAuthInstallAlert.h"

@interface LUDeepLinkAuthInstallAlert ()

@property (nonatomic, strong) LUDeepLinkAuthInstallAlert *strongSelfReference;

@end

@implementation LUDeepLinkAuthInstallAlert

#pragma mark - Object Lifecycle Methods

- (id)init {
  self = [super init];
  if (!self) return nil;

  _alertView = [[UIAlertView alloc] initWithTitle:[LUAPIClient sharedClient].deepLinkAuthInstallTitle
                                          message:[LUAPIClient sharedClient].deepLinkAuthInstallMessage
                                         delegate:self
                                cancelButtonTitle:[LUAPIClient sharedClient].deepLinkAuthInstallNegativeButtonTitle
                                otherButtonTitles:[LUAPIClient sharedClient].deepLinkAuthInstallPositiveButtonTitle, nil];

  return self;
}

- (void)dealloc {
  _alertView.delegate = nil;
}

#pragma mark - Public Methods

+ (BOOL)shouldShowForError:(NSError *)error {
  return error.code == LUDeepLinkAuthErrorAppNotInstalled && [LUAPIClient sharedClient].deepLinkAuthShowInstallAlert;
}

+ (void)showAlert {
  [[[self alloc] init] show];
}

- (void)show {
  self.strongSelfReference = self;
  [self.alertView show];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  self.strongSelfReference = nil;

  if (buttonIndex == alertView.cancelButtonIndex) return;

  [[UIApplication sharedApplication] openURL:[LUAPIClient sharedClient].deepLinkAuthInstallAppStoreURL];
}

@end
