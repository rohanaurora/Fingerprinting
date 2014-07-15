//
//  ViewController.m
//  Fingerprinting
//
//  Created by Rohan Aurora on 7/14/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "ViewController.h"
#import "KSSHA1Stream.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSLog(@"UUID %@",uuid);
    
    NSData *data = [uuid dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Data %@",data);
   
    NSLog(@"SHA-1 hash %@",[data ks_SHA1Digest]);
    // For verification - http://www.xorbin.com/tools/sha1-hash-calculator
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
