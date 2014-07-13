//
//  PaymentsViewController.h
//  PayPalAppv2
//
//  Created by Rohan Aurora on 7/11/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@interface PaymentsViewController : UIViewController <PayPalPaymentDelegate>

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;


@end
