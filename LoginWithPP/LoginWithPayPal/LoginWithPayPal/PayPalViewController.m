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
#import "UserIdentityViewController.h"
#import "PayPalGuestLoginViewController.h"
#import "CreateCartViewController.h"

@interface PayPalViewController () {
    MBProgressHUD *HUD;
}
@end

@implementation PayPalViewController


const CGFloat HOffset = 50.0;
static NSString *resultIntercept = @"loginsuccess";


// Close button on the navigation bar
-(void) viewWillAppear:(BOOL)animated {
    
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


// Settings frames for webview and ProgressHUD

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float xWebView = self.view.frame.origin.x;
    float yWebView = self.view.frame.origin.y;
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
    
    [HUD showWhileExecuting:@selector(loadingPayPalURL)
                   onTarget:self
                 withObject:nil
                   animated:YES];
}



// Return method
// 1. Check Internet Connectivity
// 2. Send URL
// 3. Load WebView

-(void) loadingPayPalURL {
    
    [CheckReachability checkInternetConnectivity];
    
    NSURL *url = [NSURL URLWithString:[LoginURLViewController returnCustomURLString]];
    
    //Complete URL
    //NSLog(@"%@",[LoginURLViewController returnCustomURLString]);

    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    sleep(1);
}


#pragma mark - UIWebViewDelegate

// 1. Get URL for clicks
// 2. Intercept loginsuccess
// 3. Go to CreateCartVC on success

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *url = [[request URL] absoluteString];
    
    // Display URL for all user clicks
    // NSLog(@"%@\n\n\n", url);
    
    if ([url rangeOfString:resultIntercept].location != NSNotFound)
    {
        NSLog(@"Login successful!");
        
        // [self barCloseButtonPressed];
        [self performSelector:@selector(goToCreateCartVC:) withObject:nil afterDelay:0.0];
        
    } else {
        
        NSLog(@"Logging in...");
    }
    
    if ( navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        return NO;
    }
    return YES;
}

// Defined modal transition for CreateCardVC

-(void) goToCreateCartVC:(id)sender {
    
    CreateCartViewController *CreateCartVC = [[CreateCartViewController alloc] init];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self.navigationController pushViewController:CreateCartVC animated:YES];
    
}



- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.webView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}


- (void)barCloseButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
