//
//  BAPFinalCmdViewController_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import "BAPFinalCmdViewController_iphone.h"

@interface BAPFinalCmdViewController_iphone ()

@end

@implementation BAPFinalCmdViewController_iphone
@synthesize txtV, txtV2;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        check = true;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txtV.text = @"Votre commande a bien été effectuée !\n\n Vous pouvez dès à présent \n consulter l'évolution de votre commande\n sur la page d'accueil\n de notre application !\n\n Bon appétit !";
    txtV2.text = @"Enregistrer cette commande\n ”Com d'hab”";
    
    self.navigationItem.hidesBackButton = YES;
}

-(IBAction)checkBtnClicked:(id)sender
{
	check = !check;
    
    if(check)
        [(UIButton *)sender setImage:[UIImage imageNamed:@"checked"] forState:0];
    else
        [(UIButton *)sender setImage:[UIImage imageNamed:@"unchecked"] forState:0];
}


-(IBAction)validerBtnClicked:(id)sender
{
    if(check){
        [BAPCommande setCommeDhab:[BAPCommande sharedInstance]];
    }
    BAPCommande *commande = [BAPCommande sharedInstance];
    commande.valider = true;
    [BAPCommande sharedInstance];
	[self.navigationController popToRootViewControllerAnimated:NO];
}

@end
