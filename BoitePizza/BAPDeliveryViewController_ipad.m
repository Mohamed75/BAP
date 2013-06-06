//
//  BAPDeliveryViewController_ipad.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 21/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPDeliveryViewController_ipad.h"
#import "BAPAuthentification.h"


@implementation BAPDeliveryViewController_ipad


@synthesize contentView;
@synthesize addressBtn;
@synthesize createBtn;
@synthesize mapBtn;
@synthesize addressView;
@synthesize createView;
@synthesize mapView;
@synthesize dptBtn;
@synthesize cityBtn;
@synthesize streetBtn;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super 	viewDidLoad];
	
	contentView.userInteractionEnabled	=	TRUE;
	streetSelected = @"";
	[contentView				addSubview:createView];
	
    [BAPAuthentification	setDelegate:self];
    
	picker = [[PickerWithToolBar alloc] init];
	picker.delegate = self;
	[picker setRowHeight:40];
	CGRect frame = picker.frame;
	frame.origin.y = self.view.frame.size.height;
	[picker setFrame:frame];
	
	[self.view addSubview:picker];
	
	actionSelected = kDptAction;
	
}


#pragma mark -
#pragma mark Actions

-(IBAction)segmentBtnClicked:(UIButton*)btn
{
	if (btn.selected)
		return;
	
	addressBtn.selected	=	FALSE;
	createBtn.selected	=	FALSE;
	mapBtn.selected		=	FALSE;
	btn.selected		=	TRUE;
	
	for (UIView *toRemove in [contentView subviews])
		[toRemove		removeFromSuperview];
	
	if ([btn isEqual:addressBtn])
	{
		[contentView	addSubview:addressView];
	}else if ([btn isEqual:createBtn])
	{
		[contentView	addSubview:createView];
	}else if ([btn isEqual:mapBtn])
	{
		[contentView	addSubview:mapView];
	} 
	
}

-(IBAction)validBtnClicked
{/*
	NSLog(@"account : %@", [Utiles readDictionaryNamed:@"account"]);
	
	if ([BAPMethode accountValidForCreation] && [streetSelected length] > 1)
	{
        
		[BAPAuthentification accountCreationWithStreetId:[NSString stringWithFormat:@"%i", streetIdSelected]];
	}else
	{
		NSLog(@"WTF");
	}
	*/
	
	return;
}

#pragma mark -
#pragma mark Saisie

-(IBAction)dptClicked:(id)sender
{
	actionSelected = kDptAction;
	
	[picker setContent:[BAPMethode getDpt]];
	[UIView animateWithDuration:0.3 
					 animations:^
	 {
		 CGRect frame = picker.frame;
		 frame.origin.y -= frame.size.height;
		 [picker setFrame:frame];
	 }
					 completion:^(BOOL finish){    }];
	
}

-(IBAction)cityClicked:(id)sender
{
	actionSelected = kCityAction;
	
	[picker setContent:[BAPMethode getCityWithDpt:dptSelected]];
	[UIView animateWithDuration:0.3 
					 animations:^
	 {
		 CGRect frame = picker.frame;
		 frame.origin.y -= frame.size.height;
		 [picker setFrame:frame];
	 }
					 completion:^(BOOL finish){    }];
}

-(IBAction)streetClicked:(id)sender
{
	actionSelected = kStreetAction;
	[BAPAuthentification getStreetWithCity:citySelected];
	[Utiles startLoading:self.view :FALSE];
}

#pragma mark -
#pragma mark getStreetDelegate

-(void)getStreetFinish:(NSArray*)streets
{
	NSMutableArray *streetsName = [[NSMutableArray alloc] init];
	
	[streetsId release];
	streetsId = nil;
	streetsId = [[NSMutableArray alloc] init];
	
	for (NSDictionary *street in streets)
	{
		[streetsName addObject:[NSString stringWithFormat:@"%@ %@",
								[street objectForKey:@"type"],
								[street objectForKey:@"name"]]];
		[streetsId addObject:[street objectForKey:@"id"]];
	}
	
	
	[picker setContent:streetsName];
	[streetsName release];
	
	[Utiles stopLoading];
	[UIView animateWithDuration:0.3 
					 animations:^
	 {
		 CGRect frame = picker.frame;
		 frame.origin.y -= frame.size.height;
		 [picker setFrame:frame];
	 }
					 completion:^(BOOL finish){    }];
}

-(void)getStreetFail:(id)error
{
	[Utiles stopLoading];
	
}

#pragma mark -
#pragma mark accountCreationDelegate

-(void)creationFinish:(NSObject*)response
{
	NSLog(@"creation : %@", response);
	UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Félicitation"
														   message:@"Votre compte a bien été créé"
														  delegate:nil
												 cancelButtonTitle:@"Ok"
												 otherButtonTitles:nil];
	[alertEvent		show];
	[alertEvent		release];
	
	NSLog(@"goToMenu");
}

-(void)creationFail:(NSDictionary*)response
{
	NSLog(@"creation NOK : %@", response);
}



#pragma mark -
#pragma mark pickerDelegate

-(void)pickerCancel
{
	
}

-(void)pickerValidWithTitle:(NSString*)title forRow:(int)index
{
	[UIView animateWithDuration:0.3 
					 animations:^
	 {
		 CGRect frame = picker.frame;
		 frame.origin.y += frame.size.height;
		 [picker setFrame:frame];
	 }
					 completion:^(BOOL finish){    }];
	switch (actionSelected)
	{
		case kDptAction:
			dptSelected = [title copy];
			[dptBtn setTitle:title forState:UIControlStateNormal];
			[cityBtn setTitle:@"Ville" forState:UIControlStateNormal];
			[streetBtn setTitle:@"Rue" forState:UIControlStateNormal];
			cityBtn.enabled = TRUE;
			streetBtn.enabled = FALSE;
			streetSelected = @"";
			break;
		case kCityAction:
			citySelected = [title copy];
			[cityBtn setTitle:title forState:UIControlStateNormal];
			[streetBtn setTitle:@"Rue" forState:UIControlStateNormal];
			streetBtn.enabled = TRUE;
			streetSelected = @"";
			break;
		case kStreetAction:
			streetSelected = [title copy];
			streetIdSelected = index;
			[streetBtn setTitle:title forState:UIControlStateNormal];
			break;
			
		default:
			break;
	}
}


@end
