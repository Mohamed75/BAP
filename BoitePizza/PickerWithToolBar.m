//
//  PickerWithToolBar.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 07/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PickerWithToolBar.h"

@implementation PickerWithToolBar

@synthesize rowHeight, content, delegate;


- (void)dealloc{

    [content release];
    [super dealloc];
}


- (id)init
{
    self = [super init];
    if (self) 
	{
		rowHeight = 40;
		rowSelected = 0;
		content = [[NSArray alloc] init];
		
		[self setFrame:CGRectMake(0, 0, 320, 216+40)];
		
		UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		toolBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
		
		UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(320 - 110 - 10, 5, 110, 30)];
		[okBtn setImage:[Utiles	imageNamed:@"btn-valider-red"] forState:UIControlStateNormal];
		[okBtn addTarget:self action:@selector(okClicked) forControlEvents:UIControlEventTouchUpInside];
		[toolBar addSubview:okBtn];
		[okBtn release];
		
		[self addSubview:toolBar];
        [toolBar release];
		
		picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 216)];
		picker.showsSelectionIndicator = TRUE;
		picker.delegate = self;
		picker.dataSource = self;
		[self addSubview:picker];
		[picker release];
    }
    return self;
}

#pragma mark Actions

-(void)okClicked
{
	if (delegate != nil)
	{
		[delegate pickerValidWithTitle:[content objectAtIndex:rowSelected] forRow:rowSelected];
	}
}


-(void)cancelClicked
{
	if (delegate != nil)
	{
		[delegate pickerCancel];
	}
}

#pragma mark Setters

-(void)setContent:(NSArray *)pContent
{
	[content release];
	content = nil;
	
	content = [[NSArray alloc] initWithArray:pContent];
	rowSelected = 0;
    [picker selectRow:0 inComponent:0 animated:NO];
	[picker reloadAllComponents];
}

-(void)setRowHeight:(float)pRowHeight
{
	rowHeight = pRowHeight;
	[picker reloadAllComponents];
}

#pragma mark UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return rowHeight;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [content objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	rowSelected = row;
}


#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [content count];
}

@end
