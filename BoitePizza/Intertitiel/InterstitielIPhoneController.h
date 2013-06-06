//
//  InterstitielIPhoneController.h
//  SHIN
//
//  Created by Mohammed on 04/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashUIImageView.h"


@class GestionInterstitiel;

@interface InterstitielIPhoneController : UIViewController  {
 
    BOOL existe; 
    
    int savedSplashRandomNbr;
    int countInterst;
    
    SplashUIImageView *tempImageView;
}

@property (nonatomic, retain) GestionInterstitiel   *delegate;


- (void)afficheSplashesImages:(NSArray *) actifImgs;
- (void)dismissSplash;


@end
