//
//  BAPPasswordViewController_ipad.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 20/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPPasswordViewController_ipad.h"
#import "BAPAuthentification.h"


@implementation BAPPasswordViewController_ipad

@synthesize emailTf;

-(IBAction)closeClicked
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction)validClicked
{
	[BAPAuthentification setDelegate:self];
	[BAPAuthentification lostPasswordWithEmail:self.emailTf.text];
}


-(void)lostPasswordFinish:(NSObject*)response
{
	NSLog(@"PASSWORD OK : %@", response);
	
	UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Mot de passe oublié"
														   message:@"Votre nouveau mot de passe a bien été envoyé. Veuillez vérifiez votre boite mail afin de récupérer votre nouveau mot de passe."
														  delegate:nil
												 cancelButtonTitle:@"Ok"
												 otherButtonTitles:nil];
	[alertEvent		show];
	[alertEvent		release];
	
	[self.navigationController popViewControllerAnimated:TRUE];
	
}

-(void)lostPasswordFail:(NSObject*)response
{
	NSLog(@"PASSWORD NOK : %@", response);
	
	UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Mot de passe oublié"
														   message:@"Le mail est invalide."
														  delegate:nil
												 cancelButtonTitle:@"Ok"	
												 otherButtonTitles:nil];
	[alertEvent		show];
	[alertEvent		release];
}

@end
