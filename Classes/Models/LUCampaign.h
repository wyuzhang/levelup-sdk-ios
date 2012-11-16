#import <Foundation/Foundation.h>

@class LUCohort;
@class LUMonetaryValue;

@interface LUCampaign : NSObject

@property (nonatomic, copy) NSNumber *claimed;
@property (nonatomic, copy) NSArray *cohorts;
@property (nonatomic, copy) NSNumber *global;
@property (nonatomic, copy) NSArray *merchants;
@property (nonatomic, copy) NSString *mobileImageUrl_320x212_1x;
@property (nonatomic, copy) NSString *mobileImageUrl_320x212_2x;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *offerHtml;
@property (nonatomic, copy) NSString *sponsor;
@property (nonatomic, copy) NSString *supportEmail;
@property (nonatomic, strong) LUMonetaryValue *value;

- (NSString *)creditInformation;
- (LUCohort *)emailCohort;
- (LUCohort *)facebookCohort;
- (NSString *)grabString;
- (BOOL)isClaimed;
- (BOOL)isGlobal;
- (NSString *)mobileImageUrl;
- (LUCohort *)twitterCohort;
- (NSString *)unlockedString;

@end
