//
//  BAPTabBarController_iphone.m
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPTabBarController_iphone.h"
#import "BAPAuthentificationViewController_iphone.h"
#import "BAPOrderViewController_iphone.h"
#import "BAPRestaurantViewController_iphone.h"
#import "BAPCartViewController_iphone.h"
#import "BAPAccountViewController_iphone.h"



@interface BAPTabBarController_iphone ()

@end

@implementation BAPTabBarController_iphone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
		
    }
    return self;
}

-(id)init
{
	self = [super init];
    if (self) 
	{
		
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	//NSLog(@"Account : \n%@", [Utiles readDictionaryNamed:@"account"]);
	
	[self.view	setFrame:CGRectMake(0, 0, 320, 480)];
	
	if  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) 
	{
		[[UINavigationBar	appearance] setContentMode:UIViewContentModeScaleAspectFill];
		[[UINavigationBar	appearance] setBackgroundImage:[UIImage imageNamed:@"bg-navbar"] forBarMetrics:UIBarMetricsDefault];
	}
	
	BAPOrderViewController_iphone		*orderVc	=	[[BAPOrderViewController_iphone			alloc]	initWithNibName:@"BAPOrderViewController_iphone" 
																										bundle:[NSBundle mainBundle]];
	BAPRestaurantViewController_iphone	*restauVc	=	[[BAPRestaurantViewController_iphone	alloc]	initWithNibName:@"BAPRestaurantViewController_iphone"
																										bundle:[NSBundle mainBundle]];
	BAPCartViewController_iphone		*cartVc		=	[[BAPCartViewController_iphone			alloc]	initWithNibName:@"BAPCartViewController_iphone"
                                                                                                    bundle:[NSBundle mainBundle]];
    cartVc.tabBarMode = true;
    BAPAccountViewController_iphone		*accountVc	=	[[BAPAccountViewController_iphone		alloc]	initWithNibName:@"BAPAccountViewController_iphone"
																									 	bundle:[NSBundle mainBundle]];
	
	UINavigationController	*orderNav	=	[[UINavigationController	alloc]	initWithRootViewController:orderVc];
	UINavigationController	*restauNav	=	[[UINavigationController	alloc]	initWithRootViewController:restauVc];
	UINavigationController	*cartNav	=	[[UINavigationController	alloc]	initWithRootViewController:cartVc];
	UINavigationController	*accountNav	=	[[UINavigationController	alloc]	initWithRootViewController:accountVc];
	
	self.viewControllers				=	[NSArray	arrayWithObjects:orderNav, restauNav, cartNav, accountNav, nil];
	
	[orderVc	release];
	[restauVc	release];
	[cartVc		release];
	[accountVc	release];
	
	[orderNav	release];
	[restauNav	release];
	[cartNav	release];
	[accountNav	release];
	
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:0] setImage:[UIImage imageNamed:@"restaurant"]];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:1] setImage:[UIImage imageNamed:@"map"]];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:2] setImage:[UIImage imageNamed:@"panier"]];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:3] setImage:[UIImage imageNamed:@"compte"]];

	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:0] setTitle:@"Commander"];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:1] setTitle:@"Restaurants"];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:2] setTitle:@"Panier"];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:3] setTitle:@"Compte"];
	
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:0] setTag:0];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:1] setTag:1];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:2] setTag:2];
	[(UITabBarItem*)[self.tabBar.items	objectAtIndex:3] setTag:3];
	
	self.tabBar.selectedImageTintColor	=	[UIColor	redColor];;

	self.delegate	=	self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController 
{
    if(tabBarController.selectedIndex == self.tabBar.selectedItem.tag) 
	{
        return NO;
    }
    return YES;
}



@end
