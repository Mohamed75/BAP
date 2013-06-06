//
//  SpecialAnnotation.m
//  Micromania
//
//  Created by Mohamed on 15/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpecialAnnotation.h"


@implementation SpecialAnnotation
@synthesize coordinate;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {/*
		UIImageView *temp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map2"]];
		//temp.frame = CGRectMake(temp.frame.origin.x-30, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
		[self  addSubview:temp];
		self.backgroundColor = [UIColor clearColor];
		[temp release];
        */
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        [btn setImage:[UIImage	imageNamed:@"map2"]	forState:0];
        [btn addTarget:self action:@selector(rightBtnClicked)
           forControlEvents:UIControlEventTouchUpInside];
        [self  addSubview:btn];
        self.frame = CGRectMake(0, 0, 80, 50);
		[btn release];
        
    }
    return self;
}

-(void)rightBtnClicked
{
	self.selected = true;
}


- (void)setAnnotation:(id <MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

}


@end
