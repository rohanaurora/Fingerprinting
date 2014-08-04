//
//  UserIdentityViewController.m
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/28/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "UserIdentityViewController.h"
#import "LoginURLViewController.h"
#import "CreateCartViewController.h"

@interface UserIdentityViewController ()

@end

@implementation UserIdentityViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   
 }

-(NSDictionary*) giveMeStatus {
    
    _userType = [self sendHTTPGet];
      
    return _userType;
    
}



-(NSDictionary *) sendHTTPGet
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSDictionary *outputDictionary = nil;
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    [sessionConfig setHTTPAdditionalHeaders:@{@"Partner-Id":@"7000610",
                                              @"Partner-Key":@"134256,78b0db8a-0ee1-4939-a2f9-d3cd95ec0fcc",
                                              @"Session-Id":[LoginURLViewController enterUserID],
                                              @"User-Identity":[LoginURLViewController enterUserID],
                                              @"Device-Fingerprint":@"device-fingerprint",
                                              @"Device-Type":@"device-type",
                                              @"Content-Type":@"application/json"
                                              }];
    
    
    NSURL * url = [NSURL URLWithString:@"http://api.checkout.ecn.ebay.com:8080/inlinexoweb/v1/identity"];
    
    [[[NSURLSession sessionWithConfiguration:sessionConfig] dataTaskWithURL:url completionHandler:^(NSData *taskData, NSURLResponse *taskResponse, NSError *taskError) {
        
        NSDictionary *dictionaryLayer1 = [NSJSONSerialization JSONObjectWithData:taskData options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dictionaryLayer2 = [dictionaryLayer1 valueForKeyPath :@"response_data.user_identity.user_type"];
        
        outputDictionary = dictionaryLayer2;
        
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return outputDictionary;
}

@end
