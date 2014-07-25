//
//  BuyNowViewController.m
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/21/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "BuyNowViewController.h"
#import "PayPalViewController.h"

@interface BuyNowViewController ()

@end

@implementation BuyNowViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *loginWithPPButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    [loginWithPPButton setImage:[UIImage imageNamed:@"loginwithpaypalbutton.png"] forState:UIControlStateNormal];
    [self.view addSubview:loginWithPPButton];
    [loginWithPPButton addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
}



- (void)goToLogin
{
    PayPalViewController *controller = [[PayPalViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navigation animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
