//
//  BAPDeliveryViewController_ipad.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 21/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PickerWithToolBar.h"

#define kDptAction 0
#define kCityAction 1
#define kStreetAction 2


@interface BAPDeliveryViewController_ipad : UIViewController <PickerWithToolBarDelegate>
{
	PickerWithToolBar	*picker;
	NSString 			*dptSelected;
	NSString 			*citySelected;
	NSString 			*streetSelected;
	NSString 			*storeSelected;
	NSMutableArray		*streetsId;
	int					actionSelected;
	int					streetIdSelected;
}


@property (nonatomic, retain)	IBOutlet	UIView		*contentView;
@property (nonatomic, retain)	IBOutlet	UIButton	*addressBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*createBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*mapBtn;
@property (nonatomic, retain)	IBOutlet	UIView		*addressView;
@property (nonatomic, retain)	IBOutlet	UIView		*createView;
@property (nonatomic, retain)	IBOutlet	UIView		*mapView;

-(IBAction)segmentBtnClicked:(UIButton*)btn;


//Saisie

@property (nonatomic, retain)	IBOutlet	UIButton	*dptBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*cityBtn;
@property (nonatomic, retain)	IBOutlet	UIButton	*streetBtn;

-(IBAction)validBtnClicked;
-(IBAction)dptClicked:(id)sender;
-(IBAction)cityClicked:(id)sender;
-(IBAction)streetClicked:(id)sender;
-(void)getStreetFinish:(NSArray*)streets;
-(void)getStreetFail:(id)error;


@end
