//
//  BAPMenuViewController_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPMenuViewController_iphone.h"
#import "BAPMenuDetailViewController_iphone.h"
#import "BAPCommande.h"

@interface BAPMenuViewController_iphone ()

@end

@implementation BAPMenuViewController_iphone
@synthesize consultationMode;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization
        consultationMode = false;
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
	[self	showLeftBtn:TRUE withAnimation:FALSE];
    
    NSDictionary *account = [Utiles readDictionaryNamed:@"account"];
    [BAPCommande sharedInstance].customerId = [account objectForKey:@"customer_id"];
}


-(IBAction)pizzaClicked
{
	[BAPCommande sharedInstance].category = catPizza;
	BAPMenuDetailViewController_iphone	*detailVc	=	[[BAPMenuDetailViewController_iphone	alloc]	initWithNibName:@"BAPMenuDetailViewController_iphone" bundle:[NSBundle mainBundle]];
	detailVc.consultationMode = consultationMode;
    [self.navigationController	pushViewController:detailVc animated:TRUE];
	[detailVc	release];
	
}


-(IBAction)foodClicked
{
	[BAPCommande sharedInstance].category = catFood;
	BAPMenuDetailViewController_iphone	*detailVc	=	[[BAPMenuDetailViewController_iphone	alloc]	initWithNibName:@"BAPMenuDetailViewController_iphone" bundle:[NSBundle mainBundle]];
	detailVc.consultationMode = consultationMode;
    [self.navigationController	pushViewController:detailVc animated:TRUE];
	[detailVc	release];
}


-(IBAction)otherclicked
{
	[BAPCommande sharedInstance].category = catAccomp;
	BAPMenuDetailViewController_iphone	*detailVc	=	[[BAPMenuDetailViewController_iphone	alloc]	initWithNibName:@"BAPMenuDetailViewController_iphone" bundle:[NSBundle mainBundle]];
	detailVc.consultationMode = consultationMode;
    [self.navigationController	pushViewController:detailVc animated:TRUE];
	[detailVc	release];
}


-(IBAction)menuClicked
{
	[BAPCommande sharedInstance].category = catMenu;
	BAPMenuDetailViewController_iphone	*detailVc	=	[[BAPMenuDetailViewController_iphone	alloc]	initWithNibName:@"BAPMenuDetailViewController_iphone" bundle:[NSBundle mainBundle]];
	detailVc.consultationMode = consultationMode;
    [self.navigationController	pushViewController:detailVc animated:TRUE];
	[detailVc	release];
}


@end
