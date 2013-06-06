//
//  BAPAutresDetailViewController_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 29/03/13.
//
//

#import "BAPAutresDetailViewController_iphone.h"
#import "BAPWSProducts.h"


@interface BAPAutresDetailViewController_iphone ()

@end

@implementation BAPAutresDetailViewController_iphone
@synthesize autresTable, category;


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
    [tempNC popViewControllerAnimated:NO];
    [[BAPCommande sharedInstance] validerCommande:tempNC];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self	showLeftBtn:TRUE withAnimation:FALSE];
    [self	setRightBtnType:RightBtnTypeContinue];
	[self	showRightBtn:TRUE];
    
    [Utiles startLoading:self.view :NO];
    BAPCommande *commande = [BAPCommande sharedInstance];
	[BAPWSProducts setDelegate:self];
	[BAPWSProducts getProductWithStoreId:commande.storeId	 andCategory:category];
    
    autresTable.hidden = YES;
}

#pragma mark -getProductsDelegate

-(void)getProductFinish:(NSArray*)products
{
	//NSLog(@"products : %@", products);
    autresTable.hidden = NO;
	[Utiles stopLoading];
	[autresArray release];
	autresArray = nil;
	autresArray = [[NSArray alloc] initWithArray:products];
	[self.autresTable reloadData];
}

-(void)getProductFail:(NSObject*)object
{
    [Utiles stopLoading];
}




#pragma mark UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAPProduct *product = [[BAPProduct alloc] initWithProduct:[autresArray objectAtIndex:indexPath.row]];

    [[BAPCommande sharedInstance] addProduct:product];
    [product release];
        /*
    BAPCartViewController_iphone *cart = [[BAPCartViewController_iphone	alloc] initWithNibName:@"BAPCartViewController_iphone" bundle:[NSBundle mainBundle]];
    cart.validationlMode = @"autre";
    [self.navigationController pushViewController:cart animated:FALSE];
    [cart release];
         */
    UINavigationController *tempNC = self.navigationController;
    [tempNC popViewControllerAnimated:NO];
    [tempNC popViewControllerAnimated:NO];
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 85;
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
	return [autresArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = @"ProductCell";
	
	BAPProductCell_iphone *cell = (BAPProductCell_iphone*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
	
	if (cell == nil)
	{
		cell = [[[BAPProductCell_iphone alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	[cell setCellWithInfos:[autresArray objectAtIndex:indexPath.row]];
	
	
	return cell;
}

@end
