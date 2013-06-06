//
//  BAPMenuDetailViewController_iphone.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAPCommande.h"

@interface BAPMenuDetailViewController_iphone : BAPParentViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
	NSArray     *productsArray;
	UIView      *blackMask;
	int         index;
    
    BAPProduct  *product;
    
    UIScrollView *scrollView;
    NSDictionary *productsDico;
    NSMutableArray *keysSubCat;
    
    int heightTailleView;
}

@property (nonatomic, retain)	IBOutlet	UITableView	*productsTable;
@property (nonatomic, retain)	IBOutlet	UIView      *tailleView;
@property (nonatomic, retain)	IBOutlet	UIButton	*tailleMoyenne;
@property (nonatomic, retain)	IBOutlet	UIButton	*tailleMoyenne2;
@property (nonatomic, retain)	IBOutlet	UIButton	*tailleGeante;
@property (nonatomic, retain)	IBOutlet	UIButton	*pateTradition;
@property (nonatomic, retain)	IBOutlet	UIButton	*pateFinissima;

@property (nonatomic)	BOOL	consultationMode;


-(void)getProductFinish:(NSArray*)products;
-(void)getProductFail:(NSObject*)object;

-(IBAction)btnsClicked:(id)sender;
-(IBAction)validClicked;
-(IBAction)cancelClicked;

@end
