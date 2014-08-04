//
//  PayPalViewController.h
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/21/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayPalViewController : UIViewController <UIWebViewDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) UIWebView *webView;

- (void)barCloseButtonPressed;

@end
