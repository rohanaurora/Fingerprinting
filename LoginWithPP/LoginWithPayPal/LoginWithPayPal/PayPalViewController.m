//
//  PayPalViewController.m
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/21/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "PayPalViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "CheckReachability.h"
#import "LoginURLViewController.h"

@interface PayPalViewController () {
    MBProgressHUD *HUD;
}
@end

@implementation PayPalViewController

const CGFloat XOffset = 20.0;
const CGFloat HOffset = 30.0;
static NSString *resultIntercept = @"loginsuccess";

- (void) viewWillAppear:(BOOL)animated {
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(barCloseButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = closeButton;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1]; // iOS7 Hex Color #007AFF
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [self.navigationItem setTitle:@"PayPal"];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float xWebView = self.view.frame.origin.x;
    float yWebView = self.view.frame.origin.y - XOffset;
    float wWebView = self.view.frame.size.width;
    float hxWebView = self.view.frame.size.height - HOffset;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(xWebView, yWebView, wWebView, hxWebView)];
    [self.webView setDelegate:self];
    [self.view addSubview:self.webView];
   
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"";
    HUD.detailsLabelText = @"Establishing secure connection to PayPal...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(loadingPayPalURL) onTarget:self withObject:nil animated:YES];
}

#pragma mark - Sending URL to WebView

-(void) loadingPayPalURL {
    
    [CheckReachability checkInternetConnectivity];
    
    NSURL *url = [NSURL URLWithString:[LoginURLViewController returnCustomURLString]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    sleep(1);
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *url = [[request URL] absoluteString];
    // NSLog(@"%@\n\n\n", url);
    
    if ([url rangeOfString:resultIntercept].location != NSNotFound) {
        NSLog(@"Login successful!");
        [self barCloseButtonPressed];
        
    } else {
        
        NSLog(@"Establishing connection to PayPal servers");
    }
    
    if ( navigationType == UIWebViewNavigationTypeLinkClicked )
    {
        return NO;
    }
    return YES;
    
}


- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.webView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
}


- (void)barCloseButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
