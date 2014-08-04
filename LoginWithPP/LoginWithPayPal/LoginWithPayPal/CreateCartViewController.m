//
//  CreateCartViewController.m
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/29/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "CreateCartViewController.h"

@interface CreateCartViewController ()

@end

@implementation CreateCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Create Cart";
    
    UILabel *dummyText = [[UILabel alloc] init];
    [dummyText setFrame:CGRectMake(120,100,400,200)];
    dummyText.font = [UIFont fontWithName:@"ArialHebrew" size:20];
    dummyText.text= @"Create Cart";
    [self.view addSubview:dummyText];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pinterest_logged_into_paypal.png"]];
    backgroundView.frame = self.view.bounds;
      [[self view] addSubview:backgroundView];
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
