
#import <CoreLocation/CoreLocation.h>
#import "LUAPIModel.h"

/**
 An `LUMerchant` is a place of business that takes LevelUp for payment. Merchants have one or more physical locations
 where LevelUp is accepted, represented as `LULocation` instances.
 */
@class LUCohort;
@class LULocation;
@class LULoyalty;
@class LUMonetaryValue;

extern NSString * const MerchantWebService;
extern NSString * const MerchantYelpService;
extern NSString * const MerchantFacebookService;
extern NSString * const MerchantTwitterService;
extern NSString * const MerchantScvngrService;
extern NSString * const MerchantOpenTableService;
extern NSString * const MerchantNewsletterService;

@interface LUMerchant : LUAPIModel

/**
 A description of the merchant in HTML format.
 */
@property (nonatomic, copy) NSString *descriptionHtml;

/**
 The amount of money a user can earn in loyalty credit. For example, if a user gets $10 in credit for every $100 they
 spend, `earn` will be $10.
 */
@property (nonatomic, strong) LUMonetaryValue *earn;

/**
 Some merchants may have an associated `LUCampaign` for capturing user's email addresses. If they do,
 `emailCaptureCohort` will contain the cohort that users claim for this campaign. See `LUCampaign` for additional
 discussion.
 */
@property (nonatomic, strong) LUCohort *emailCaptureCohort;

/**
 An optional URL containing a Facebook URL for this merchant.
 */
@property (nonatomic, copy) NSString *facebookUrl;

/**
 Specifies if the merchant is featured. "Featured" merchants are typically given higher visibility to users when they
 view nearby locations.
 */
@property (nonatomic, assign) BOOL featured;

/**
 An array of `LULocation` objects for each of the merchant's locations.
 */
@property (nonatomic, copy) NSArray *locations;

/**
 An `LULoyalty` object for the user. This may be nil is `loyaltyEnabled` is false.
 */
@property (nonatomic, strong) LULoyalty *loyalty;

/**
 A small percent of LevelUp merchants do not provide loyalty rewards. This property specifies if the merchant has
 loyalty enabled.
 */
@property (nonatomic, assign) BOOL loyaltyEnabled;

/**
 The unique identifier for this merchant.
 */
@property (nonatomic, copy) NSNumber *merchantID;

/**
 The merchant's name.
 */
@property (nonatomic, copy) NSString *name;

/**
 An optional newsletter URL for the merchant.
 */
@property (nonatomic, copy) NSString *newsletterUrl;

/**
 An optional OpenTable URL for the merchant.
 */
@property (nonatomic, copy) NSString *opentableUrl;

/**
 A URL on thelevelup.com for this merchant.
 */
@property (nonatomic, copy) NSString *publicUrl;

/**
 An optional SCVNGR URL for the merchant.
 */
@property (nonatomic, copy) NSString *scvngrUrl;

/**
 The amount of money a user spends before receiving credit. For example, if a user gets $10 in credit for every $100
 they spend, `spend` will be $100.
 */
@property (nonatomic, strong) LUMonetaryValue *spend;

/**
 An optional Twitter username for the merchant.
 */
@property (nonatomic, copy) NSString *twitterUsername;

/**
 An optional URL for the merchant's website.
 */
@property (nonatomic, copy) NSString *url;

/**
 An optional Yelp for the merchant.
 */
@property (nonatomic, copy) NSString *yelpUrl;

/**
 If the merchant has loyalty enabled, returns the amount of credit available to the user at this merchant. If loyalty
 is not enabled, returns $0.
 */
- (LUMonetaryValue *)currentCredit;

/**
 An associated image for the merchant. Will automatically return a retina or non-retina scaled image based on the
 screen scale of the device.
 */
- (NSString *)imageUrl;

/**
 Returns the merchant's `LULocation` closest to the given location.

 @param location A `CLLocation` for the search.
 */
- (LULocation *)locationNearestTo:(CLLocation *)location;

/**
 A Twitter URL for the merchant, using their `twitterUsername`.
 */
- (NSString *)twitterUrl;

/**
 This method provides a helpful way to access all URLs provided by this merchant. This method returns an array of hashes,
 with one hash for each URL. Only non-blank URLs are returned.

 @return An array of hashes, each with three keys: `@"service"`, `@"url"`, and `@"displayName"`. The first, `@"service"`,
 is one of the following:

 - MerchantWebService
 - MerchantYelpService
 - MerchantFacebookService
 - MerchantTwitterService
 - MerchantScvngrService
 - MerchantOpenTableService
 - MerchantNewsletterService

 The second key in the hash is `@"url"`, which is the URL in question. The last key is `@"displayName"`, which is a
 title that can be used for the service, such as "Facebook" or "Newsletter".

 Here is an example:
     [
       @{@"service" : MerchantWebService, @"url" : @"https://thelevelup.com", @"displayName" : @"Website Menu"},
       @{@"service" : MerchantTwitterService, @"url" : @"http://twitter.com/TheLevelUp", @"displayName" : @"Twitter"},
       @{@"service" : MerchantFacebookService, @"url" : @"http://facebook.com/TheLevelUp", @"displayName" : @"Facebook"}
     ]
 */
- (NSArray *)webLocations;

@end
