//
//  AsyncUIImageView.h
//  IClaps
//
//  Created by Mohammed
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AsyncUIImageViewDelegate;

@interface AsyncUIImageView : UIImageView {
    NSURLConnection* myconnection;
    NSMutableData* data;
	NSString* imageFileName;
	BOOL isSquare;
	BOOL premiereImage;
	NSInteger timerCreatedImage;
//	NSObject *app;
	UIView *loadingPanel;
	
}
@property (nonatomic, retain) NSString * imageFileName;
@property (nonatomic) BOOL isSquare;
@property (nonatomic) BOOL withLoadingPanel;
@property  (nonatomic) NSInteger timerCreatedImage;
@property (nonatomic, retain)NSObject <AsyncUIImageViewDelegate> *m_delegate;
//@property (nonatomic, retain) NSObject *app;

- (void)loadWithContentsOfUrl:(NSURL *)url storedImageName:(NSString *)imageName;

@end


@protocol AsyncUIImageViewDelegate
@optional

-(void)imageViewFinishLoading:(AsyncUIImageView*)pImageViewLoaded;

@end