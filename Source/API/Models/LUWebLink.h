// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

/**
 A `LUWebLink` represents a link associated with a particular location or merchant. A web link will
 always have a web URL (suitable to open in a web view or in Safari), but may also have a deep link
 URL, which links directly into another application.

 When `deepLinkURL` is present, you should first check if the device can open the URL using
 `[NSURL canOpenURL:]`, falling back to `webURL` if the URL cannot be opened.
 */
@interface LUWebLink : LUAPIModel

/**
 An optional deep link URL.
 */
@property (nonatomic, copy, readonly) NSURL *deepLinkURL;

/**
 The title of this link. For example, "Twitter" or "Facebook".
 */
@property (nonatomic, copy, readonly) NSString *title;

/**
 The ID representing the web link type (internal)
 */
@property (nonatomic, copy, readonly) NSNumber *webLinkTypeID;

/**
 The URL of this link.
*/
@property (nonatomic, copy, readonly) NSURL *webURL;

/**
 An associated image for the link, suitable as an icon. Will automatically return a retina or
 non-retina scaled image based on the screen scale of the device. The resolution is 25x25.
 */
- (NSURL *)imageURL;

- (id)initWithDeepLinkURL:(NSURL *)deepLinkURL title:(NSString *)title
            webLinkTypeID:(NSNumber *)webLinkTypeID webURL:(NSURL *)webURL;

@end
