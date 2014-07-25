//
//  CheckReachability.m
//  LoginWithPayPal
//
//  Created by Rohan Aurora on 7/25/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "CheckReachability.h"

@implementation CheckReachability

// Defining a block to check reachability
typedef void(^connection)(BOOL);

+ (void)checkInternet:(connection)block
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"HEAD";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    request.timeoutInterval = 3.0; // in seconds - needs to be checked
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         block([(NSHTTPURLResponse *)response statusCode] == 200);
     }];
}

+ (void)checkInternetConnectivity
{
    [CheckReachability checkInternet:^(BOOL internet)
     {
         if (internet)
         {
             NSLog(@"Internet connectivity is established");
         }
         else
         {
             NSLog(@"No Internet connectivity");
             
             UIAlertView *reachabilityAlert = [[UIAlertView alloc]initWithTitle:@"We're Sorry"
                                                                        message:NSLocalizedString(@"There was a problem communicating with the PayPal servers. Please try again.", nil)
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Try Again"
                                                              otherButtonTitles:@"Cancel", nil];
             [reachabilityAlert show];
             
         }
     }];
}


@end
