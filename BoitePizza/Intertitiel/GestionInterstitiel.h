//
//  GestionInterteciel.h
//  WallStreetInst
//
//  Created by Mohamed on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SplashUIImageView.h"
#import "Utiles.h"
#import "InterstitielIPadController.h"
#import "InterstitielIPhoneController.h"



@interface GestionInterstitiel : NSObject {

	BOOL forground;
    UIView *blackView;
	
	InterstitielIPadController      *interstitielIPadController;
    InterstitielIPhoneController    *interstitielIPhoneController;
}

@property (nonatomic, retain) NSArray *offresSpeciales;

+(GestionInterstitiel *)sharedInstance;
-(void) run:(BOOL) _Forground;
-(void) endInterteciel;

@end
