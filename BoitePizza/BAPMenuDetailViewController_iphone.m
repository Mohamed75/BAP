//
//  BAPMenuDetailViewController_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPMenuDetailViewController_iphone.h"
#import "BAPAuthentification.h"
#import "BAPProductCell_iphone.h"
#import "BAPCartViewController_iphone.h"
#import "BAPWSProducts.h"


@interface BAPMenuDetailViewController_iphone ()

@end

@implementation BAPMenuDetailViewController_iphone

@synthesize productsTable, tailleView;
@synthesize tailleMoyenne, tailleMoyenne2, tailleGeante, pateTradition, pateFinissima;
@synthesize consultationMode;


- (void)dealloc{
    
    [tailleView removeFromSuperview];
    [tailleView dealloc];
    [blackMask removeFromSuperview];
    [blackMask dealloc];
    [productsTable removeFromSuperview];
    [productsTable dealloc];
    [scrollView removeFromSuperview];
    [scrollView dealloc];
    
    [product release];
    [keysSubCat dealloc];
    [productsDico dealloc];
    [productsArray dealloc];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization

		index = 0;
        heightTailleView = [UIScreen mainScreen].bounds.size.height-120;
    }
    return self;
}


-(void)addScrollView{
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
    bg.frame = CGRectMake(0, 30, 320, 33);
    [self.view	addSubview:bg];
    
    UIImageView *flecheD = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flecheD"]];
    flecheD.frame = CGRectMake(305, 40, 15, 15);
    [self.view	addSubview:flecheD];
    [flecheD release];
    
    UIImageView *flecheG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flecheG"]];
    flecheG.frame = CGRectMake(0, 40, 15, 15);
    [self.view	addSubview:flecheG];
    [flecheG release];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 30, 300, 33)];
    scrollView.delegate = self;
    productsTable.frame = CGRectMake(0, 60, 320, productsTable.frame.size.height-50);
    
    
    keysSubCat = [[NSMutableArray alloc] init];
    int i = 0;
	for (NSString *key in productsDico){
		
        [keysSubCat addObject:key];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*scrollView.frame.size.width, 0, 300, 33)];
        label.text = key;
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        label.textColor = [UIColor brownColor];
		[scrollView addSubview:label];
        [label release];
        i += 1;
	}
    scrollView.contentSize = CGSizeMake(i*scrollView.frame.size.width, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentOffset = CGPointMake(0, 0);
    
    [self.view addSubview:scrollView];
    [bg release];
    
    [productsArray release];
    productsArray = [[productsDico objectForKey:[keysSubCat objectAtIndex:0]] retain];
    [productsTable reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	
    if(![sender isKindOfClass:[UITableView class]]){
        
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        [productsArray release];
        productsArray = [[productsDico objectForKey:[keysSubCat objectAtIndex:page]] retain];
        [productsTable reloadData];
    }
}


- (void)viewDidLoad
{
    [super 	viewDidLoad];
	[self	showLeftBtn:TRUE withAnimation:FALSE];
    
    [Utiles startLoading:self.view :NO];
	BAPCommande *commande = [BAPCommande sharedInstance];
	[BAPWSProducts setDelegate:self];
	
	if([commande.category isEqualToString:catMenu])
        [BAPWSProducts getMenusWithStoreId:commande.storeId];
    
    else if ([commande.category isEqualToString:catAccomp])
        [BAPWSProducts getAccompagnementWithStoreId:commande.storeId];
    
    else if ([commande.category isEqualToString:catPizza])
        [BAPWSProducts getProductWithStoreId:commande.storeId	 andCategory:commande.category];
    
    else if ([commande.category isEqualToString:catFood])
        [BAPWSProducts getFoodCollectionWithStoreId:commande.storeId];
    
	[tailleView setFrame:CGRectMake(0, 480, 320, heightTailleView)];
	
	[self.view	addSubview:tailleView];
	blackMask = [[UIView	alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	blackMask.backgroundColor = [UIColor blackColor];
	blackMask.alpha = 0;
	
    tailleMoyenne.tag = 1;
    tailleMoyenne2.tag = 1;
    tailleGeante.tag = 1;
    pateFinissima.tag = 2;
    pateTradition.tag = 2;
    
    productsTable.hidden = YES;
    
}


#pragma mark -getProductsDelegate

-(void)getProductFinish:(NSArray*)products
{
	//NSLog(@"products : %@", products);
    productsTable.hidden = NO;
	[Utiles stopLoading];
    
    BAPCommande *commande = [BAPCommande sharedInstance];
    if([commande.category isEqualToString:catMenu]) {
        [productsArray release];
        productsArray = nil;
        productsArray = [[NSArray alloc] initWithArray:products];
        [self.productsTable reloadData];
    }
    else if([commande.category isEqualToString:catAccomp])  {
        [productsDico release];
        productsDico = [[NSDictionary alloc] initWithDictionary:(NSDictionary *)products];
        [self addScrollView];
    }
    else if([commande.category isEqualToString:catPizza])   {
        [productsDico release];
        productsDico = [[NSDictionary alloc] initWithDictionary:[BAPMethode reorganiserArrayPizzas:products]];
        [self addScrollView];
    }
    else if([commande.category isEqualToString:catFood])  {
        [productsDico release];
        productsDico = [[NSDictionary alloc] initWithDictionary:(NSDictionary *)products];
        [self addScrollView];
    }
   
}

-(void)getProductFail:(NSObject*)object
{
    [Utiles stopLoading];
}







-(IBAction)btnsClicked:(id)sender
{
    UIButton *btn = sender;
    
    if(btn.tag == 1){
        tailleMoyenne.selected = false;
        tailleMoyenne2.selected = false;
        tailleGeante.selected = false;
        btn.selected = true;
        if(btn == tailleMoyenne)    product.sizeSelected = kMoyenne;
        else if(btn == tailleGeante)    product.sizeSelected = kGeante;
        else product.sizeSelected = kMoyenne2;
    }else{
        pateTradition.selected = false;
        pateFinissima.selected = false;
        btn.selected = true;
        if(btn == pateFinissima)    product.pateSelected = kFinissama;
        else product.pateSelected = kTraditionnelle;
    }
}

-(IBAction)validClicked
{
    
	[[BAPCommande sharedInstance] addProduct:product];
	
	
	[UIView animateWithDuration:0.3 
					 animations:^{ 
						 [tailleView setFrame:CGRectMake(0, 480, 320, heightTailleView)];
						 blackMask.alpha = 0.0;
						 
					 }
					 completion:^(BOOL finish){
						 [blackMask removeFromSuperview];
                         
						 BAPCartViewController_iphone *cart = [[BAPCartViewController_iphone	alloc] initWithNibName:@"BAPCartViewController_iphone" bundle:[NSBundle mainBundle]];
						 [self.navigationController pushViewController:cart animated:TRUE];
						 [cart release];
					 }];
	
	
}


-(IBAction)cancelClicked
{
	[UIView animateWithDuration:0.3 
					 animations:^{ 
						 [tailleView setFrame:CGRectMake(0, 480, 320, heightTailleView)];
						 blackMask.alpha = 0.0;
						 
					 }
					 completion:^(BOOL finish){[blackMask removeFromSuperview];    }];

}




#pragma mark UITableView delegate


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 85;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BAPCommande *commande = [BAPCommande sharedInstance];
    
    if([commande.category isEqualToString:catMenu])   return 30;
    else if ([commande.category isEqualToString:catAccomp])  return 0;
    else if ([commande.category isEqualToString:catPizza])  return 0;
    else if ([commande.category isEqualToString:catFood])   return 30;
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return  [[[UIView alloc] init] autorelease];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	index = indexPath.row;
    [product release];
    product = [[BAPProduct alloc] initWithProduct:[productsArray objectAtIndex:index]];
    
    if(!consultationMode){
        if([product.category isEqualToString:catPizza]){
            
            product.sizeSelected = kMoyenne2;
            product.pateSelected = kTraditionnelle;
            
            tailleMoyenne.selected = false;
            tailleGeante.selected = false;
            tailleMoyenne2.selected = true;
            
            pateTradition.selected = true;
            pateFinissima.selected = false;
            
            [self.view	addSubview:blackMask];
            [self.view bringSubviewToFront:tailleView];
            [UIView animateWithDuration:0.3
                             animations:^{
                                 [tailleView setFrame:CGRectMake(0, 7, 320, heightTailleView)];
                                 blackMask.alpha = 0.7;
                                 
                             }
                             completion:^(BOOL finish){    }];
        }else{
            
            [[BAPCommande sharedInstance] addProduct:product];
            
            BAPCartViewController_iphone *cart = [[BAPCartViewController_iphone	alloc] initWithNibName:@"BAPCartViewController_iphone" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:cart animated:TRUE];
            [cart release];
        }
    }
}

#pragma mark UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [productsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = @"ProductCell";
	
	BAPProductCell_iphone *cell = (BAPProductCell_iphone*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
	
	if (cell == nil) 
	{
		cell = [[[BAPProductCell_iphone alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	[cell setCellWithInfos:[productsArray objectAtIndex:indexPath.row]];
	
	
	return cell;
}


@end
