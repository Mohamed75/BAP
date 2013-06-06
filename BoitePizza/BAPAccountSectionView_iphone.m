//
//  BAPAccountSectionView_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPAccountSectionView_iphone.h"

@implementation BAPAccountSectionView_iphone
@synthesize deleteBtn;
@synthesize sectionLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
	{
        // Initialization code
		
		self.backgroundColor			=	[UIColor	redColor];
		
		sectionLabel					=	[[[UILabel	alloc]	initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
		sectionLabel.font				=	[UIFont 	fontWithName:@"Futura-CondensedMedium" size:18];
		sectionLabel.textColor			=	[UIColor	 whiteColor];
		sectionLabel.backgroundColor	=	[UIColor	 clearColor];
		[self		addSubview:sectionLabel];
		
		deleteBtn						=	[UIButton	buttonWithType:UIButtonTypeRoundedRect];
		[deleteBtn				setFrame:CGRectMake(320, 2, 80, 26)];
		[deleteBtn				setTitle:@"Supprimer" forState:UIControlStateNormal];
		[deleteBtn.titleLabel	setFont:[UIFont	fontWithName:@"HelveticaNeue-Bold" size:13]];
		[deleteBtn.titleLabel	setTextColor:[UIColor	blackColor]];
		
		[self		addSubview:deleteBtn];
		
    }
    return self;
}

@end
