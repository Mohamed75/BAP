//
//  AppDelegate.m
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "BAPAuthentification.h"
#import "BAPWSAutres.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
	[_window release];
    [super dealloc];
}

-(void)applicationDidFinishLaunchingSuite{
    
}

-(void)endIntersticielForground{
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if([UIScreen mainScreen].bounds.size.height > 480){
        self.imgView.image = [UIImage imageNamed:@"Default-568h@2x"];
        self.imgView.frame = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height-20);
    }
    
    [BAPWSAutres getIntersticielWS];
    //[self applicationDidFinishLaunchingSuite];
    
    [Utiles pushNotificationInscription];
    
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	
    NSString *temp = [[NSString stringWithFormat:@"%@",devToken] stringByReplacingOccurrencesOfString:@"<" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@">" withString:@""] ;
    temp = [temp stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    NSMutableDictionary *dico = [[NSMutableDictionary alloc] init];
    [dico setObject:temp forKey:@"apns"];
    [Utiles writeDictionary:dico named:@"apnsCode"];
    [dico release];
}




- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[GestionInterstitiel sharedInstance] run:YES];
    [self.window makeKeyAndVisible];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	[BAPAuthentification getCategories];
	[BAPAuthentification getStores];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
