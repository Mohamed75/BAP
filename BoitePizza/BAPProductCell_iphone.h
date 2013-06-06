//
//  BAPProductCell_iphone.h
//  BoitePizza
//
//  Created by Mohammed on 04/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncUIImageView.h"
#import "BAPProduct.h"

@interface BAPProductCell_iphone : UITableViewCell
{
	AsyncUIImageView	*img;
	UITextView			*titleLbl;
	UILabel				*descrLbl;
	UILabel				*aPartirLbl;
	UILabel				*priceLbl;
	UIImageView			*panierImg;
    
    int xImage, yImage;
    int withImg, heightImg;
}


-(void)setCellWithInfos:(BAPProduct*)product;


@end
