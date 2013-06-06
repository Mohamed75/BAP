//
//  BAPWSReduction.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 02/06/13.
//
//

#import "BAPWSReduction.h"

static NSObject	*delegate;


@implementation BAPWSReduction

+(void)setDelegate:(NSObject*)pDelegate
{
	delegate = pDelegate;
}

+(NSObject *)getDelegate
{
	return delegate;
}



+(void)getCouponsWithStoreId:(NSString*)storeId :(NSString *)sellId
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 storeId, @"store_name",
                                                     sellId, @"sell_id",
													 kSecret, @"secret",
													 nil];
    NSLog(@"couponsApplicable : %@, %@", storeId, sellId);
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kCouponApplicableMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(getCouponsFail:) withObject:@"request fail"];
		}else{
            [Utiles stopLoading];
            [Utiles connectionEchecMsg];
        }
        [jsonParser release];
	}];
	
	[connectRequest setCompletionBlock:^{
		SBJsonParser	*jsonParser			=		[SBJsonParser	new];
		
		if ([[jsonParser objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			NSDictionary	*theObject		=		[jsonParser	objectWithString:connectRequest.responseString];
			NSLog(@"couponsApplicable : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"]
                && ![[[theObject objectForKey:@"result"] objectForKey:@"result"] isKindOfClass:[NSNull class]])
			{
                NSMutableArray *result = [[NSMutableArray alloc] init];

                
				for (NSString *key in [[[theObject objectForKey:@"result"] objectForKey:@"result"] keyEnumerator])
				{
					NSDictionary *dico = [[[theObject objectForKey:@"result"] objectForKey:@"result"] objectForKey:key];
                    
                    if(![dico isKindOfClass:[NSNull class]]){
                        
                        BAPReduction *coupon = [[BAPReduction alloc] init];
                        coupon.reference = [dico objectForKey:@"coupon_id"];
                        coupon.name = [dico objectForKey:@"coupon_name"];
                        coupon.picture = [dico objectForKey:@"coupon_flyer"];
                        coupon.valeur = [dico objectForKey:@"coupon_url"];
                        
                        [result addObject:coupon];
                        [coupon release];
                    }
                }
                
				[delegate performSelector:@selector(getCouponsFinish:) withObject:[result autorelease]];
			}else
			{
				[delegate performSelector:@selector(getCouponsFail:) withObject:@"Aucun coupon"];
			}
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(getCouponsFail:) withObject:nil];
		}
		[jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
	[params release];
    [jsonWriter release];
}


+(void)appliquerCoupon:(NSString*)storeId :(NSString *)urlCoupon
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 storeId, @"store_name",
                                                     urlCoupon, @"coupon_url",
													 kSecret, @"secret",
													 nil];
    NSLog(@"appliquerCoupons : %@", params);
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kAppliquerCouponMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(getAppliquerCouponsFail:) withObject:@"request fail"];
		}else{
            [Utiles stopLoading];
            [Utiles connectionEchecMsg];
        }
        [jsonParser release];
	}];
	
	[connectRequest setCompletionBlock:^{
		SBJsonParser	*jsonParser			=		[SBJsonParser	new];
		
		if ([[jsonParser objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			NSDictionary	*theObject		=		[jsonParser	objectWithString:connectRequest.responseString];
			NSLog(@"appliquerCoupons : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]   && [[theObject objectForKey:@"result"] isKindOfClass:[NSDictionary class]]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"])
			{

                
				[delegate performSelector:@selector(getAppliquerCouponsFinish:) withObject:@""];
			}else
			{
				[delegate performSelector:@selector(getAppliquerCouponsFail:) withObject:@"Coupon Non Appliquer"];
			}
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(getAppliquerCouponsFail:) withObject:nil];
		}
		[jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
	[params release];
    [jsonWriter release];
}

@end
