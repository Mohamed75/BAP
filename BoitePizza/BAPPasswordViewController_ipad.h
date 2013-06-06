//
//  BAPPasswordViewController_ipad.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 20/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAPPasswordViewController_ipad : UIViewController


@property (nonatomic, retain)	IBOutlet	UITextField	*emailTf;

-(IBAction)closeClicked;
-(IBAction)validClicked;

@end
