//
//  BAPCartViewController_iphone.h
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAPComandeCell_iphone.h"
#import "BAPCommande.h"
#import "BAPAutresViewController_iphone.h"
#import "BAPFinalCmdViewController_iphone.h"


@interface BAPCartViewController_iphone : BAPParentViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray		*cartesArray;
}


@property (nonatomic, retain)	IBOutlet	UITableView	*carteTable;

@property (nonatomic, retain)   NSString 	*validationlMode;
@property (nonatomic)           BOOL 		tabBarMode;


@end
