//
//  AppDelegate_iPad.m
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_iPad.h"
#import "BAPAuthentificationViewController_ipad.h"
#import "BAPAuthentification.h"
#import "BAPDeliveryViewController_ipad.h"

@implementation AppDelegate_iPad

-(void)applicationDidFinishLaunchingSuite
{
	if ([Utiles readDictionaryNamed:@"account"])
	{
		NSLog(@"Account");
	}else
	{
		[BAPMethode createEmptyAccount];
		NSLog(@"no account");
	}
	
    
    if ([[[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_email"] length] < 2)
	{
		BAPAuthentificationViewController_ipad *authVC = [[BAPAuthentificationViewController_ipad alloc] initWithNibName:@"BAPAuthentificationViewController_ipad" bundle:[NSBundle mainBundle]];
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[Utiles	imageNamed:@"connexion_bg_ipad"]];
        [self.window addSubview:bg];
        
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:authVC];
        [authVC.navigationController setNavigationBarHidden:TRUE];
        
	}else
	{
		[self start];
	}
    [self.window makeKeyAndVisible];
}

-(void)start
{
    BAPDeliveryViewController_ipad *delivery = [[BAPDeliveryViewController_ipad alloc] initWithNibName:@"BAPDeliveryViewController_ipad" bundle:[NSBundle mainBundle]];
	//[self.navigationController pushViewController:delivery animated:TRUE];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:delivery];
	[delivery release];
}

+(AppDelegate_iPad *)sharedDelegate
{
    return (AppDelegate_iPad *)[[UIApplication sharedApplication] delegate];
}

@end