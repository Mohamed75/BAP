//
//  BAPReductionViewController_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import "BAPReductionViewController_iphone.h"
#import "BAPCartViewController_iphone.h"


@interface BAPReductionViewController_iphone ()

@end

@implementation BAPReductionViewController_iphone
@synthesize reductionTable;

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
    BAPFinalCmdViewController_iphone *vC = [[BAPFinalCmdViewController_iphone	alloc] initWithNibName:@"BAPFinalCmdViewController_iphone" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vC animated:YES];
    [vC release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self	showLeftBtn:TRUE withAnimation:FALSE];
    [self	setRightBtnType:RightBtnTypeContinue];
	[self	showRightBtn:TRUE];
    
    reductionTable.hidden = YES;
    
    [Utiles startLoading:self.view :NO];
    BAPCommande *commande = [BAPCommande sharedInstance];
    [BAPWSReduction setDelegate:self];
    commande.sellId = @"228";
    [BAPWSReduction getCouponsWithStoreId:commande.storeId :commande.sellId];
}

#pragma mark -getCoupnsDelegate

-(void)getCouponsFinish:(NSArray*)reductions
{
        
    NSLog(@"reductions : %@", reductions);
    reductionTable.hidden = NO;
    [Utiles stopLoading];
    [reductionsArray release];
    reductionsArray = nil;
    reductionsArray = [[NSArray alloc] initWithArray:reductions];
    [self.reductionTable reloadData];
}

-(void)getCouponsFail:(NSObject*)object
{
    [Utiles stopLoading];
    if([(NSString *)object isEqualToString:@"Aucun coupon"]){
        UIAlertView *connecxionMsgErr = [[[UIAlertView alloc] initWithTitle:@"Nous sommes désolés" message:@"Pas de code de réduction disponible actuellemen" delegate:self cancelButtonTitle:@"Fermer" otherButtonTitles:nil] autorelease];
        [connecxionMsgErr show];
        [self rightBtnClicked];
    }
    else
        [Utiles connectionEchecMsg];
}




#pragma mark UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *tempNC = self.navigationController;
    [tempNC popViewControllerAnimated:NO];
    [[BAPCommande sharedInstance] validerReduction:tempNC :[reductionsArray objectAtIndex:indexPath.row]];
    ((BAPCartViewController_iphone*)tempNC.viewControllers.lastObject).validationlMode = @"reduction";
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 95;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return  [[[UIView alloc] init] autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [reductionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = @"ProductCell";
	
	BAPReductionCell_iphone *cell = (BAPReductionCell_iphone*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
	
	if (cell == nil)
	{
		cell = [[[BAPReductionCell_iphone alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	[cell setCellWithInfos:[reductionsArray objectAtIndex:indexPath.row]];
	
	
	return cell;
}

@end
