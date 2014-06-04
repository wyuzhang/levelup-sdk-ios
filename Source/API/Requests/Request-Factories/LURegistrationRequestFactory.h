// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

@interface LURegistrationRequestFactory : NSObject

+ (LUAPIRequest *)requestForRegistrationWithEmail:(NSString *)email;

@end
