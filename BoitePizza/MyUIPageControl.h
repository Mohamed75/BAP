//
//  MyUIPageControlle.h
//  SHIN
//
//  Created by Mohammed on 08/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUIPageControl : UIPageControl {
    
}

@property (nonatomic, readwrite, retain) UIImage* imageNormal;
@property (nonatomic, readwrite, retain) UIImage* imageCurrent;

- (void) setCurrentPage:(NSInteger)currentPage;
- (void) updateCurrentPageDisplay;

@end
