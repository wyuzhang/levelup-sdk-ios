#import "LUAPIClient.h"
#import "LUInterstitial.h"
#import "NSString+HTMLStripping.h"
#import "NSURL+LUAdditions.h"

@implementation LUInterstitial {
  NSURL *_imageURL;
}

#pragma mark - Creation

- (id)initWithAction:(id)action actionType:(LUInterstitialActionType)actionType
     descriptionHTML:(NSString *)descriptionHTML imageURL:(NSURL *)imageURL title:(NSString *)title {
  self = [super init];
  if (!self) return nil;

  _action = action;
  _actionType = actionType;
  _descriptionHTML = descriptionHTML;
  _imageURL = imageURL;
  _title = title;

  return self;
}

#pragma mark - Public Methods

- (NSString *)descriptionText {
  return [self.descriptionHTML lu_stringByStrippingHTML];
}

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForImageWithBase:_imageURL];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUInterstitial [action=%@, actionType=%@, descriptionHTML=%@, imageURL=%@, title=%@]",
          self.action, [self actionTypeString], self.descriptionHTML, self.imageURL, self.title];
}

#pragma mark - Private Methods

- (NSString *)actionTypeString {
  switch (self.actionType) {
    case LUInterstitialActionTypeNone:
      return @"none";

    case LUInterstitialActionTypeClaim:
      return @"claim";

    case LUInterstitialActionTypeShare:
      return @"share";

    case LUInterstitialActionTypeURL:
      return @"url";
  }
}

@end
