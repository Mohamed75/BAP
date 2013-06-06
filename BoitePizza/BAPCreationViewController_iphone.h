//
//  BAPCreationViewController_iphone.h
//  BoitePizza
//
//  Created by Mohammed on 04/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BAPCreationViewController_iphone : BAPParentViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
	UITextField *mailTf;
	UITextField *passwordTf;
	UITextField *passwordConfirmTf;
}

@property (nonatomic, retain)	IBOutlet	UITableView	*infosTable;
@property (nonatomic, retain)	IBOutlet	UIImageView	*bg;

-(IBAction)validClicked:(id)sender;
-(IBAction)maskClicked:(id)sender;

@end
