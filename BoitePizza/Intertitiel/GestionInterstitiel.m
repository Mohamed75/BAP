//
//  GestionInterteciel.m
//  WallStreetInst
//
//  Created by Mohamed on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GestionInterstitiel.h"
#import "AppDelegate_iPhone.h"
#import "AppDelegate_iPad.h"
#import "BAPDeliveryViewController_ipad.h"

static GestionInterstitiel *sharedInstance = nil;

@implementation GestionInterstitiel
@synthesize offresSpeciales;


+(GestionInterstitiel *)sharedInstance{
    
    if(sharedInstance == nil){
        sharedInstance = [[GestionInterstitiel alloc] init];
    }
    return sharedInstance;
}

-(void) run:(BOOL) _Forground{
		
    forground = _Forground;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    blackView.backgroundColor = [UIColor blackColor];

	if([Utiles isIpad])	{
        
        [[AppDelegate_iPad sharedDelegate].window addSubview:blackView];
		interstitielIPadController = [[InterstitielIPadController alloc] init];
        interstitielIPadController.delegate = self;
		[[AppDelegate_iPad sharedDelegate].window addSubview:interstitielIPadController.view];
		
	}else {
        
        [[AppDelegate_iPhone sharedDelegate].window addSubview:blackView];
		interstitielIPhoneController = [[InterstitielIPhoneController alloc] init];
        interstitielIPhoneController.delegate = self;
		[[AppDelegate_iPhone sharedDelegate].window addSubview:interstitielIPhoneController.view];
        
	}
}



-(void)endInterteciel{
	
    [blackView removeFromSuperview];
    [blackView release];
    
    if([Utiles isIpad])	{
        
        if(!forground)	[[AppDelegate_iPad sharedDelegate] performSelector:@selector(applicationDidFinishLaunchingSuite) withObject:nil];
        else    [[AppDelegate_iPad sharedDelegate] performSelector:@selector(endIntersticielForground) withObject:nil];
    }else{
        
        if(!forground)	[[AppDelegate_iPhone sharedDelegate] performSelector:@selector(applicationDidFinishLaunchingSuite) withObject:nil];
        else    [[AppDelegate_iPhone sharedDelegate] performSelector:@selector(endIntersticielForground) withObject:nil];
    }
    
	if(interstitielIPhoneController != nil)	{
		[interstitielIPhoneController.view removeFromSuperview];
		[interstitielIPhoneController release];
		interstitielIPhoneController = nil;
	}
	if(interstitielIPadController != nil)	{
		[interstitielIPadController.view removeFromSuperview];
		[interstitielIPadController release];
		interstitielIPadController = nil;
	}
}





- (void)dealloc {
	
    if(offresSpeciales != nil)  [offresSpeciales release];
    [super dealloc];
}

@end
