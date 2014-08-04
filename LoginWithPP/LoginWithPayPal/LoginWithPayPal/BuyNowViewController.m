//
//  BuyNowViewController.m
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/21/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "BuyNowViewController.h"
#import "PayPalViewController.h"
#import "PayPalGuestLoginViewController.h"
#import "UserIdentityViewController.h"
#import "CreateCartViewController.h"


@interface BuyNowViewController ()
@end

@implementation BuyNowViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.buy_now_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    [self.buy_now_button setFrame:CGRectMake(110, 360, 100, 50)];
    [self.buy_now_button setImage:[UIImage imageNamed:@"buy_now_button.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.buy_now_button];
    
    [self.buy_now_button addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)goToLogin
{
    UserIdentityViewController *userIVC = [[UserIdentityViewController alloc] init];
    
    NSDictionary* tempDict = [userIVC giveMeStatus];
   
    
    NSString *user_type_output =  [NSString stringWithFormat:@"%@", tempDict];
    NSLog(@"%@", user_type_output);

        if([user_type_output  isEqual: @"paypal_login"]){

            NSLog(@"This user is already logged in");
            
            CreateCartViewController *createVC = [[CreateCartViewController alloc] init];
//            UINavigationController *createNav = [[UINavigationController alloc] initWithRootViewController:createVC];
//            [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//            [self presentViewController:createNav animated:YES completion:nil];
        
            [self.navigationController pushViewController:createVC animated:YES];

        } else {
            
            NSLog(@"This user is new");
            
            PayPalViewController *controller = [[PayPalViewController alloc] init];
            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
            [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:navigation animated:YES completion:nil];
        }
    

}


-(void)viewDidAppear:(BOOL)animated{
    
    //    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"first_screen.png"]];
    //    backgroundView.frame = CGRectMake(0, 70, 200, 200);
    //    [[self view] addSubview:backgroundView];
    
    
    // LIP label initialization
    UILabel *lbl1 = [[UILabel alloc] init];
    [lbl1 setFrame:CGRectMake(20,260,400,20)];
    lbl1.font = [UIFont fontWithName:@"ArialHebrew" size:14];
    lbl1.text= @"Login with PayPal";
    [self.view addSubview:lbl1];
    
    
    // LIG label initialization
    UILabel *lbl2 = [[UILabel alloc] init];
    [lbl2 setFrame:CGRectMake(180,260,400,20)];
    lbl2.font = [UIFont fontWithName:@"ArialHebrew" size:14];
    lbl2.text= @"Login as guest";
    [self.view addSubview:lbl2];
    
    
    // Radio button initialization (left)
    self.radiobutton1 = [[UIButton alloc] initWithFrame:CGRectMake(80, 300, 18, 18)];
    self.radiobutton1.selected = YES;
    [self.radiobutton1 setTag:0];
    [self.radiobutton1 setBackgroundImage:[UIImage imageNamed:@"RBOff.png"] forState:UIControlStateNormal];
    [self.radiobutton1 setBackgroundImage:[UIImage imageNamed:@"RBOn.png"] forState:UIControlStateSelected];
    [self.radiobutton1 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    // Radio button initialization (left)
    self.radiobutton2 = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 18, 18)];
    [self.radiobutton2 setTag:1];
    [self.radiobutton2 setBackgroundImage:[UIImage imageNamed:@"RBOff.png"] forState:UIControlStateNormal];
    [self.radiobutton2 setBackgroundImage:[UIImage imageNamed:@"RBOn.png"] forState:UIControlStateSelected];
    [self.radiobutton2 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.radiobutton1];
    [self.view addSubview:self.radiobutton2];
    
}


-(void)radiobuttonSelected:(id)sender{
    switch ([sender tag]) {
            
        case 0:
            
            if([self.radiobutton1 isSelected]==YES)
            {
                [self.radiobutton1 setSelected:NO];
                [self.radiobutton2 setSelected:YES];
            }
            else{
                [self.radiobutton1 setSelected:YES];
                [self.radiobutton2 setSelected:NO];
            }
            
            break;
            
        case 1:
            
            if([self.radiobutton2 isSelected]==YES)
            {
                [self.radiobutton2 setSelected:NO];
                [self.radiobutton1 setSelected:YES];
            }
            else{
                [self.radiobutton2 setSelected:YES];
                [self.radiobutton1 setSelected:NO];
            }
            
            break;
        default:
            break;
    }
    
}


@end
