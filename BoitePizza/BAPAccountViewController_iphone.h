//
//  BAPAccountViewController_iphone.h
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAPAuthentification.h"

@interface BAPAccountViewController_iphone : BAPParentViewController <UITableViewDataSource, UITableViewDelegate>
{
	BOOL				modifying;
	NSMutableArray		*addressArray;
}

@property (nonatomic, retain)	IBOutlet	UITableView	*accountTable;

@end
