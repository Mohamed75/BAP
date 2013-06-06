//
//  BAPCreationViewController_ipad.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 20/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPCreationViewController_ipad.h"
#import "BAPDeliveryViewController_ipad.h"


@implementation BAPCreationViewController_ipad

@synthesize mailTf;
@synthesize passwordTf;


-(IBAction)closeClicked
{
	[self.navigationController popViewControllerAnimated:TRUE];
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
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:mailTf])
	{
		[passwordTf becomeFirstResponder];
	}else
	{
		[self validClicked:nil];
	}
	return TRUE;
}

@end
