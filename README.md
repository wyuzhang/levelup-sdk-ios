<p align="center">
  <img src="https://levelup-assets.s3.amazonaws.com/images/email/email_logo.png" />
</p>

The [LevelUp](https://www.thelevelup.com) SDK allows developers to build apps that integrate with the LevelUp platform.

# Overview

The primary purpose of the SDK is to make it easy to issue requests to the LevelUp platform. It provides a layer on top of LevelUp's REST API. Requests may be things like signing up, logging or viewing nearby merchants. In addition, the SDK contains several utility classes to help with scanning and generating QR codes. Read below for additional information, or check out the [complete documentation](http://thelevelup.github.com/whitelabel-ios-sdk/) for a look at all the classes available with the SDK.

# Interacting with the API

## Performing Requests

Interactions with the LevelUp API occur through the [LUAPIClient](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUAPIClient.html) class. This is a singleton class through which all requests are performed.

Before issuing any requests, you must register an API key and specify if you would like to run requests against LevelUp's sandbox server or production server. This is done using the `setupWithAPIKey:developmentMode:` method:

````
[[LUAPIClient sharedClient] setupWithAPIKey:API_KEY developmentMode:YES];
````

An API request is an instance of [LUAPIRequest](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUAPIRequest.html). The SDK includes a set of request builders in order to create these requests (see "Request Builders" below).

Requests are performed by calling `performRequest:success:failure:`:

````
LUAPIRequest *request = [LUUserRequestBuilder requestForCurrentUser];
[[LUAPIClient sharedClient] performRequest:request
                                   success:^(LUUser *user) {
                                     NSLog(@"Retrieved user: %@", user);
                                   }
                                   failure:^(NSError *error) {
                                     NSLog(@"Error while retrieving user: %@");
                                   }
];
````

When the API call is successful, the `success` block will be called, and will be passed a result. This result differs for each call; for example, a request for the current user returns an `LUUser`, while a request for nearby merchants would return an `NSArray` of `LUMerchant` objects. The documentation for each request builder specifies the object which will be passed to `success`.

If the API request fails, an `NSError` instance will be passed to the `failure` block. The `userInfo` dictionary for this `NSError` has keys with several additional pieces of information:

- `LUAPIFailingURLRequestErrorKey`: An `NSURLRequest` containing the request.
- `LUAPIFailingURLResponseErrorKey`: An `NSURLResponse` containing the response.
- `LUAPIFailingErrorMessageErrorKey`: An optional error message from the server.
- `LUAPIFailingJSONResponseErrorKey`: An optional JSON response from the server.

## Models

The SDK includes model classes for LevelUp domain objects, such as a user or a merchant. Instances of these objects may be returned from API calls, or may be referenced from other model objects.

* **[LUApnDevice](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUApnDevice.html)**: Represents an [Apple Push Notification](http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ApplePushService/ApplePushService.html) device.
* **[LUBundle](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUBundle.html)**: A bundle of orders and refunds which are processed together.
* **[LUCampaign](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCampaign.html)**: Campaigns are promotions which can be claimed by users.
* **[LUCategory](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCategory.html)**: A merchant category, such as "Italian" or "Bar".
* **[LUCause](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCause.html)**: A charity or organization to which users can choose to donate part of their savings.
* **[LUCauseCategory](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCauseCategory.html)**: A cause charity, such as "Political" or "Wildlife Conservation".
* **[LUClaim](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUClaim.html)**: Represents a user's claim on a campaign.
* **[LUCohort](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCohort.html)**: When a user claims a campaign, they do so through a cohort. This could be through a social network or a particular advertisement.
* **[LUCreditCard](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCreditCard.html)**: Users have one or more credit cards to use as payment methods.
* **[LUDivision](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUDivision.html)**: A locality in which a merchant exists, such as a city.
* **[LUDonation](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUDonation.html)**: If a user has chosen a cause, and they place a qualifying order, an `LUDonation` will be created along with the order.
* **[LUInterstitialAction](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUInterstitialAction.html)**: Interstitial actions may be shown on some merchant or receipt screens to promote a campaign.
* **[LULocation](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LULocation.html)**: A merchant has one or more locations, which are physical places users can pay.
* **[LULoyalty](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LULoyalty.html)**: Contains information about a user's loyalty progress at a specific merchant.
* **[LUMerchant](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUMerchant.html)**: A place of business that accepts LevelUp for payment.
* **[LUMonetaryValue](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUMonetaryValue.html)**: Represents an amount of money of a specific currency.
* **[LUOAuthToken](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUOAuthToken.html)**: LevelUp uses [OAuth](http://www.oauth.net) to handle authentication. An OAuth token is created when a user successfully logs in, and is used to maintain an authentication session.
* **[LUOrder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUOrder.html)**: An order that has been placed using LevelUp.
* **[LUQRCode](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUQRCode.html)**: Merchants accept LevelUp by scanning a QR code displayed on a user's phone.
* **[LURefund](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LURefund.html)**: A refund, associated with a specific order.
* **[LUUser](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUUser.html)**: Represents a user of LevelUp.
* **[LUUserAddress](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUUserAddress.html)**: A user's address. Users may have multiple addresses, such as home and work.

## Request Builders

The SDK includes a set of request builders, which generate a particular `LUAPIRequest`. Some may require additional input, such as a merchant ID, which must be provided in order to retrieve a given merchant.

Below is the full list of request builders:

* [LUApnDeviceRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUApnDeviceRequestBuilder.html)
* [LUBundleRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUBundleRequestBuilder.html)
* [LUCampaignRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCampaignRequestBuilder.html)
* [LUCategoryRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCategoryRequestBuilder.html)
* [LUCauseRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCauseRequestBuilder.html)
* [LUClaimRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUClaimRequestBuilder.html)
* [LUCohortRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCohortRequestBuilder.html)
* [LUCreditCardRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUCreditCardRequestBuilder.html)
* [LUDivisionRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUDivisionRequestBuilder.html)
* [LUMerchantRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUMerchantRequestBuilder.html)
* [LUOAuthTokenRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUOAuthTokenRequestBuilder.html)
* [LUOrderRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUOrderRequestBuilder.html)
* [LUTicketRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUTicketRequestBuilder.html)
* [LUUserRequestBuilder](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUUserRequestBuilder.html)

# Generating and Scanning Codes

A core feature of an app built on the LevelUp platform is the ability to display QR codes (so that users can pay) and to scan QR codes (so that users can claim campaigns). The SDK provides two classes to assist with these actions.

## Generating Codes

The [LUQRCodeGenerator](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUQRCodeGenerator.html) class is used to generate a `UIImage` containing user's QR code, along with optional information such as a tip percentage.

## Scanning Codes

[LUQRCodeScannerView](http://thelevelup.github.com/whitelabel-ios-sdk/Classes/LUQRCodeScannerView.html) is a `UIView` that handles scanning QR codes. It is provided with a delegate to be notified when a scan is successful.
