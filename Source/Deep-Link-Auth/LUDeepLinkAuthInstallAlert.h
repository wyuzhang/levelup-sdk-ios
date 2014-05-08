// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface LUDeepLinkAuthInstallAlert : NSObject <UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alertView;

+ (BOOL)shouldShowForError:(NSError *)error;
+ (void)showAlert;
- (void)show;

@end
