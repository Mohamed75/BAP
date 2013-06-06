//
//  BAPAutresDetailViewController_iphone.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 29/03/13.
//
//

#import <UIKit/UIKit.h>
#import "BAPCommande.h"
#import "BAPAuthentification.h"
#import "BAPProductCell_iphone.h"
#import "BAPCartViewController_iphone.h"


@interface BAPAutresDetailViewController_iphone : BAPParentViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray	*autresArray;
    
}


@property (nonatomic, retain)	IBOutlet	UITableView	*autresTable;

@property (nonatomic, assign)  NSString 			*category;

@end
