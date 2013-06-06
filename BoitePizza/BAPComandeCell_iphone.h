//
//  BAPComandeCell.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 28/03/13.
//
//

#import <UIKit/UIKit.h>
#import "AsyncUIImageView.h"
#import "BAPProduct.h"


@interface BAPComandeCell_iphone : UITableViewCell
{
    UIImageView			*bgImg;
    AsyncUIImageView	*img;
	UILabel				*titleLbl;
	UILabel				*descrLbl;
    UILabel				*qtLbl;
	UILabel				*priceLbl;
    UILabel				*priceTotalLbl;
    UIButton            *plusBtn;
    UIButton            *moinBtn;
    
    BAPProduct *tempProduct;
    
    int xImage, yImage;
    int withImg, heightImg;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier FM:(BOOL)finalMode;
-(void)setCellWithInfos:(BAPProduct*)product;

@end
