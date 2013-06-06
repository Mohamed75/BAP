//
//  BAPOrderViewController_iphone.h
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAPCommande.h"
#import "MyUIPageControl.h"


@interface BAPOrderViewController_iphone : BAPParentViewController <UIScrollViewDelegate>
{
	UIScrollView *scrollView;
    MyUIPageControl *pageControl;
}

-(IBAction)comDHabClicked;
-(IBAction)emporterClicked;
-(IBAction)livraisonClicked;

@end
