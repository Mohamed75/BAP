//
//  BAPReductionCell_iphone.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import <UIKit/UIKit.h>
#import "AsyncUIImageView.h"
#import "BAPReduction.h"

@interface BAPReductionCell_iphone : UITableViewCell
{
    AsyncUIImageView	*img;
}

@property (nonatomic, retain)	UILabel		*titleLbl;

-(void)setCellWithInfos:(BAPReduction*)reduction;

@end
