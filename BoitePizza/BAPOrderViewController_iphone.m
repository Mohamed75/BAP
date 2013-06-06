//
//  BAPOrderViewController_iphone.m
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPOrderViewController_iphone.h"
#import "BAPDeliveryViewController_iphone.h"
#import "BAPRestaurantListViewController_iphone.h"
#import "BAPCartViewController_iphone.h"

@interface BAPOrderViewController_iphone ()

@end

@implementation BAPOrderViewController_iphone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(13, 272, 294, 80)];
	scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    pageControl = [[MyUIPageControl alloc] initWithFrame:CGRectMake(80, 350, 160, 20)];
    pageControl.imageNormal = [UIImage imageNamed:@"dim"];
    pageControl.imageCurrent = [UIImage imageNamed:@"dim-active"];
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    
}

-(NSArray*)commandesLessLast{

    NSMutableArray *array = [[NSMutableArray alloc] init];
    int nbrTotal = [[BAPCommande getCommandes] count];
    for(int i = 0; i < nbrTotal-1; i++){
        [array addObject:[[BAPCommande getCommandes] objectAtIndex:i]];
    }
    return [array autorelease];
}

-(void)viewDidAppear:(BOOL)animated{
	
    for(UIView *subView in scrollView.subviews)
        [subView removeFromSuperview];
        
    NSArray *commandes = [self commandesLessLast];
    if(commandes.count > 2)    pageControl.numberOfPages = commandes.count;
    else if(commandes.count > 0)   pageControl.numberOfPages = 3;
        
    int i = 0;
	for(BAPCommande *commande in commandes){
		
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*scrollView.frame.size.width, 0, 294, 80)];
        imgView.image = [UIImage imageNamed:@"exemple-interstitiel"];
		[scrollView addSubview:imgView];
        [imgView release];
        i += 1;
	}
    scrollView.contentSize = CGSizeMake(i*scrollView.frame.size.width, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentOffset = CGPointMake(0, 0);
    pageControl.currentPage = 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}



-(IBAction)comDHabClicked
{
    if([BAPCommande getCommeDhab] != nil){
        
        [BAPCommande initCommeDhab];
        
        BAPCartViewController_iphone *cart = [[BAPCartViewController_iphone	alloc] initWithNibName:@"BAPCartViewController_iphone" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:cart animated:TRUE];
        [cart release];
    }
}

-(IBAction)emporterClicked
{
    if([BAPCommande getCommeDhab] != nil)   [BAPCommande initNotCommeDhab];
        
    BAPCommande *commande = [BAPCommande sharedInstance];
    commande.deliveryMethod = [@"pickup" retain];
    commande.streetId = @"0";
	BAPRestaurantListViewController_iphone	*restaurantVc	=	[[BAPRestaurantListViewController_iphone	alloc]	initWithNibName:@"BAPRestaurantListViewController_iphone" bundle:[NSBundle mainBundle]];
	[self.navigationController		pushViewController:restaurantVc animated:TRUE];
	[restaurantVc					release];
}

-(IBAction)livraisonClicked
{
    if([BAPCommande getCommeDhab] != nil)   [BAPCommande initNotCommeDhab];
    
    BAPCommande *commande = [BAPCommande sharedInstance];
    commande.deliveryMethod = [@"delivery" retain];
	BAPDeliveryViewController_iphone	*deliverVc	=	[[BAPDeliveryViewController_iphone	alloc]	initWithNibName:@"BAPDeliveryViewController_iphone" bundle:[NSBundle  mainBundle]];
	[self.navigationController		pushViewController:deliverVc animated:TRUE];
	[deliverVc	release];
	
}


@end
