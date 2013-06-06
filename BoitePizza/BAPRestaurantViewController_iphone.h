//
//  BAPRestaurantViewController_iphone.h
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAPRestaurantDetailViewController_iphone.h"

@interface BAPRestaurantViewController_iphone : BAPParentViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray  *stores;
    NSArray  *indexArray;
}

@property (nonatomic, retain)	IBOutlet	UITableView	*storesTable;

@end
