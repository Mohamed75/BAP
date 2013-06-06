//
//  BAPAuthentification.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 04/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJsonWriter.h"
#import "SBJsonParser.h"
#import "BAPProduct.h"

@interface BAPAuthentification : NSObject

+(void)setDelegate:(NSObject*)pDelegate;
+(NSObject *)getDelegate;

+(void)accountConnectionWithEmail:(NSString*)email andPassword:(NSString*)password;
+(void)realAccountConnectWithEmail:(NSString*)email andPassword:(NSString*)password;
+(void)accountCreationWithEmail:(NSString*)email andPassword:(NSString*)password;
+(void)accountCreationWithStreetId:(NSString*)streetId;
+(void)lostPasswordWithEmail:(NSString*)email;
+(void)getCategories;
+(void)getStores;
+(void)getStreetWithCity:(NSString*)city;

@end
