//
//  BAPAutresViewController_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 29/03/13.
//
//

#import "BAPAutresViewController_iphone.h"

@interface BAPAutresViewController_iphone ()

@end

@implementation BAPAutresViewController_iphone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)rightBtnClicked
{
    UINavigationController *tempNC = self.navigationController;
    [tempNC popViewControllerAnimated:NO];
	[[BAPCommande sharedInstance] validerCommande:tempNC];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self	showLeftBtn:TRUE withAnimation:FALSE];
    [self	setRightBtnType:RightBtnTypeContinue];
	[self	showRightBtn:TRUE];
}


-(IBAction)boissonClicked
{
	BAPAutresDetailViewController_iphone *autresDetailVC = [[BAPAutresDetailViewController_iphone alloc] initWithNibName:@"BAPAutresDetailViewController_iphone" bundle:[NSBundle mainBundle]];
    autresDetailVC.category = @"boissons";
    [self.navigationController pushViewController:autresDetailVC animated:TRUE];
    [autresDetailVC release];
}


-(IBAction)entreesclicked
{
	BAPAutresDetailViewController_iphone *autresDetailVC = [[BAPAutresDetailViewController_iphone alloc] initWithNibName:@"BAPAutresDetailViewController_iphone" bundle:[NSBundle mainBundle]];
    autresDetailVC.category = @"entree";
    [self.navigationController pushViewController:autresDetailVC animated:TRUE];
    [autresDetailVC release];
}


-(IBAction)dessertsClicked
{
	BAPAutresDetailViewController_iphone *autresDetailVC = [[BAPAutresDetailViewController_iphone alloc] initWithNibName:@"BAPAutresDetailViewController_iphone" bundle:[NSBundle mainBundle]];
    autresDetailVC.category = @"dessert";
    [self.navigationController pushViewController:autresDetailVC animated:TRUE];
    [autresDetailVC release];
}
@end
