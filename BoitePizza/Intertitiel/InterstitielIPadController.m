    //
//  IntertetilController.m
//  WallStreetInst
//
//  Created by Mohamed on 11/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InterstitielIPadController.h"
#import "GestionInterstitiel.h"


@implementation InterstitielIPadController
@synthesize delegate;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    self.view.frame = [UIScreen mainScreen].bounds;
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgView.image = [UIImage imageNamed:@"init-Landscape-iPad"];
    [self.view addSubview:[imgView autorelease]];
	
	if(delegate.offresSpeciales == NULL || delegate.offresSpeciales.count == 0){
        
        existe = false;
        [delegate performSelector:@selector(endInterteciel) withObject:nil];
	}else   {
        
        existe = true;
        [self afficheSplashesImages:delegate.offresSpeciales];
    }
    
}


- (void)afficheSplashesImages:(NSArray *) actifImgs {
	
	srandom(time(NULL));
	
	if([actifImgs count] > 0){
		
		int splashRandomNbr = 0;
		if([actifImgs count] != 1)	splashRandomNbr = random() % ([actifImgs count]);
		NSString *urlString = [actifImgs objectAtIndex:splashRandomNbr];
			
        SplashUIImageView *tempImageView = [[SplashUIImageView alloc]initWithFrame:self.view.frame];
		tempImageView.delegate = self;
		NSString *imageNameStore = [[urlString componentsSeparatedByString:@"/"] lastObject];
		[tempImageView loadWithContentsOfUrl:[NSURL URLWithString:urlString] storedImageName:imageNameStore];
       
        tempImageView.activity.center = CGPointMake(500, 360);
        
        tempImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        tempImageView.frame = CGRectMake(0, 0, tempImageView.frame.size.height, tempImageView.frame.size.width);
        
        [self.view addSubview:[tempImageView autorelease]];
		
	}else	[delegate performSelector:@selector(endInterteciel) withObject:nil afterDelay:0];
}



- (void)dismissSplash {
	
    [self.view setAlpha:0.0];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];	
    [self.view setAlpha:1]; //this will change the newView alpha from its previous zero value to 0.5f
	[UIView commitAnimations];	
	
	[delegate performSelector:@selector(endInterteciel) withObject:nil afterDelay:5];
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) foo
{
    return YES; // all interface orientations supported
}

- (void)dealloc {
    
    [super dealloc];
}


@end
