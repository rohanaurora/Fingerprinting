//
//  BuyNowViewController.h
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/21/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyNowViewController : UIViewController

@property(strong, nonatomic) UIButton *radiobutton1;
@property(strong, nonatomic) UIButton *radiobutton2;
@property(strong, nonatomic) UIButton *buy_now_button;

-(void)radiobuttonSelected:(id)sender;


@end
