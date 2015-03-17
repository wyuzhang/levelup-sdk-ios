/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <UIKit/UIKit.h>

@protocol LUOAuth2ViewControllerDelegate;

/**
 `LUOAuth2ViewController` allows you to request authorization from LevelUp users using the [OAuth2
 protocol] [1].

 `LUOAuth2ViewController` just contains a `UIWebView`. If you would like to display the view inside
 a dialog with a navigation bar and Cancel button, use `navigationDialog`.

 [1]: http://developer.thelevelup.com/resources-and-guides/mobile-authorization-flow/
 */
@interface LUOAuth2ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, assign, readonly) int csrfToken;
@property (nonatomic, weak) id<LUOAuth2ViewControllerDelegate> delegate;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSArray *permissions;
@property (nonatomic, strong, readonly) UIWebView *webView;

/**
 Initializes a `LUOAuth2ViewController`.

 @param delegate A `LUOAuth2ViewControllerDelegate` which will be notified of changes of state.
 @param email The email address of the authorizing user (required).
 @param permission An array of permissions to authorize. See LUConstants.h for a list of possible
 permissions (required).
 */
- (instancetype)initWithDelegate:(id<LUOAuth2ViewControllerDelegate>)delegate
                           email:(NSString *)email
                     permissions:(NSArray *)permissions;

/**
 Returns a UINavigationController containing this view controller. The navigation controller has
 a title and a Cancel button.

 When the Cancel button is selected, the delegate's `OAuth2ViewControllerWasCancelled:` method will
 be called (if defined).
 */
- (UINavigationController *)navigationDialog;

@end

/**
 The `LUOAuth2ViewControllerDelegate` is used with `LUOAuth2ViewController` to notify you when an
 action occurs.
 */
@protocol LUOAuth2ViewControllerDelegate <NSObject>

@required

/**
 Called if the server returned an error.

 @param OAuth2ViewController The OAuth2 controller that received the error.
 @param errorCode An error code of the form "invalid_scope".
 @param errorDescription A human-reable error message.
 */
- (void)OAuth2ViewController:(LUOAuth2ViewController *)OAuth2ViewController
        didFailWithErrorCode:(NSString *)errorCode
            errorDescription:(NSString *)errorDescription;

/**
 Called when authorization is successful.

 @param OAuth2ViewController The OAuth2 controller that was authorizing the user.
 @param accessToken An access token for the authorizing user. Setting `accessToken` on
 `[LUAPIClient sharedClient]` to this token will allow the access token to be used on subsequent
 LevelUp API calls.
 */
- (void)OAuth2ViewController:(LUOAuth2ViewController *)OAuth2ViewController
   didSucceedWithAccessToken:(NSString *)accessToken;

@optional

/**
 An optional method which is called when the web view finishing loading a page. This could be used
 to hide a loading indicator, for example.

 @param OAuth2ViewController The OAuth2 controller that is authorizing the user.
 */
- (void)OAuth2ViewControllerDidFinishLoad:(LUOAuth2ViewController *)OAuth2ViewController;

/**
 An optional method which is called when the web view starts loading a page. This could be used
 to show a loading indicator, for example.

 @param OAuth2ViewController The OAuth2 controller that is authorizing the user.
 */
- (void)OAuth2ViewControllerDidStartLoad:(LUOAuth2ViewController *)OAuth2ViewController;

/**
 An optional method which is called when the user cancels the dialog, if it was displayed inside
 a navigation controller, such as the one returned by `navigationDialog`. Typically this would be
 the time when the controller should be dismissed.

 @param OAuth2ViewController The OAuth2 controller that is authorizing the user.
 */
- (void)OAuth2ViewControllerWasCancelled:(LUOAuth2ViewController *)OAuth2ViewController;

@end
