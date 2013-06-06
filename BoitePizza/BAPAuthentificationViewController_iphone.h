//
//  BAPAuthentificationViewController_iphone.h
//  BoitePizza
//
//  Created by Mohammed on 04/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAPParentViewController.h"
#import "BAPCreationViewController_iphone.h"
#import "BAPOublieMdpViewController.h"


@interface BAPAuthentificationViewController_iphone : BAPParentViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
	UITextField *mailTf;
	UITextField *passwordTf;
}

@property (nonatomic, retain)	IBOutlet	UITableView	*infosTable;
@property (nonatomic, retain)	IBOutlet	UIImageView	*bg;

-(void)start;
-(IBAction)connectionClicked:(id)sender;
-(IBAction)creationClicked:(id)sender;
-(IBAction)forgetClicked:(id)sender;
-(IBAction)maskClicked:(id)sender;

-(void)authentificationFinish:(NSString*)response;
-(void)authentificationFail:(NSString*)response;

@end
