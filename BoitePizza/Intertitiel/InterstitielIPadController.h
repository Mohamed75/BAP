//
//  IntertetilController.h
//  WallStreetInst
//
//  Created by Mohamed on 11/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashUIImageView.h"

@class GestionInterstitiel;

@interface InterstitielIPadController : UIViewController {

    BOOL existe; 
    
    int savedSplashRandomNbr;
    int countInterst;
}

@property (nonatomic, retain) GestionInterstitiel  *delegate;


- (void)afficheSplashesImages:(NSArray *) actifImgs;
- (void)dismissSplash;

@end
