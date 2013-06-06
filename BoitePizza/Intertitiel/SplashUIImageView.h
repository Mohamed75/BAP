//
//  AsyncUIImageView.h
//  IClaps
//
//  Created by Florent ROBIN on 22/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol mainAppDelegate
@required
-(void)applicationdidFinishLaunchingSuite;
@end


@interface SplashUIImageView : UIImageView {
    
    NSURLConnection* myconnection;
    NSMutableData* data;
	NSString* imageFileName;
	BOOL isSquare,rotate;
	BOOL premiereImage;
	NSInteger timerCreatedImage;
	NSObject *app;
    
}


@property (nonatomic, retain) NSString * imageFileName;
@property (nonatomic) BOOL isSquare,rotate;
@property  (nonatomic) NSInteger timerCreatedImage;
@property (nonatomic, retain) NSObject *app;
@property (nonatomic, retain) UIView *loadingPanel;
@property (nonatomic, retain) UIActivityIndicatorView *activity;
@property (nonatomic, retain) NSObject *delegate;

- (void)loadWithContentsOfUrl:(NSURL *)url storedImageName:(NSString *)imageName;

@end
