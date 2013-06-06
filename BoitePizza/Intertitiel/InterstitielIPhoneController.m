//
//  InterstitielIPhoneController.m
//  SHIN
//
//  Created by Mohammed on 04/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InterstitielIPhoneController.h"
#import "GestionInterstitiel.h"


@implementation InterstitielIPhoneController
@synthesize delegate;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
    savedSplashRandomNbr = -1;
    countInterst = 0;
    
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    if(self.view.frame.size.height > 480)
        imgView.frame = CGRectMake(0, 20, 320, self.view.frame.size.height-20);
    
    NSString *imgName = @"Default.png";
    imgView.image = [UIImage imageNamed:imgName];
    [self.view addSubview:[imgView autorelease]];
	
	if(delegate.offresSpeciales == NULL || delegate.offresSpeciales.count == 0){
        
        existe = false;
        [delegate performSelector:@selector(endInterteciel) withObject:nil];
	}else   {
        
        existe = true;
        [self afficheSplashesImages:delegate.offresSpeciales];
    }
}


-(void)endGetInterstitielModel:(NSArray *) data {
    
    if(data != NULL){
        delegate.offresSpeciales = [data retain];
        [self afficheSplashesImages:delegate.offresSpeciales];
        
    }else   [delegate performSelector:@selector(endInterteciel) withObject:nil];
}


-(void)initInterstitiel:(NSArray *) actifImgs{
    
    int splashRandomNbr = 0;
    if([actifImgs count] > 1)	splashRandomNbr = random() % ([actifImgs count]);
    if(splashRandomNbr != savedSplashRandomNbr) {
        savedSplashRandomNbr = splashRandomNbr;
        NSString *urlString = [actifImgs objectAtIndex:splashRandomNbr];
    
        tempImageView = [[SplashUIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        tempImageView.delegate = self;
        NSArray *tempArray = [urlString componentsSeparatedByString:@"/"];
        NSString *imageNameStore = [NSString stringWithFormat:@"%@%@",[tempArray objectAtIndex:tempArray.count-2], [tempArray lastObject]];
        [tempImageView loadWithContentsOfUrl:[NSURL URLWithString:urlString] storedImageName:imageNameStore];
    }else   [self initInterstitiel:actifImgs];
}

- (void)afficheSplashesImages:(NSArray *) actifImgs {

	if(actifImgs != NULL && [actifImgs count] > 0)  [self performSelector:@selector(initInterstitiel:) withObject:actifImgs afterDelay:3];
    else	[delegate performSelector:@selector(endInterteciel) withObject:nil];
}

-(void)oneInterstitielAnim{
    
    [UIView transitionWithView: self.view
                      duration: 0.5
                       options: UIViewAnimationOptionTransitionFlipFromLeft
                    animations: ^{  [tempImageView removeFromSuperview]; }
                    completion: nil];
    [UIView commitAnimations];
    
    [delegate performSelector:@selector(endInterteciel) withObject:nil afterDelay:2];
}


- (void)dismissSplash {

    countInterst += 1;
    if(countInterst == 1){
        [UIView transitionWithView: self.view
                          duration: 0.5
                           options: UIViewAnimationOptionTransitionFlipFromRight
                        animations: ^{ [self.view addSubview:tempImageView]; }
                        completion: nil];
        [UIView commitAnimations];
    }else{
        [UIView transitionWithView: self.view
                          duration: 0.5
                           options: UIViewAnimationOptionTransitionFlipFromLeft
                        animations: ^{ [self.view addSubview:tempImageView]; }
                        completion: nil];
        [UIView commitAnimations];
    }
    
	if(delegate.offresSpeciales.count == 1)     [self performSelector:@selector(oneInterstitielAnim) withObject:nil afterDelay:2];
    else if(delegate.offresSpeciales.count > 1)    {
       if(countInterst < 2) [self performSelector:@selector(initInterstitiel:) withObject:delegate.offresSpeciales afterDelay:2];
       else    [delegate performSelector:@selector(endInterteciel) withObject:nil afterDelay:2];
    }
	
}


- (void)dealloc {
    
    if(tempImageView != nil)    [tempImageView release];
    [super dealloc];
}


@end
