//
//  TokenManagement.h
//  Fingerprinting
//
//  Created by Rohan Aurora on 7/15/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenManagement : NSObject

-(NSString*) sha1Conversion;
-(NSMutableArray*)keychainBindings;

@end
