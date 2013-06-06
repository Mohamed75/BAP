//
//  BAPDeliveryViewController.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PickerWithToolBar.h"
#import "MyAlertLogin.h"
#import <MapKit/MapKit.h>


#define kDptAction 0
#define kCityAction 1
#define kStreetAction 2


@interface BAPDeliveryViewController_iphone : BAPParentViewController <PickerWithToolBarDelegate, MKMapViewDelegate>
{
	PickerWithToolBar	*picker;
	NSString 			*dptSelected;
	NSString 			*citySelected;
	NSString 			*streetSelected;
	NSString 			*storeSelected;
	NSMutableArray		*streetsId;
	NSArray				*cities;
	int					actionSelected;
	int					indexCitySelected;
	int					streetIdSelected;
    
    NSArray     *adressesArray;
    NSString 	*rueMap;
    int         initialisationMap;
}

@property (nonatomic, retain)   MyAlertLogin     *alertRueAdresse;
@property (nonatomic, retain)	IBOutlet	UILabel		*advertiseLbl;
@property (nonatomic, retain)	IBOutlet	UIView		*contentView;
@property (nonatomic, retain)	IBOutlet	UIButton	*addressBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*createBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*mapBtn;
@property (nonatomic, retain)	IBOutlet	UIView		*addressView;
@property (nonatomic, retain)	IBOutlet	UIView		*createView;
@property (nonatomic, retain)	IBOutlet	UIView		*mapView;
@property (nonatomic, retain)	IBOutlet	MKMapView   *map;

@property (nonatomic, retain) CLGeocoder *geoCoder;


-(IBAction)segmentBtnClicked:(UIButton*)btn;


//Saisie

@property (nonatomic, retain)	IBOutlet	UIButton	*dptBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*cityBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*streetBtn;

@property (nonatomic, retain)	IBOutlet	UITableView	*adressesTable;


-(IBAction)validBtnClicked;
-(IBAction)dptClicked:(id)sender;
-(IBAction)cityClicked:(id)sender;
-(IBAction)streetClicked:(id)sender;
-(void)getStreetFinish:(NSArray*)streets;
-(void)getStreetFail:(id)error;
-(void)setStoreSelected:(NSString*)store;

@end
