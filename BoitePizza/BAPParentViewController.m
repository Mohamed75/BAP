//
//  BAPParentViewController.m
//  BoitePizza
//
//  Created by Mohammed on 18/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPParentViewController.h"

@interface BAPParentViewController ()

@end

@implementation BAPParentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
		leftBtnShow		=	FALSE;
		rightBtnShow	=	FALSE;
        
        if  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
        {
            [[UINavigationBar	appearance] setContentMode:UIViewContentModeScaleAspectFill];
            [[UINavigationBar	appearance] setBackgroundImage:[UIImage imageNamed:@"bg-navbar"] forBarMetrics:UIBarMetricsDefault];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	rightBtn			=	[[UIButton			alloc]	initWithFrame:CGRectMake(242, 0, 78, 44)];
	leftBtn				=	[[UIButton			alloc]	initWithFrame:CGRectMake(0, 0, 78, 44)];

	rightBtn.tag		=	RightBtnTypeCall;
	
	[rightBtn setImage:[UIImage imageNamed:@"btn-appeler"] 
			  forState:UIControlStateNormal];

	[leftBtn setImage:[UIImage imageNamed:@"btn-retour"]
			 forState:UIControlStateNormal];

	[rightBtn addTarget:self
				 action:@selector(rightBtnClicked)
	   forControlEvents:UIControlEventTouchUpInside];
	
	[leftBtn addTarget:self
				action:@selector(leftBtnClicked)
	  forControlEvents:UIControlEventTouchUpInside];	
	
	self.navigationItem.hidesBackButton		=	TRUE;
	[self.navigationController.navigationBar	addSubview:leftBtn];
	[self.navigationController.navigationBar	addSubview:rightBtn];
}


-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	rightBtn.hidden	=	!rightBtnShow;
	leftBtn.hidden	=	!leftBtnShow;
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	rightBtn.hidden	=	TRUE;
	leftBtn.hidden	=	TRUE;
}

-(void)showLeftBtn:(BOOL)show withAnimation:(BOOL)animated
{
	leftBtn.hidden	=	!show;
	leftBtnShow		=	show;
	
	if (show && animated)
	{
		leftBtn.alpha = 0.0;
		[leftBtn setCenter:CGPointMake(leftBtn.center.x + 120, leftBtn.center.y)];
		[UIView animateWithDuration:0.3 
						 animations:^{[leftBtn setCenter:CGPointMake(leftBtn.center.x - 120, leftBtn.center.y)]; leftBtn.alpha = 1.0;}
						 completion:^(BOOL finish){    }];
	}
}

-(void)showRightBtn:(BOOL)show
{
	if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:0100000000"]] && rightBtn.tag == RightBtnTypeCall)
	{
		rightBtnShow	=	FALSE;
		rightBtn.hidden	=	TRUE;
	}else
	{
		rightBtnShow	=	show;
		rightBtn.hidden	=	!show;
	}
}

-(void)setRightBtnType:(RightBtnType)rightBtnType
{
	rightBtn.tag		=	rightBtnType;
	
	if (rightBtnType == RightBtnTypeCall)
		[rightBtn			setImage:[UIImage	imageNamed:@"btn-appeler"]	forState:UIControlStateNormal];
	else if (rightBtnType == RightBtnTypeModify)
		[rightBtn			setImage:[UIImage	imageNamed:@"btn-modifier"]	forState:UIControlStateNormal];
    else
        [rightBtn			setImage:[UIImage	imageNamed:@"btn-continuer"]	forState:UIControlStateNormal];
}

-(void)leftBtnClicked
{
	[self.navigationController	popViewControllerAnimated:YES];
}

-(void)rightBtnClicked
{
	if (rightBtn.tag == RightBtnTypeCall)
	{
		
	}else if (rightBtn.tag == RightBtnTypeModify)
	{
		
	}
}

#pragma mark -
#pragma mark Dealloc

-(void)dealloc
{
    [rightBtn	release];
	[leftBtn	release];
	
    [super dealloc];
}


@end
