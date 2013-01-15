#import "LUAPIModel.h"

@interface LUCause : LUAPIModel

@property (nonatomic, copy) NSString *descriptionHtml;
@property (nonatomic, copy) NSNumber *employerRequired;
@property (nonatomic, copy) NSString *facebookUrl;
@property (nonatomic, copy) NSNumber *featured;
@property (nonatomic, copy) NSNumber *homeAddressRequired;
@property (nonatomic, copy) NSString *imageUrl_320x212_1x;
@property (nonatomic, copy) NSString *imageUrl_320x212_2x;
@property (nonatomic, copy) NSNumber *minimumAgeRequired;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *partnerSpecificTerms;
@property (nonatomic, copy) NSString *twitterUsername;
@property (nonatomic, copy) NSString *website;

- (BOOL)anyUserRequirements;
- (BOOL)hasPartnerSpecificTerms;
- (BOOL)isEmployerRequired;
- (BOOL)isFeatured;
- (NSString *)imageUrl;
- (BOOL)isHomeAddressRequired;
- (BOOL)isMinimumAgeRequired;
- (NSString *)searchNormalizedName;
- (NSString *)twitterUrl;

@end
