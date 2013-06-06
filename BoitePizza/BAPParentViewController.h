//
//  BAPParentViewController.h
//  BoitePizza
//
//  Created by Mohammed on 18/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum 
{
	RightBtnTypeModify 	= 1,
	RightBtnTypeCall 	= 2,
    RightBtnTypeContinue 	= 3
} RightBtnType ;

@interface BAPParentViewController : UIViewController
{
	UIButton	*leftBtn;
	UIButton	*rightBtn;
	BOOL		leftBtnShow;
	BOOL		rightBtnShow;
}


-(void)showLeftBtn:(BOOL)show withAnimation:(BOOL)animated;
-(void)showRightBtn:(BOOL)show;
-(void)setRightBtnType:(RightBtnType)rightBtnType;
-(void)leftBtnClicked;
-(void)rightBtnClicked;


@end
