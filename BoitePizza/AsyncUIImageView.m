//
//  AsyncUIImageView.m
//  IClaps
//
//  Created by Mohammed on 22/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AsyncUIImageView.h"

@implementation AsyncUIImageView
@synthesize imageFileName, isSquare,timerCreatedImage,m_delegate, withLoadingPanel;//,app;


-(void)createLoadingImageView:(CGRect)frame
{
	
	loadingPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
	loadingPanel.backgroundColor = [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.36] autorelease];
	UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	CGPoint point; point.x = loadingPanel.center.x;		point.y = loadingPanel.center.y;	
	activity.center = point;
	[loadingPanel addSubview:activity];
	[activity startAnimating];
	[activity release];
}

- (void)loadWithContentsOfUrl:(NSURL *)url storedImageName:(NSString *)imageName{
	
	premiereImage = NO;
	if(url != nil){
		self.imageFileName = imageName;
		self.isSquare = YES;
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		UIImage *img = [UIImage imageWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:imageName]];
		if(img == nil){
			//NSLog(@"No image");
			if (myconnection != nil) { 
				[myconnection release]; 
			}
			if (data != nil) { 
				[data release]; 
			}
			if (withLoadingPanel)
			{
				[self createLoadingImageView:self.frame];
				[self addSubview:loadingPanel];
			}
			
			NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
			myconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
			if (myconnection) {
				data = [[NSMutableData data] retain] ;
			}
		}
		else {
			//NSLog(@"Got the image");
			self.image = img;
		}	
	}else{
		self.image = [UIImage imageNamed:imageName];
	}
}



- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData 
{
	if(data	!= nil)
		[data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection 
{
    [myconnection release];
	if (withLoadingPanel)
		[loadingPanel removeFromSuperview];
    myconnection = nil;
	if(premiereImage != YES)
	{
		if(data != nil && [data length] != 0)
		{	
			NSError *error;
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			NSString *saveImagePath = [documentsDirectory stringByAppendingPathComponent:self.imageFileName];
			if(self.imageFileName)
			{
				[data writeToFile:saveImagePath options:NSAtomicWrite error:&error];
			}
			UIImage *img = nil;
			if(self.imageFileName != nil)
				img = [UIImage imageWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:self.imageFileName]];
			else
				img = [UIImage imageWithData:data];
			if(img != nil)
			{
				self.image = img;
			}
		}
	}else
	{
		UIImage *img = [UIImage imageWithData:data];
		self.image = img;
	}
	
	if (m_delegate && [m_delegate respondsToSelector:@selector(imageViewFinishLoading:)])
		[m_delegate	imageViewFinishLoading:self];
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [myconnection release];
	myconnection = nil;
    [data release];
	data = nil;
}

- (void)dealloc 
{
	//NSLog(@"%@ dealloc",[self class] );
	[loadingPanel	release];
	[imageFileName	release];
    [myconnection	cancel];
    [myconnection	release];
    [data			release];
    [super dealloc];
}


@end
