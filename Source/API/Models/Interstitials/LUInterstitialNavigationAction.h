/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUAPIModel.h"

/**
 This action is for interstitials that request the user navigate to another screen in the app.
 */
@interface LUInterstitialNavigationAction : LUAPIModel

/**
 The text to display on the button that opens the page.
 */
@property (nonatomic, copy, readonly) NSString *buttonText;

/**
 A relative URL representing an in-app screen to which the user can navigate.

 Possible paths at the moment are "pay", "invite_friends" or "order_gift_card". For
 "order_gift_card", will also include query parameters "merchant_id" and "merchant_name".
 */
@property (nonatomic, copy, readonly) NSURL *URL;

- (id)initWithButtonText:(NSString *)buttonText URL:(NSURL *)URL;

@end
