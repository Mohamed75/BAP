//
//  BAPOublieMdpViewController.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 15/04/13.
//
//

#import "BAPOublieMdpViewController.h"

@interface BAPOublieMdpViewController ()

@end

@implementation BAPOublieMdpViewController
@synthesize bg, mailTf;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view	setFrame:[UIScreen mainScreen].bounds];
	bg.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-64);
    
    [self showLeftBtn:TRUE withAnimation:TRUE];
}


-(IBAction)validerClicked:(id)sender
{
    [BAPAuthentification setDelegate:self];
	[BAPAuthentification lostPasswordWithEmail:mailTf.text];
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

#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self validerClicked:nil];
    [textField resignFirstResponder];
    
	return TRUE;
}


@end
