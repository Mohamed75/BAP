//
//  AppDelegate.h
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestionInterstitiel.h"
#import "BAPAuthentificationViewController_iphone.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic)   IBOutlet    UIWindow    *window;
@property (nonatomic, retain)   IBOutlet	UIImageView *imgView;

-(void)applicationDidFinishLaunchingSuite;

@end
