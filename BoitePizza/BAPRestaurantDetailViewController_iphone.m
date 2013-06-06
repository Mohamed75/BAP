//
//  BAPRestaurantDetailViewController_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 03/04/13.
//
//

#import "BAPRestaurantDetailViewController_iphone.h"

@interface BAPRestaurantDetailViewController_iphone ()

@end

@implementation BAPRestaurantDetailViewController_iphone
@synthesize txtlbl, txtView, store;


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
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 85, 320, 36)];
    imgView.image = [UIImage imageNamed:@"bg-coordonnees"];
    [self.view addSubview:imgView];
    [imgView release];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 88, 150, 30)];
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor whiteColor];
    label1.text = @"Coordonnées";
    [self.view addSubview:label1];
    [label1 release];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 260, 320, 27)];
    imgView2.image = [UIImage imageNamed:@"bg-infos"];
    [self.view addSubview:imgView2];
    [imgView2 release];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 263, 320, 21)];
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor whiteColor];
    label2.text = @"Vous pouvez commander en ligne avec ce restaurant !";
    label2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label2];
    [label2 release];
    
    [self	showLeftBtn:TRUE withAnimation:FALSE];
    
    txtlbl.text = [NSString stringWithFormat:@"La Boîte à Pizza %@", [store objectForKey:@"store_city"]];
    
    txtView.text = [NSString stringWithFormat:@"%@ \n %@ %@ \n Tel. %@", [store objectForKey:@"store_address"], [store objectForKey:@"store_postcode"], [store objectForKey:@"store_city"], [store objectForKey:@"store_phone"]];
}

- (IBAction)consulterClicked:(id)sender
{
    BAPCommande *commande = [BAPCommande sharedInstance];
    commande.storeId = [BAPMethode getKeyStores:store];
    
    BAPMenuViewController_iphone	*menu = [[BAPMenuViewController_iphone alloc] initWithNibName:@"BAPMenuViewController_iphone" bundle:[NSBundle mainBundle]];
    menu.consultationMode = true;
    [self.navigationController pushViewController:menu animated:TRUE];
    [menu release];
}

@end
