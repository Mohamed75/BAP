//
//  BAPProductCell_iphone.m
//  BoitePizza
//
//  Created by Mohammed on 04/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPProductCell_iphone.h"


@implementation BAPProductCell_iphone

-(void)dealloc{
    
    [titleLbl removeFromSuperview];
    [titleLbl release];
    [img removeFromSuperview];
    [img dealloc];
    [descrLbl removeFromSuperview];
    [descrLbl dealloc];
    [aPartirLbl removeFromSuperview];
    [aPartirLbl dealloc];
    [priceLbl removeFromSuperview];
    [priceLbl dealloc];
    [panierImg removeFromSuperview];
    [panierImg dealloc];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    xImage = 0;   yImage = 0;
    withImg = 110;  heightImg = 84;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
    	img = [[AsyncUIImageView alloc] initWithFrame:CGRectMake(xImage, yImage, withImg, heightImg)];
		[self addSubview:img];
		
		
		
		titleLbl = [[UITextView alloc]initWithFrame:CGRectMake(105, 0, 160, 55)];
        titleLbl.userInteractionEnabled = NO;
		titleLbl.backgroundColor = [UIColor clearColor];
		titleLbl.textColor = [UIColor colorWithRed:0.82 green:0.11 blue:0.12 alpha:1.0];
        titleLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
		titleLbl.text = @"PIZZAAAA";
		[self addSubview:titleLbl];

		
		
		descrLbl = [[UILabel alloc]initWithFrame:CGRectMake(115, 30, 160, 55)];
		descrLbl.backgroundColor = [UIColor clearColor];
		descrLbl.textColor = [UIColor blackColor];
		descrLbl.numberOfLines = 3;
		descrLbl.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
		descrLbl.text = @"PIZZAAAA DESCRIPTIIOONNN";
		[self addSubview:descrLbl];
		
		
		aPartirLbl = [[UILabel alloc]initWithFrame:CGRectMake(260, 5, 60, 10)];
		aPartirLbl.textAlignment = UITextAlignmentCenter;
		aPartirLbl.backgroundColor = [UIColor clearColor];
		aPartirLbl.textColor = [UIColor colorWithRed:0.82 green:0.11 blue:0.12 alpha:1.0];
		aPartirLbl.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
		aPartirLbl.text = @"à partir de";
		[self addSubview:aPartirLbl];
		
		
		
		priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(260, 15, 60, 20)];
		priceLbl.textAlignment = UITextAlignmentCenter;
		priceLbl.backgroundColor = [UIColor clearColor];
		priceLbl.textColor = [UIColor colorWithRed:0.82 green:0.11 blue:0.12 alpha:1.0];
		priceLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
		priceLbl.text = @"35€92";
		[self addSubview:priceLbl];
		
		
		panierImg = [[UIImageView alloc] initWithFrame:CGRectMake(275, 40, 40, 40)];
		[panierImg setImage:[UIImage imageNamed:@"btn-panier"]];
		[self	addSubview:panierImg];
		
		
	}
    return self;
}


-(void)setCellWithInfos:(BAPProduct*)product
{
	titleLbl.text = [product.name capitalizedString];
	descrLbl.text = [product.description capitalizedString];
	if ([product.category isEqualToString:catPizza])
	{
		priceLbl.text = [NSString stringWithFormat:@"%.2f €",[product.priceSize1 floatValue]];
		
	}else
	{
		priceLbl.text = [NSString stringWithFormat:@"%.2f €",[product.price floatValue]];
        aPartirLbl.text = @"prix unitaire";
	}
        
	
	[img		removeFromSuperview];
	[img		release];
	img			=	nil;
	  
    if([product.category isEqualToString:catMenu])    {
        
        titleLbl.frame = CGRectMake(20, -6, 190, 30);
        xImage = 18;    yImage = 23;
        withImg = 188;  heightImg = 61.5;
        UIView *colorView = [[UIView alloc] initWithFrame:self.frame];
        colorView.backgroundColor = [UIColor grayColor];
        self.backgroundView = colorView;
        [colorView release];
    }
    
    int nomJeuSizeTxtView = (([ titleLbl.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]]).width / 155);
    if(nomJeuSizeTxtView > 0){
        descrLbl.frame = CGRectMake(115, 40, 160, 55);
        descrLbl.numberOfLines = 2;
    }
        
	img = [[AsyncUIImageView alloc] initWithFrame:CGRectMake(xImage, yImage, withImg, heightImg)];
	[img			setWithLoadingPanel:TRUE];
	[img loadWithContentsOfUrl:[NSURL URLWithString:product.picture] storedImageName:product.name];
	
	[self		addSubview:img];
	
}


@end
