//
//  BAPReductionViewController_iphone.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import <UIKit/UIKit.h>
#import "BAPFinalCmdViewController_iphone.h"
#import "BAPReductionCell_iphone.h"
#import "BAPWSReduction.h"


@interface BAPReductionViewController_iphone : BAPParentViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray	*reductionsArray;
}

@property (nonatomic, retain)	IBOutlet	UITableView	*reductionTable;

@end
