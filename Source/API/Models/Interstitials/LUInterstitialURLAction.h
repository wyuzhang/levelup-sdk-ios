#import "LUAPIModel.h"

/**
 This action is for interstitials that request the user click a link.
 */
@interface LUInterstitialURLAction : LUAPIModel

/**
 The URL that the user will be presented with.
 */
@property (nonatomic, copy, readonly) NSURL *URL;

- (id)initWithURL:(NSURL *)URL;

@end
