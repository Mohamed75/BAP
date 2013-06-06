//
//  BAPReductionCell_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import "BAPReductionCell_iphone.h"

@implementation BAPReductionCell_iphone
@synthesize titleLbl;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
    	img = [[AsyncUIImageView alloc] initWithFrame:CGRectMake(35, 5, 250, 82.5)];
		[self addSubview:img];
        
    }
    return self;
}

-(void)setCellWithInfos:(BAPReduction*)reduction;
{
    
    [img		removeFromSuperview];
	[img		release];
	img			=	nil;
    
    img = [[AsyncUIImageView alloc] initWithFrame:CGRectMake(35, 5, 250, 82.5)];
	[img			setWithLoadingPanel:TRUE];
	[img loadWithContentsOfUrl:[NSURL URLWithString:reduction.picture] storedImageName:reduction.name];
	
	[self		addSubview:img];
}

@end
