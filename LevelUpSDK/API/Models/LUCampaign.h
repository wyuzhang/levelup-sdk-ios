#import "LUAPIModel.h"

@class LUCohort;
@class LUMonetaryValue;

@interface LUCampaign : LUAPIModel

@property (nonatomic, assign) BOOL claimed;
@property (nonatomic, strong) LUCohort *cohort;
@property (nonatomic, copy) NSArray *cohorts;
@property (nonatomic, copy) NSString *confirmationHtml;
@property (nonatomic, assign) BOOL global;
@property (nonatomic, copy) NSArray *merchants;
@property (nonatomic, copy) NSString *mobileImageUrl_320x212_1x;
@property (nonatomic, copy) NSString *mobileImageUrl_320x212_2x;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *offerHtml;
@property (nonatomic, copy) NSString *sponsor;
@property (nonatomic, copy) NSString *supportEmail;
@property (nonatomic, strong) LUMonetaryValue *value;

- (NSString *)confirmationText;
- (LUCohort *)emailCohort;
- (LUCohort *)facebookCohort;
- (BOOL)isGlobal;
- (NSString *)mobileImageUrl;
- (NSString *)offerText;
- (NSString *)successfulClaimMessageHtml;
- (NSString *)successfulClaimMessageText;
- (LUCohort *)twitterCohort;

@end
