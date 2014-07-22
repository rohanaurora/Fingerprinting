//
//  PayPalViewController.m
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/21/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "PayPalViewController.h"

@interface PayPalViewController ()

@end

@implementation PayPalViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float xWebView = self.view.frame.origin.x;
    float yWebView = self.view.frame.origin.y - 20.0f;
    float wWebView = self.view.frame.size.width;
    float hxWebView = self.view.frame.size.height - 50.0f;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(xWebView, yWebView, wWebView, hxWebView)];
                    
    [self.webView setDelegate:self];
    //self.webView.scalesPageToFit = YES;

    
    // Magic URL = Custom URL which ECN gives us (it will have a redirect URL which will do payments etc. connected with ECN server)
    
    NSString *urlString = @"https://www.paypal.com/webapps/auth/protocol/openidconnect/v1/authorize?client_id=Ae-KaxBkBkbGjIUtDP4YP9S5ARTx17ErIYw6JF7_Go1pozHxiSU4MyDWR_uk&response_type=code&scope=openid%20profile%20email%20address%20phone%20https%3A%2F%2Furi.paypal.com%2Fservices%2Fpaypalattributes%20https%3A%2F%2Fapi.paypal.com%2Fv1%2Fvault%2Fcredit-card%20https%3A%2F%2Fapi.paypal.com%2Fv1%2Fvault%2Fcredit-card%2F.*%20https%3A%2F%2Fapi.paypal.com%2Fv1%2Fpayments%2F.*&redirect_uri=http%253A%252F%252Fphx5qa01c-852d.stratus.phx.qa.ebay.com%253A8080%252Finlinexoweb%252Fv1%252Fauthenticate%253Fstate%253Dkey&nonce=16711309&newUI=Y";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    [self.view addSubview:self.webView];

}


- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.webView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}



- (void) viewWillAppear:(BOOL)animated {
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(barCloseButtonPressed:)];
    
    self.navigationItem.leftBarButtonItem = closeButton;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1]; // iOS7 Hex Color #007AFF
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [self.navigationItem setTitle:@"PayPal"];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    

}

-(void)barCloseButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
