#import <Foundation/Foundation.h>

@class LUCampaign;

@interface LUCohort : NSObject

@property (nonatomic, strong) LUCampaign *campaign;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *cohortType;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *emailBody;
@property (nonatomic, copy) NSString *messageForEmailSubject;
@property (nonatomic, copy) NSString *messageForTwitter;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *url;

@end
