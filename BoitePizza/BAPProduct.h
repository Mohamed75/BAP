//
//  BAPProduct.h
//  BoitePizza
//
//  Created by Mohammed on 04/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAPProduct : NSObject

@property (nonatomic, retain)	NSString	*reference;
@property (nonatomic, retain)	NSString	*name;
@property (nonatomic, retain)	NSString	*description;
@property (nonatomic, retain)	NSString	*picture;
@property (nonatomic, retain)	NSString	*priceSize1;
@property (nonatomic, retain)	NSString	*priceSize2;
@property (nonatomic, retain)	NSString	*priceSize3;
@property (nonatomic, retain)	NSString	*price;
@property (nonatomic, retain)	NSString	*category;
@property (nonatomic, retain)	NSString	*category2;
@property (nonatomic, retain)	NSString	*quantite;
@property (nonatomic, retain)	NSString	*sizeSelected;
@property (nonatomic, retain)	NSString	*pateSelected;
@property (nonatomic, retain)	NSString	*idSellProduit;

- (id)initWithProduct:(BAPProduct *)product;
-(float)getPrice;

@end
