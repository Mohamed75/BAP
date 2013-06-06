//
//  BAPCommande.m
//  BoitePizza
//
//  Created by Mohammed on 04/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPCommande.h"
#import "BAPWSCommande.h"


///static BAPCommande *sharedObject = nil;
NSMutableArray  *commandes = nil;
BAPCommande     *commeDhabPanier;
NSTimer         *timer;


@implementation BAPCommande

@synthesize storeId;
@synthesize streetId;
@synthesize customerId;
@synthesize deliveryMethod;
@synthesize category;
@synthesize products;

@synthesize date;
@synthesize sellId;
@synthesize valider;
@synthesize commedhab;


+(void)initNotCommeDhab{
    if(((BAPCommande *)commandes.lastObject).commedhab){
        [commandes removeLastObject];
        [commandes addObject:[[[BAPCommande alloc] init] autorelease]];
    }
}


+(void)initCommeDhab{
    [commandes removeLastObject];
    [commandes addObject:[[[BAPCommande alloc] initWithCommande:commeDhabPanier] autorelease]];
}

+(void)setCommeDhab:(BAPCommande *)commande{
    [commeDhabPanier release];
    commeDhabPanier = [[BAPCommande alloc] initWithCommande:commande];
}

+(BAPCommande*)getCommeDhab{
    return commeDhabPanier;
}

+(NSMutableArray *)getCommandes{
    return commandes;
}


+(void)timerFct{
	
    BAPCommande *lasteCommande = commandes.lastObject;
    if([lasteCommande.date timeIntervalSinceNow] < -1800){
        [commandes removeLastObject];
        [commandes addObject:[[[BAPCommande alloc] init] autorelease]];
        
        if(![Utiles isIpad])    {
            UITabBarController *tabBar = (UITabBarController *)([AppDelegate_iPhone sharedDelegate]).window.rootViewController;
            [(UINavigationController *)[tabBar.viewControllers objectAtIndex:0] popToRootViewControllerAnimated:NO];
        }
        
    }
}


/*
 if (sharedObject == nil)
 {
 sharedObject	=	[[super allocWithZone:NULL]	init];
 sharedObject	=	[sharedObject				init];
 }
 return sharedObject;
 */
+ (BAPCommande *)sharedInstance
{
    if(commandes == nil)  {
        //Aucune Commande existante
        commandes = [[NSMutableArray alloc] init];
        [commandes addObject:[[[BAPCommande alloc] init] autorelease]];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerFct) userInfo:nil repeats:YES];
        [timer fire];
    }
    else{
        
        BAPCommande *lasteCommande = commandes.lastObject;
        
        if(lasteCommande.valider)   //All Commande existante sont finaliser
            [commandes addObject:[[[BAPCommande alloc] init] autorelease]];
    }
    
    BAPCommande *lasteCommande = commandes.lastObject;
    lasteCommande.date = [NSDate date];
    
    return commandes.lastObject;
}

-(void)dealloc{
    
    [products release];
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        
		self.storeId = @"";
		self.streetId = @"";
		self.customerId = @"";
		self.deliveryMethod = @"";
		self.category = @"";
		self.products = [[[NSMutableArray alloc] init] autorelease];
		self.valider = false;
        self.commedhab = false;
        self.date = [NSDate date];
    }
    return self;
}

- (id)initWithCommande:(BAPCommande *)commande {
    self = [super init];
    if (self) {
        
		self.storeId = commande.storeId;
		self.streetId = commande.streetId;
		self.customerId = commande.customerId;
		self.deliveryMethod = commande.deliveryMethod ;
		self.category = commande.category;
		self.products = [[[NSMutableArray alloc] initWithArray:commande.products] autorelease];
		self.valider = false;
        self.commedhab = true;
        self.date = [NSDate date];
    }
    return self;
}


-(void)removeProduct:(BAPProduct *)product{
    
    [products removeObject:product];
}


-(void)addProduct:(BAPProduct*)product
{
	bool contained = FALSE;
	
	BAPProduct *doublon;
	
	for (BAPProduct *aProduct in products)
	{
		if ([aProduct.reference isEqualToString:product.reference])
		{
			if ([product.category isEqualToString:@"pizza"])
			{
				if ([aProduct.sizeSelected isEqualToString:product.sizeSelected] && 
					[aProduct.pateSelected isEqualToString:product.pateSelected]) 
				{
					doublon = aProduct;
					contained=TRUE;
					break;
				}
			}else
			{
				doublon = aProduct;
				contained=TRUE;
				break;
			}
			
		}
	}
	
	if (contained)
	{
		doublon.quantite = [NSString stringWithFormat:@"%i", [doublon.quantite intValue] + 1];
	}else
	{
		[products addObject:product];
	}
	
	
	for (BAPProduct *aProduct in products)
	{
		NSLog(@"produit (%@) : %@ ", aProduct.name, aProduct.quantite);
	}

}


-(float)prixTotal{
    
    float total = 0;
    for (BAPProduct *aProduct in products){
        total = total + ([aProduct.quantite intValue]*[aProduct getPrice]);
    }
    return total;
}



/////////////////////////////// Validation  commande /////////////////////////////////

-(void)validerCommande:(UINavigationController *) nC {
    
    [Utiles startLoading:nC.view :NO];
    [BAPWSCommande	setDelegate:self];
    
    [BAPWSCommande addCommande:storeId :deliveryMethod :customerId :streetId];
    navigationController = nC;
}

-(void)commandeFinish:(NSString*)response
{
    NSLog(@"COMMANDE OK : %@", response);
    
    [Utiles stopLoading];
    [sellId release];
    sellId = [response retain];
    
    for(BAPProduct *product in products){
        
        [BAPWSCommande addProductToCommande:storeId :sellId :deliveryMethod :product.reference :product.quantite :product.pateSelected :product.sizeSelected];
    }
    
    BAPReductionViewController_iphone *reductionVC = [[BAPReductionViewController_iphone alloc] initWithNibName:@"BAPReductionViewController_iphone" bundle:[NSBundle mainBundle]];
    [navigationController pushViewController:reductionVC animated:NO];
    [reductionVC release];
}

-(void)commandeFail:(NSString*)response
{
    [Utiles stopLoading];
	NSLog(@"COMMANDE NOK : %@", response);
}

-(void)prodCommandeFinish:(NSString*)response
{
    [Utiles stopLoading];
	NSLog(@"ADDPRODUIT OK : %@", response);
}

-(void)prodCommandeFail:(NSString*)response
{
    [Utiles stopLoading];
	NSLog(@"ADDPRODUIT NOK : %@", response);
}
/////////////////////////////// Fin Validation  commande /////////////////////////////////




-(void)validerReduction:(UINavigationController *) nC :(BAPReduction *)coupon{
    
    //applique les reducs
    [Utiles startLoading:nC.view :NO];
    [BAPWSReduction	setDelegate:self];
    [BAPWSReduction appliquerCoupon:storeId :coupon.valeur];
   // navigationController = nC;
}

-(void)getAppliquerCouponsFinish:(NSString*)response
{
    NSLog(@"ApliquerCoupon OK : %@", response);
    [Utiles stopLoading];
}

-(void)getAppliquerCouponsFail:(NSString*)response
{
    NSLog(@"ApliquerCoupon NOK : %@", response);
    [Utiles stopLoading];
}



@end
