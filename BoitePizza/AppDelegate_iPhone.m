//
//  AppDelegate_iPhone.m
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "BAPTabBarController_iphone.h"
#import "BAPAuthentificationViewController_iphone.h"
#import "BAPAuthentification.h"
#import "BAPMethode.h"

@implementation AppDelegate_iPhone
@synthesize imgView;



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
		BAPAuthentificationViewController_iphone *authVC = [[BAPAuthentificationViewController_iphone alloc] initWithNibName:@"BAPAuthentificationViewController_iphone" bundle:[NSBundle mainBundle]];
		
		self.window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:authVC] autorelease];
		[authVC release];
	}else
	{
		[self start];
	}
    [self.window makeKeyAndVisible];
}


-(void)start
{
    imgView.image = [UIImage imageNamed:@"bg.png"];
	BAPTabBarController_iphone	* bapTabBar	=	[[BAPTabBarController_iphone alloc] init];
	self.window.rootViewController			=	bapTabBar;
	[bapTabBar	release];
}


+(AppDelegate_iPhone *)sharedDelegate
{
    return (AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
}

@end
