//
//  BAPRestaurantDetailViewController_iphone.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 03/04/13.
//
//

#import <UIKit/UIKit.h>
#import "BAPMenuViewController_iphone.h"
#import "BAPCommande.h"

@interface BAPRestaurantDetailViewController_iphone : BAPParentViewController


@property (nonatomic, retain)	IBOutlet	UILabel	*txtlbl;
@property (nonatomic, retain)	IBOutlet	UITextView	*txtView;

@property (nonatomic, retain)   NSDictionary    *store;

- (IBAction)consulterClicked:(id)sender;

@end
