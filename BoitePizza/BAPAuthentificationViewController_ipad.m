//
//  BAPAuthentificationViewController_ipad.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 20/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPAuthentificationViewController_ipad.h"
#import "BAPAuthentification.h"
#import "BAPCreationViewController_ipad.h"
#import "BAPPasswordViewController_ipad.h"
#import "AppDelegate_iPad.h"


@implementation BAPAuthentificationViewController_ipad

@synthesize mailTf, passwordTf;


#pragma mark -
#pragma mark Actions


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
	BAPCreationViewController_ipad *createVC = 	[[BAPCreationViewController_ipad alloc] initWithNibName:@"BAPCreationViewController_ipad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:createVC animated:TRUE];
	[createVC release];
}

-(IBAction)forgetClicked:(id)sender
{
	BAPPasswordViewController_ipad *createVC = 	[[BAPPasswordViewController_ipad
												  alloc] initWithNibName:@"BAPPasswordViewController_ipad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:createVC animated:TRUE];
	[createVC release];
}

-(void)start
{
	[[AppDelegate_iPad sharedDelegate] start];
}

-(void)authentificationFinish:(NSString*)response
{
	NSLog(@"AUTH OK : %@#", response);
	[self start];
}

-(void)authentificationFail:(NSString*)response
{
	NSLog(@"AUTH NOK : %@", response);
	UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Echec de l'authentification"
														   message:@"Vous devez renseigner votre addresse e-mail ainsi que votre mot de passe."
														  delegate:nil
												 cancelButtonTitle:@"Ok"
												 otherButtonTitles:nil];
	[alertEvent		show];
	[alertEvent		release];
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
