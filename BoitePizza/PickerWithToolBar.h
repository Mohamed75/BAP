//
//  PickerWithToolBar.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 07/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerWithToolBarDelegate;

@interface PickerWithToolBar : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
{
	UIPickerView *picker;
	int rowSelected;
}


@property (nonatomic, readwrite)	float	rowHeight;
@property (nonatomic, retain)		NSArray	*content;
@property (nonatomic, assign)		NSObject<PickerWithToolBarDelegate> *delegate;

-(void)okClicked;
-(void)cancelClicked;

@end

@protocol PickerWithToolBarDelegate

-(void)pickerCancel;
-(void)pickerValidWithTitle:(NSString*)title forRow:(int)index;

@end
