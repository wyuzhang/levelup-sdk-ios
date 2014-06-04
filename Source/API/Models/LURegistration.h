// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

@interface LURegistration : LUAPIModel

@property (nonatomic, copy, readonly) NSString *appName;
@property (nonatomic, assign, readonly) BOOL facebook;
@property (nonatomic, copy, readonly) NSString *registrationDescription;

- (id)initWithAppName:(NSString *)appName facebook:(BOOL)facebook registrationDescription:(NSString *)registrationDescription;

@end
