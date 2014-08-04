//
//  UserIdentityViewController.h
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/28/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserIdentityViewController : UIViewController <NSURLSessionDataDelegate>

@property (nonatomic, strong) NSDictionary *userType;

-(NSDictionary *) sendHTTPGet;
-(NSDictionary *) giveMeStatus;

@end
