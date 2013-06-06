//
//  BAPCreationViewController_iphone.m
//  BoitePizza
//
//  Created by Mohammed on 04/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPCreationViewController_iphone.h"
#import "AppDelegate_iPhone.h"
#import "BAPAuthentification.h"

@implementation BAPCreationViewController_iphone
@synthesize infosTable;
@synthesize bg;

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.view	setFrame:[UIScreen mainScreen].bounds];
	bg.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-64);
	
	if  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) 
	{
		[[UINavigationBar	appearance] setContentMode:UIViewContentModeScaleAspectFill];
		[[UINavigationBar	appearance] setBackgroundImage:[UIImage imageNamed:@"bg-navbar"] forBarMetrics:UIBarMetricsDefault];
	}
	
	[self showLeftBtn:TRUE withAnimation:TRUE];
	
	self.infosTable.delegate = self;
	self.infosTable.dataSource = self;
}

#pragma mark -
#pragma mark Actions

-(IBAction)maskClicked:(id)sender
{
	[mailTf resignFirstResponder];
	[passwordTf resignFirstResponder];
	[passwordConfirmTf resignFirstResponder];
}

-(IBAction)validClicked:(id)sender
{
    if ([passwordTf.text length] <6)
	{
		UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Echec de la création"
															   message:@"Votre mot de passe doit contenir au moins 6 caractères."
															  delegate:nil
													 cancelButtonTitle:@"Ok"
													 otherButtonTitles: nil];
		[alertEvent		show];
		[alertEvent		release];
		return;
	}
    
	if (![passwordConfirmTf.text isEqualToString:passwordTf.text])
	{
		UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Echec de la création"
															   message:@"Veuillez confirmer le mot de passe."
															  delegate:nil
													 cancelButtonTitle:@"Ok"
													 otherButtonTitles: nil];
		[alertEvent		show];
		[alertEvent		release];
		return;
	}
	
	[BAPMethode createEmptyAccount];
	
	NSMutableDictionary *account = [[NSMutableDictionary alloc] initWithDictionary:[Utiles readDictionaryNamed:@"account"]];
	
	[account 	setObject:mailTf.text forKey:@"customer_email"];
	[account 	setObject:passwordTf.text forKey:@"customer_password"];
	
	[Utiles		writeDictionary:account named:@"account"];
	
	[[AppDelegate_iPhone sharedDelegate] start];
	
    [account release];
	/*
	 varchar(?)	 form_action (save, update)
	 varchar(?)  customer_civility (Monsieur, Madame, Societe)
	 varchar(150)customer_store_name (obligatoire)  
	 varchar(50) customer_name (obligatoire)  
	 varchar(20) customer_mobile (mobile ou fixe obligatoire)  
	 varchar(200)customer_email (obligatoire, unique)  
	 varchar(16) customer_password (obligatoire)
	 varchar(50) customer_firstname
	 varchar(20) customer_phone
	 int(11) 	 customer_address_street_id  
	 varchar(10) customer_address_number  
	 varchar(60) customer_address_building  
	 varchar(60) customer_address_bloc  
	 varchar(10) customer_address_suite  
	 varchar(10) customer_address_floor  
	 varchar(10) customer_address_code_gate  
	 varchar(10) customer_address_code_entry  
	 varchar(10) customer_address_code_lift 
	 */

	///////
	
	
	
	
}


#pragma mark -AuthentificationDelegate

-(void)creationFinish:(NSDictionary*)response
{
	NSLog(@"creation OK : %@", response);
}

-(void)creationFail:(NSDictionary*)response
{
	NSLog(@"creation NOK : %@", response);
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
	}else if (indexPath.row == 1)
	{
		[passwordTf becomeFirstResponder];
	}else
	{
		[passwordConfirmTf becomeFirstResponder];
	}
}

#pragma mark UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
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
	}else if (indexPath.row == 1)
	{
		[passwordTf release];
		passwordTf = nil;
		passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(150, 7, 120, 20)];
		passwordTf.delegate = self;
		passwordTf.returnKeyType = UIReturnKeyNext;
		passwordTf.secureTextEntry = TRUE;
		[cell addSubview:passwordTf];
	}else
	{
		[passwordConfirmTf release];
		passwordConfirmTf = nil;
		passwordConfirmTf = [[UITextField alloc] initWithFrame:CGRectMake(150, 7, 120, 20)];
		passwordConfirmTf.delegate = self;
		passwordConfirmTf.returnKeyType = UIReturnKeyGo;
		passwordConfirmTf.secureTextEntry = TRUE;
		[cell addSubview:passwordConfirmTf];
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
	}else if ([textField isEqual:passwordTf])
	{
		[passwordConfirmTf becomeFirstResponder];
	}else
	{
		[self validClicked:nil];
	}
	return TRUE;
}

@end
