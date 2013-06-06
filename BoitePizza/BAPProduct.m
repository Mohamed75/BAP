//
//  BAPProduct.m
//  BoitePizza
//
//  Created by Mohammed on 04/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPProduct.h"

@implementation BAPProduct

@synthesize reference;
@synthesize name,description;
@synthesize picture;
@synthesize priceSize1;
@synthesize priceSize2;
@synthesize priceSize3;
@synthesize price;
@synthesize category;
@synthesize category2;
@synthesize quantite;
@synthesize pateSelected;
@synthesize sizeSelected;
@synthesize idSellProduit;


-(void)dealloc{
 
    [reference release];
    [name release];
    [description release];
    [picture release];
    [priceSize1 release];
    [priceSize2 release];
    [priceSize3 release];
    [price release];
    [category release];
    [category2 release];
    [quantite release];
    [pateSelected release];
    [sizeSelected release];
    [idSellProduit release];
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        reference = @"";
		name = @"";
        description = @"";
		picture = @"";
		priceSize1 = @"";
		priceSize2 = @"";
		priceSize3 = @"";
		price = @"";
		category = @"";
        category2 = @"";
		quantite = @"1";
		pateSelected = @"";
		sizeSelected = @"";
		idSellProduit = @"";
    }
    return self;
}

- (id)initWithProduct:(BAPProduct *)product {
    self = [super init];
    if (self) {
        reference = [product.reference copy];
		name = [product.name copy];
        description = [product.description copy];
		picture = [product.picture copy];
		priceSize1 = [product.priceSize1 copy];
		priceSize2 = [product.priceSize2 copy];
		priceSize3 = [product.priceSize3 copy];
		price = [product.price copy];
		category = [product.category copy];
        category2 = [product.category2 copy];
		quantite = [product.quantite copy];
		pateSelected = [product.pateSelected copy];
		sizeSelected = [product.sizeSelected copy];
		idSellProduit = [product.idSellProduit copy];
    }
    return self;
}


-(float)getPrice{
    
    float priceF = 0;
    if ([category isEqualToString:@"pizza"])
	{
        if([sizeSelected isEqualToString:kMoyenne]){
            priceF = [priceSize1 floatValue];
        }
        else if ([sizeSelected isEqualToString:kMoyenne2]){
            priceF = [priceSize2 floatValue];
        }
        else{
            priceF = [priceSize3 floatValue];
        }
        
	}else
	{
        priceF = [price floatValue];
	}
    return priceF;
}

@end
