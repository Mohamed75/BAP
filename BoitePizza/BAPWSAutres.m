//
//  BAPWSAutres.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 02/06/13.
//
//

#import "BAPWSAutres.h"


@implementation BAPWSAutres

+(void)getIntersticielWS
{
    
    SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSMutableDictionary	*params				=		[[NSMutableDictionary alloc ] init];
	
    if([Utiles isIpad])
        [params setObject:@"ipad" forKey:@"device"];
    else
        [params setObject:@"iphone" forKey:@"device"];
    
	[params setObject:kSecret forKey:@"secret"];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kInterstitiel]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
        [[Utiles delegate] applicationDidFinishLaunchingSuite];
        [Utiles connectionEchecMsg];
	}];
	
	[connectRequest setCompletionBlock:^{
		SBJsonParser	*jsonParser			=		[SBJsonParser	new];
		
		if ([[jsonParser objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			NSDictionary	*theObject		=		[jsonParser	objectWithString:connectRequest.responseString];
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"])
			{
				GestionInterstitiel *gestionaireInterstitiel = [GestionInterstitiel sharedInstance];
                gestionaireInterstitiel.offresSpeciales = [[[NSArray alloc] initWithObjects:[theObject objectForKey:@"result"], nil] autorelease];
                //  gestionInterstitiel.offresSpeciales = [[NSArray alloc] initWithObjects:@"http://fashionecstasy.com/wp-content/uploads/2013/02/Eligible-Magazine-iPad-Launch-with-Michael-Stagliano-and-Emily-Tuchscherer-from-Bachelor-Pad-1-1024x681.jpg",nil];
                [gestionaireInterstitiel run:NO];
			}
		}
        [jsonParser release];
	}];
    
    [params release];
    [jsonWriter release];
	
	[connectRequest	startAsynchronous];
}


// Methode appeler par BapAuthentification -> realAccountConnectWithEmail
+(void)setPush:(NSString *)user_id
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    // Attempt to find a name for this application
    NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
    }
    NSString *appVersion = nil;
	NSString *marketingVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *developmentVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
	if (marketingVersionNumber && developmentVersionNumber) {
		if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
			appVersion = marketingVersionNumber;
		} else {
			appVersion = [NSString stringWithFormat:@"%@ rv:%@",marketingVersionNumber,developmentVersionNumber];
		}
	} else {
		appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
	}
    
    UIDevice *device        = [UIDevice currentDevice];
    NSString *deviceName    = [device name];
    NSString *deviceModel   = [device model];
    NSString *deviceversion = [device systemVersion];
    
    
	SBJsonWriter	*jsonWriter			=		[SBJsonWriter	new];
	
    NSDictionary    *dico               =       [Utiles readDictionaryNamed:@"apnsCode"];
	NSDictionary	*params				=		[[NSDictionary alloc ] initWithObjectsAndKeys:
                                                 appName, @"appname",
                                                 appVersion, @"appversion",
                                                 @"", @"deviceuid",
												 deviceName, @"devicename",
                                                 deviceModel, @"devicemodel",
                                                 deviceversion, @"deviceversion",
                                                 user_id, @"user_id",
                                                 @"true", @"pushbadge",
                                                 @"true", @"pushalert",
                                                 @"true", @"pushsound",
                                                 [dico objectForKey:@"apns"], @"devicetoken",
                                                 kSecret, @"secret", nil];
	
    NSLog(@"PushService Params : %@", params);
    
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kPushMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
        [Utiles connectionEchecMsg];
		NSLog(@"setPush fail : %@", connectRequest.error.description);
	}];
	
	[connectRequest setCompletionBlock:^{
		SBJsonParser	*jsonParser			=		[SBJsonParser	new];
		
		if ([[jsonParser objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			NSDictionary	*theObject		=		[jsonParser	objectWithString:connectRequest.responseString];
			NSLog(@"PushService : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"])
			{
				
			}
		}
        [jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter release];
}



@end
