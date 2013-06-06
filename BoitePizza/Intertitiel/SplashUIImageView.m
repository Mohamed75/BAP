//
//  AsyncUIImageView.m
//  IClaps
//
//  Created by Florent ROBIN on 22/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SplashUIImageView.h"

@implementation SplashUIImageView
@synthesize imageFileName, isSquare,timerCreatedImage,app,loadingPanel, activity,rotate,delegate;


-(void)createLoadingImageView:(CGRect)frame{
	
	loadingPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
	loadingPanel.backgroundColor = [UIColor clearColor];
	
	if(frame.size.height > 40 && frame.size.width > 40)	activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	else	activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	CGPoint point; 
	if(!rotate){
		point.x = loadingPanel.center.x;		
		point.y = loadingPanel.center.y+60;	
	}else {
		point.x = loadingPanel.center.y+40;		
		point.y = loadingPanel.center.x-10;	
	}
	activity.center = point;
	[loadingPanel addSubview:activity];
	[activity startAnimating];
	[activity release];
}


- (void)loadWithContentsOfUrl:(NSURL *)url storedImageName:(NSString *)imageName{
	
	premiereImage = NO;
	if(url != nil){
        self.backgroundColor = [UIColor clearColor];

		self.imageFileName = imageName;
		self.isSquare = YES;
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		UIImage *img = [UIImage imageWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:imageName]];
        if(img == nil) img = [UIImage imageNamed:imageName];
		if(img == nil){
            
			if (myconnection != nil) { 
				[myconnection release]; 
			}
			if (data != nil) { 
				[data release]; 
			}
            
			[self createLoadingImageView:self.frame];
			[self addSubview:loadingPanel];
			NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
			myconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
			if (myconnection) {
				data = [[NSMutableData data] retain];
			}
		}
		else {
			self.image = img;
			[delegate performSelector:@selector(dismissSplash) withObject:nil afterDelay:0];
		}	
	}else{
		self.image = [UIImage imageNamed:imageName];
		[delegate performSelector:@selector(dismissSplash) withObject:nil afterDelay:0];
	}
}



- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if(data	!= nil)
		[data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    [myconnection release];
	[loadingPanel removeFromSuperview];
    myconnection = nil;
	if(premiereImage != YES){
		if(data != nil && [data length] != 0){		
			NSError *error;
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			NSString *saveImagePath = [documentsDirectory stringByAppendingPathComponent:self.imageFileName];
			if(self.imageFileName)
				[data writeToFile:saveImagePath options:NSAtomicWrite error:&error];
			UIImage *img = nil;
			if(self.imageFileName != nil)
				img = [UIImage imageWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:self.imageFileName]];
			else
				img = [UIImage imageWithData:data];
			if(img != nil){
				
				self.image = img;
			}
		}
	}else{UIImage *img = [UIImage imageWithData:data];  self.image = img;
	}	
	[delegate performSelector:@selector(dismissSplash) withObject:nil afterDelay:0];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	
    [delegate performSelector:@selector(dismissSplash) withObject:nil afterDelay:0];
	//[activity stopAnimating];
    [myconnection release];
	myconnection = nil;
    [data release];
	data = nil;
}



- (void)dealloc {
	[loadingPanel release];
	[imageFileName release];
    if(myconnection != nil)	{
        [myconnection cancel];
		[myconnection release];
	}
    if(data != nil)[data release];
    [super dealloc];
}


@end
