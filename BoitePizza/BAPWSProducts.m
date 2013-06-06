//
//  BAPWSProducts.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 29/05/13.
//
//

#import "BAPWSProducts.h"

static NSObject	*delegate;

@implementation BAPWSProducts

+(void)setDelegate:(NSObject*)pDelegate
{
	delegate = pDelegate;
}

+(NSObject *)getDelegate
{
	return delegate;
}



+(void)getProductWithStoreId:(NSString*)storeId andCategory:(NSString*)category
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 storeId, @"store_name",
													 category, @"category",
													 kSecret, @"secret",
													 nil];
    
    NSLog(@"getProduct Params : %@", params);
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kGetProductsMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(getProductFail:) withObject:@"request fail"];
		}
        else{
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
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"]
                && ![[[theObject objectForKey:@"result"] objectForKey:@"result"] isKindOfClass:[NSNull class]])
			{
				
				NSMutableArray *array = [[NSMutableArray alloc] init];
				
				for (NSString *key in [[[theObject objectForKey:@"result"] objectForKey:@"result"] keyEnumerator])
				{
					NSDictionary *prodDict = [[[theObject objectForKey:@"result"] objectForKey:@"result"] objectForKey:key];
					
					BAPProduct *product = [[BAPProduct alloc] init];
					
					product.reference = [prodDict objectForKey:@"item_reference"];
					product.name = [prodDict objectForKey:@"item_name"];
					product.picture = [prodDict objectForKey:@"item_picture"];
					if ([category isEqualToString:@"pizza"])
					{
						product.priceSize1 = [prodDict objectForKey:@"item_price_sell_pizza_size_1"];
						product.priceSize2 = [prodDict objectForKey:@"item_price_sell_pizza_size_2"];
						product.priceSize3 = [prodDict objectForKey:@"item_price_sell_pizza_size_3"];
                        if([[prodDict objectForKey:@"item_pizza_composition"] isKindOfClass:[NSString class]])
                            product.description = [prodDict objectForKey:@"item_pizza_composition"];
                    }else
					{
						product.price	   = [prodDict objectForKey:@"item_price_sell"];
                        
					}
					
					product.category = category;
					product.category2 = [prodDict objectForKey:@"item_category2_pizza"];
                    
					[array addObject:product];
					
					
					[product release];
				}
				
				[array sortUsingComparator:^NSComparisonResult(BAPProduct *obj1, BAPProduct *obj2) {
					return [obj1.name compare:obj2.name];
				}];
				
				[delegate performSelector:@selector(getProductFinish:) withObject:array];
                [array dealloc];
			}else
			{
				NSLog(@"getProducts FAIIIILLLLL: %@", theObject);
				[delegate performSelector:@selector(getProductFail:) withObject:theObject];
			}
            
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(getProductFail:) withObject:nil];
		}
        
		[jsonParser release];
        [url release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter release];
}


+(void)getMenusWithStoreId:(NSString*)storeId
{	
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 storeId, @"store_name",
													 kSecret, @"secret",
													 nil];
    NSLog(@"getMenu Params : %@", params);
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kGetMenusMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(getProductFail:) withObject:@"request fail"];
		}
        else{
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
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"]
                && ![[[theObject objectForKey:@"result"] objectForKey:@"result"] isKindOfClass:[NSNull class]])
			{
				
				NSMutableArray *array = [[NSMutableArray alloc] init];
				
				for (NSString *key in [[[theObject objectForKey:@"result"] objectForKey:@"result"] keyEnumerator])
				{
					NSDictionary *prodDict = [[[theObject objectForKey:@"result"] objectForKey:@"result"] objectForKey:key];
					
					BAPProduct *product = [[BAPProduct alloc] init];
					
					product.reference = [prodDict objectForKey:@"item_reference"];
					product.name = [prodDict objectForKey:@"item_name"];
					product.picture = [prodDict objectForKey:@"item_picture"];
					product.price	   = [prodDict objectForKey:@"item_price_sell"];
					product.category = catMenu;
                    
					[array addObject:product];
					
					
					[product release];
				}
				
				[array sortUsingComparator:^NSComparisonResult(BAPProduct *obj1, BAPProduct *obj2) {
					return [obj1.name compare:obj2.name];
				}];
				
				[delegate performSelector:@selector(getProductFinish:) withObject:[array autorelease]];
			}else
			{
				NSLog(@"getMenu Fail: %@", theObject);
				[delegate performSelector:@selector(getProductFail:) withObject:theObject];
			}
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(getProductFail:) withObject:nil];
		}
		[jsonParser release];
        [url release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter release];
    [connectRequest autorelease];
}


+(void)getAccompagnementWithStoreId:(NSString*)storeId
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 storeId, @"store_name",
													 kSecret, @"secret",
													 nil];
    NSLog(@"getAccompagnement Params : %@", params);
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kGetAccompagnementMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(getProductFail:) withObject:@"request fail"];
		}
        else{
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
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
                && ![[[theObject objectForKey:@"result"] objectAtIndex:0] isKindOfClass:[NSNull class]])
			{
                NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
                
				for(NSDictionary *dico in [theObject objectForKey:@"result"]){
                    
                    if(![[dico objectForKey:@"products"] isKindOfClass:[NSNull class]]){
                        
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        
                        for (NSString *key in [[dico objectForKey:@"products"] keyEnumerator])
                        {
                            NSDictionary *prodDict = [[dico objectForKey:@"products"] objectForKey:key];
                            
                            BAPProduct *product = [[BAPProduct alloc] init];
                            
                            product.reference = [prodDict objectForKey:@"item_reference"];
                            product.name = [prodDict objectForKey:@"item_name"];
                            product.picture = [prodDict objectForKey:@"item_picture"];
                            product.price	   = [prodDict objectForKey:@"item_price_sell"];
                            product.category = catAccomp;
                            
                            [array addObject:product];
                            
                            
                            [product release];
                        }
                        
                        [array sortUsingComparator:^NSComparisonResult(BAPProduct *obj1, BAPProduct *obj2) {
                            return [obj1.name compare:obj2.name];
                        }];
                        
                        [result setObject:array forKey:[dico objectForKey:@"sousrub"]];
                        [array release];
                    }
                }
				
				
				[delegate performSelector:@selector(getProductFinish:) withObject:[result autorelease]];
			}else
			{
				NSLog(@"getAccompagnement Fail: %@", theObject);
				[delegate performSelector:@selector(getProductFail:) withObject:theObject];
			}
			
		}else
		{
			[delegate performSelector:@selector(getProductFail:) withObject:nil];
		}
		[jsonParser release];
        [url release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter release];
    [connectRequest autorelease];
}


+(void)getFoodCollectionWithStoreId:(NSString*)storeId
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 storeId, @"store_name",
													 kSecret, @"secret",
													 nil];
    NSLog(@"getFoodCollection Params : %@", params);
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kGetFoodCollectionMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(getProductFail:) withObject:@"request fail"];
		}
        else{
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
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"] && ![[theObject objectForKey:@"result"]  isKindOfClass:[NSNull class]]
                && ![[[theObject objectForKey:@"result"] objectAtIndex:0] isKindOfClass:[NSNull class]])
			{
                NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
                
				for(NSDictionary *dico in [theObject objectForKey:@"result"]){
                    
                    if(![[dico objectForKey:@"products"] isKindOfClass:[NSNull class]]){
                        
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        
                        for (NSString *key in [[dico objectForKey:@"products"] keyEnumerator])
                        {
                            NSDictionary *prodDict = [[dico objectForKey:@"products"] objectForKey:key];
                            
                            BAPProduct *product = [[BAPProduct alloc] init];
                            
                            product.reference = [prodDict objectForKey:@"item_reference"];
                            product.name = [prodDict objectForKey:@"item_name"];
                            product.picture = [prodDict objectForKey:@"item_picture"];
                            product.price	   = [prodDict objectForKey:@"item_price_sell"];
                            product.category = catFood;
                            
                            [array addObject:product];
                            
                            
                            [product release];
                        }
                        
                        [array sortUsingComparator:^NSComparisonResult(BAPProduct *obj1, BAPProduct *obj2) {
                            return [obj1.name compare:obj2.name];
                        }];
                        
                        [result setObject:array forKey:[dico objectForKey:@"sousrub"]];
                        [array release];
                    }
                }
				
				
				[delegate performSelector:@selector(getProductFinish:) withObject:[result autorelease]];
			}else
			{
				NSLog(@"getFoodCollection Fail: %@", theObject);
				[delegate performSelector:@selector(getProductFail:) withObject:theObject];
			}
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(getProductFail:) withObject:nil];
		}
		[jsonParser release];
        [url release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter release];
    [connectRequest autorelease];
}







+(void)getListPanierStoreName:(NSString*)storeName andSellId:(NSString*)sellId
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 storeName, @"store_name",
                                                     sellId, @"sell_id",
													 kSecret, @"secret",
													 nil];
    NSLog(@"getListPanier Params : %@", params);
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kListerPanierMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(getListPanierFail:) withObject:@"request fail"];
		}
        else{
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
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[theObject objectForKey:@"result"] isKindOfClass:[NSDictionary class]])
			{
				/*
                 NSMutableArray *array = [[NSMutableArray alloc] init];
                 
                 for (NSString *key in [[[theObject objectForKey:@"result"] objectForKey:@"result"] keyEnumerator])
                 {
                 NSDictionary *prodDict = [[[theObject objectForKey:@"result"] objectForKey:@"result"] objectForKey:key];
                 
                 BAPProduct *product = [[BAPProduct alloc] init];
                 
                 product.reference = [prodDict objectForKey:@"item_reference"];
                 product.name = [prodDict objectForKey:@"item_name"];
                 product.picture = [prodDict objectForKey:@"item_picture"];
                 product.price	   = [prodDict objectForKey:@"item_price_sell"];
                 
                 [array addObject:product];
                 
                 
                 [product release];
                 }
                 
                 [array sortUsingComparator:^NSComparisonResult(BAPProduct *obj1, BAPProduct *obj2) {
                 return [obj1.name compare:obj2.name];
                 }];
                 
                 */
                 
                 [delegate performSelector:@selector(getListPanierFinish:) withObject:@""];
                 
            }else
			{
				NSLog(@"ListPanier Fail: %@", theObject);
				[delegate performSelector:@selector(getListPanierFail:) withObject:theObject];
			}
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(getListPanierFail:) withObject:nil];
		}
		[jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter release];
}



@end
