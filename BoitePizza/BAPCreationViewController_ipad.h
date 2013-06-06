//
//  BAPCreationViewController_ipad.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 20/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAPCreationViewController_ipad : UIViewController

@property (nonatomic, retain)	IBOutlet	UITextField *mailTf;
@property (nonatomic, retain)	IBOutlet	UITextField *passwordTf;


-(IBAction)closeClicked;
-(IBAction)validClicked:(id)sender;

@end
