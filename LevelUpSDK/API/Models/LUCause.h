#import "LUAPIModel.h"

@interface LUCause : LUAPIModel

@property (nonatomic, copy) NSString *descriptionHtml;
@property (nonatomic, assign) BOOL employerRequired;
@property (nonatomic, copy) NSString *facebookUrl;
@property (nonatomic, assign) BOOL featured;
@property (nonatomic, assign) BOOL homeAddressRequired;
@property (nonatomic, copy) NSNumber *minimumAgeRequired;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *partnerSpecificTerms;
@property (nonatomic, copy) NSString *twitterUsername;
@property (nonatomic, copy) NSString *website;

- (BOOL)anyUserRequirements;
- (BOOL)hasMinimumAgeRequired;
- (BOOL)hasPartnerSpecificTerms;
- (NSString *)imageUrl;
- (NSString *)twitterUrl;

@end
