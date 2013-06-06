//
//  BAPRestaurantListViewController.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BAPRestaurantDetailViewController_iphone.h"
#import "BAPMenuViewController_iphone.h"
#import "BAPCommande.h"
#import <MapKit/MapKit.h>


@interface BAPRestaurantListViewController_iphone : BAPParentViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>
{
    NSArray  *stores;
    NSArray  *indexArray;
    
    int initialisationMap;
}

@property (nonatomic, retain)	IBOutlet	UIButton	*listBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*mapBtn;
@property (nonatomic, retain)	IBOutlet	UIView		*contentView;
@property (nonatomic, retain)	IBOutlet	MKMapView	*mapV;
@property (nonatomic, retain)	IBOutlet	UITableView	*listView;


-(IBAction)segmentBtnClicked:(UIButton*)btn;


@end
