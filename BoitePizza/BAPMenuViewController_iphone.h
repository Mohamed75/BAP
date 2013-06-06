//
//  BAPMenuViewController_iphone.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAPMenuViewController_iphone : BAPParentViewController


@property (nonatomic)	BOOL	consultationMode;

-(IBAction)pizzaClicked;
-(IBAction)foodClicked;
-(IBAction)otherclicked;
-(IBAction)menuClicked;


@end
