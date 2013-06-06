//
//  MyUIPageControlle.m
//  SHIN
//
//  Created by Mohammed on 08/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyUIPageControl.h"


@implementation MyUIPageControl
@synthesize imageNormal, imageCurrent;



- (void) updateDots
{
    if(imageNormal || imageCurrent)
    {
        // Get subviews
        NSArray* dotViews = self.subviews;
        for(int i = 0; i < dotViews.count; ++i)
        {
            UIImageView* dot = [dotViews objectAtIndex:i];
            // Set image
            if (i == self.currentPage) 
                dot.image = imageCurrent;
            else    
               if(imageNormal != NULL) dot.image = imageNormal;
        }
    }
}


/** override to update dots */
- (void) setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}

- (void) updateCurrentPageDisplay{
    
}
    
@end
