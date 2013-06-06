//
//  BAPWSCommande.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 29/05/13.
//
//

#import "BAPWSCommande.h"

static NSObject	*delegate;

@implementation BAPWSCommande


+(void)setDelegate:(NSObject*)pDelegate
{
	delegate = pDelegate;
}

+(NSObject *)getDelegate
{
	return delegate;
}



+(void)addCommande:(NSString*)store :(NSString*)mode :(NSString*)customerId :(NSString*)streetId
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 store, @"store_name",
                                                     mode, @"sell_method",
                                                     customerId, @"sell_customer_id",
                                                     streetId, @"sell_customer_street_id",
													 kSecret, @"secret",
													 nil];
	
    NSLog(@"ADDCommande Params : %@", params);
    
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kSellAddMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(commandeFail:) withObject:@"request fail"];
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
			NSLog(@"AddCommande : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"])
			{
				NSString *sellId = [[theObject objectForKey:@"result"] objectForKey:@"sell_id"];
				[delegate performSelector:@selector(commandeFinish:) withObject:sellId];
			}else
			{
				[delegate performSelector:@selector(commandeFail:) withObject:@"WS"];
			}
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(commandeFail:) withObject:@"WS"];
		}
		[jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
	[params release];
    [jsonWriter release];
}


+(void)addProductToCommande:(NSString*)store :(NSString*)sellId :(NSString*)mode :(NSString*)itemRef :(NSString*)itemQt
                           :(NSString*)pate :(NSString*)taille
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 store, @"store_name",
                                                     sellId, @"sell_id",
                                                     mode, @"sell_method",
                                                     itemRef, @"item_reference",
                                                     itemQt, @"item_quantity",
                                                     pate, @"item_crust",
                                                     taille, @"item_size",
													 kSecret, @"secret",
													 nil];
	
    NSLog(@"ADDProductToCommande Params : %@", params);
    
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kItemAddMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(prodCommandeFail:) withObject:@"request fail"];
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
			NSLog(@"AddProdToCommande : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"])
			{
                NSString *sellcart_id = [[theObject objectForKey:@"result"] objectForKey:@"sellcart_id"];
				[delegate performSelector:@selector(prodCommandeFinish:) withObject:sellcart_id];
			}else
			{
				[delegate performSelector:@selector(prodCommandeFail:) withObject:@"WS"];
			}
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(prodCommandeFail:) withObject:@"WS"];
		}
		[jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
	[params release];
    [jsonWriter release];
}

@end
