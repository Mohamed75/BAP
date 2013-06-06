//
//  BAPAccountCell_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPAccountCell_iphone.h"

@implementation BAPAccountCell_iphone

@synthesize titleLbl;
@synthesize valueField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
		titleLbl							=	[[UILabel		alloc]	initWithFrame:CGRectMake(10, 0, 150, 60)];
		valueField							=	[[UITextField	alloc]	initWithFrame:CGRectMake(150, 20, 170, 20)];
		valueField.userInteractionEnabled	=	FALSE;

		
		[self	addSubview:titleLbl];
		[self	addSubview:valueField];
		
		
    }
    return self;
}



@end
