//
//  BAPAuthentificationViewController_ipad.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 20/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAPAuthentificationViewController_ipad : UIViewController


@property (nonatomic, retain)	IBOutlet	UITextField	*mailTf;
@property (nonatomic, retain)	IBOutlet	UITextField	*passwordTf;


-(IBAction)connectionClicked:(id)sender;
-(IBAction)creationClicked:(id)sender;
-(IBAction)forgetClicked:(id)sender;

-(void)authentificationFinish:(NSString*)response;
-(void)authentificationFail:(NSString*)response;


@end
