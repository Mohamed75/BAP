//
//  BAPAuthentificationViewController_iphone.m
//  BoitePizza
//
//  Created by Mohammed on 04/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPAuthentificationViewController_iphone.h"
#import "BAPAuthentification.h"
#import "AppDelegate_iPhone.h"

@implementation BAPAuthentificationViewController_iphone

@synthesize infosTable;
@synthesize bg;

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.view	setFrame:[UIScreen mainScreen].bounds];
	bg.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-64);
	
	
	self.infosTable.delegate = self;
	self.infosTable.dataSource = self;

}

#pragma mark -
#pragma mark Actions


-(IBAction)maskClicked:(id)sender
{
	[mailTf resignFirstResponder];
	[passwordTf resignFirstResponder];
}


-(IBAction)connectionClicked:(id)sender
{
    if([mailTf.text isEqualToString:@""] || [passwordTf.text isEqualToString:@""]){
        
        UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Echec de l'authentification"
                                                               message:@"Vous devez renseigner votre addresse e-mail ainsi que votre mot de passe."
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        [alertEvent		show];
        [alertEvent		release];
        
    }else{
        
        [BAPAuthentification	setDelegate:self];
        [BAPAuthentification	accountConnectionWithEmail:mailTf.text andPassword:passwordTf.text];	
    }
}

-(IBAction)creationClicked:(id)sender
{
	BAPCreationViewController_iphone *createVC = 	[[BAPCreationViewController_iphone alloc] initWithNibName:@"BAPCreationViewController_iphone" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:createVC animated:TRUE];
	[createVC release];
}

-(IBAction)forgetClicked:(id)sender
{
	BAPOublieMdpViewController *mdpVC = 	[[BAPOublieMdpViewController alloc] initWithNibName:@"BAPOublieMdpViewController" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:mdpVC animated:TRUE];
	[mdpVC release];
}

-(void)start
{
	[[AppDelegate_iPhone sharedDelegate] start];
}

#pragma mark -AuthentificationDelegate

-(void)authentificationFinish:(NSString*)response
{
	NSLog(@"AUTH OK : %@#", response);
	[self start];
}

-(void)authentificationFail:(NSString*)response
{
	NSLog(@"AUTH NOK : %@", response);
	
    UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Echec de l'authentification"
                                                           message:@"Addresse mail ou Mot de passe incorrect"
                                                          delegate:nil
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
    [alertEvent		show];
    [alertEvent		release];
}


#pragma mark -

#pragma mark TABLEVIEW METHODS

#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0)
	{
		[mailTf becomeFirstResponder];
	}else
	{
		[passwordTf becomeFirstResponder];
	}
}

#pragma mark UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [[UITableViewCell alloc] init];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if (indexPath.row == 0)
	{
		[mailTf release];
		mailTf = nil;
		mailTf = [[UITextField alloc] initWithFrame:CGRectMake(150, 7, 120, 20)];
		mailTf.delegate = self;
		mailTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
		mailTf.autocorrectionType = UITextAutocorrectionTypeNo;
		mailTf.keyboardType = UIKeyboardTypeEmailAddress;
		mailTf.returnKeyType = UIReturnKeyNext;
		[cell addSubview:mailTf];
	}else
	{
		[passwordTf release];
		passwordTf = nil;
		passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(150, 7, 120, 20)];
		passwordTf.delegate = self;
		passwordTf.returnKeyType = UIReturnKeyGo;
		passwordTf.secureTextEntry = TRUE;
		[cell addSubview:passwordTf];
	}
	
	return [cell autorelease];
}

#pragma mark - 
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:mailTf])
	{
		[passwordTf becomeFirstResponder];
	}else
	{
		[self connectionClicked:nil];
	}
	return TRUE;
}

@end
