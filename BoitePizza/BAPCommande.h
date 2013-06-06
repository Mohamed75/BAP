//
//  BAPCommande.h
//  BoitePizza
//
//  Created by Mohammed on 04/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAPProduct.h"
#import "BAPReductionViewController_iphone.h"
#import "BAPReduction.h"


@interface BAPCommande : NSObject{
    
    UINavigationController *navigationController;
}

@property (nonatomic, retain)	NSString		*storeId;
@property (nonatomic, retain)	NSString		*streetId;  //streetName
@property (nonatomic, retain)	NSString		*customerId;
@property (nonatomic, retain)	NSString		*deliveryMethod;
@property (nonatomic, retain)	NSString		*category;
@property (nonatomic, retain)	NSMutableArray	*products;

@property (nonatomic, retain)   NSDate          *date;
@property (nonatomic, retain)	NSString		*sellId;
@property (nonatomic)   BOOL    valider;    //Finaliser
@property (nonatomic)   BOOL    commedhab;

+(void)initNotCommeDhab;
+(void)initCommeDhab;
+(void)setCommeDhab:(BAPCommande *)commande;
+(BAPCommande*)getCommeDhab;
+(NSMutableArray *)getCommandes;
+ (BAPCommande *)sharedInstance;

-(void)removeProduct:(BAPProduct *)product;
-(void)addProduct:(BAPProduct*)product;
-(float)prixTotal;

-(void)validerCommande  :(UINavigationController *) nC;
-(void)validerReduction :(UINavigationController *) nC :(BAPReduction *)coupon;

@end
