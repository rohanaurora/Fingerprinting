//
//  TokenManagement.m
//  Fingerprinting
//
//  Created by Rohan Aurora on 7/15/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "TokenManagement.h"
#import "KSSHA1Stream.h"
#import <PDKeychainBindingsController/PDKeychainBindings.h>


@implementation TokenManagement


-(NSString*)sha1Conversion {
    
    // Accessing UserID
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    // UTF-8 encoding
    NSData *data = [uuid dataUsingEncoding:NSUTF8StringEncoding];
    
    // For verification - http://www.xorbin.com/tools/sha1-hash-calculator
    // Display hash
    NSMutableData *hashValue = [NSData dataWithData:[data ks_SHA1Digest]];
    
    // Converting back to NSString
    NSCharacterSet *charsToRemove = [NSCharacterSet characterSetWithCharactersInString:@"< >"];
    NSString *myString = [[hashValue description] stringByTrimmingCharactersInSet:charsToRemove];
    
    return myString;
    
}

-(NSMutableArray*)keychainBindings {
    
    // Securing the token - https://github.com/carlbrown/PDKeychainBindingsController
    PDKeychainBindings *bindings = [PDKeychainBindings sharedKeychainBindings];
    
    [bindings setObject:@"UserID(n)" forKey:@"UserID"];
    [bindings setObject:[self sha1Conversion] forKey:@"Token"];
    
    // Retrieving the token to test
    NSString *username = [bindings objectForKey:@"UserID"];
    NSString *password = [bindings objectForKey:@"Token"];
    
     return [NSMutableArray arrayWithObjects:username, password,nil];
    
}

@end
