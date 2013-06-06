//
//  BAPAuthentification.m
//  BoitePizza
//
//  Created by Mohammed on 04/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPAuthentification.h"
#import "BAPWSAutres.h"


static NSObject	*delegate;


@implementation BAPAuthentification


+(void)setDelegate:(NSObject*)pDelegate
{
	delegate = pDelegate;
}

+(NSObject *)getDelegate
{
	return delegate;
}


+(void)accountConnectionWithEmail:(NSString*)email andPassword:(NSString*)password
{
	if ([email length] < 2 || [password length] < 2) 
	{
		[delegate performSelector:@selector(authentificationFail:) withObject:@"too short"];
		return;
	}
	
	bool connected = ([[[Utiles readDictionaryNamed:@"account"] objectForKey:@"form_action"] isEqualToString:@"update"]) ? TRUE : FALSE;
	if (connected) //identification via webService
	{
		[self realAccountConnectWithEmail:email andPassword:password];
	}else //"fake" identification
	{
		if ([[[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_email"] isEqualToString:email]
			&& [[[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_password"] isEqualToString:password])
		{
			[delegate performSelector:@selector(authentificationFinish:) withObject:@"local"];
		}else
		{
			NSLog(@"localConnect FAIL");
			[self realAccountConnectWithEmail:email andPassword:password];
		}
	}

}


// connection et save des adresses recupére du WS en dure
+(void)realAccountConnectWithEmail:(NSString*)email andPassword:(NSString*)password
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 email, @"email",
													 password, @"password",
													 kSecret, @"secret",
													 nil];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kConnectionMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(authentificationFail:) withObject:@"request fail"];
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
			NSLog(@"theObject : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"]
                && [[[theObject objectForKey:@"result"] objectForKey:@"result"] isKindOfClass:[NSDictionary class]])
			{
				NSMutableDictionary *account = [[NSMutableDictionary alloc]initWithDictionary:[[theObject objectForKey:@"result"] objectForKey:@"result"]];
				[account setObject:email forKey:@"customer_email"];
				[account setObject:password forKey:@"customer_password"];
				[account setObject:@"update" forKey:@"form_action"];
				
				if ([[[[theObject objectForKey:@"result"] objectForKey:@"result"] objectForKey:@"magsdelivery"] isKindOfClass:[NSNull class]])
				{
					[account setObject:[NSDictionary dictionary] forKey:@"magsdelivery"];
				}
				
				
				if ([[[[theObject objectForKey:@"result"] objectForKey:@"result"] objectForKey:@"magspickup"] isKindOfClass:[NSNull class]])
				{
					[account setObject:[NSDictionary dictionary] forKey:@"magspickup"];
				}
				
				
				[Utiles	writeDictionary:account named:@"account"];
                
                [BAPWSAutres setPush:[account objectForKey:@"customer_id"]];
                
				[account release];
				[delegate performSelector:@selector(authentificationFinish:) withObject:@"WS"];
                
			}else
			{
				[delegate performSelector:@selector(authentificationFail:) withObject:@"WS"];
			}
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(authentificationFail:) withObject:@"WS"];
		}
		[jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter release];
}


+(void)accountCreationWithEmail:(NSString*)email andPassword:(NSString*)password
{
	
	
}

// Cree un compte puit s y connecté [self realAccountConnectWithEmail]
+(void)accountCreationWithStreetId:(NSString*)streetId
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSMutableDictionary	*params				=		[[NSMutableDictionary alloc ] initWithDictionary:[Utiles readDictionaryNamed:@"account"]];
	
    int lastId = [BAPMethode getIndexMsgDelivrery:[params objectForKey:@"magsdelivery"]];
    if(lastId != 0) lastId = lastId - 1;
    
    NSDictionary *tempDeliv = [[params objectForKey:@"magsdelivery"] objectForKey:[NSString stringWithFormat:@"%i", lastId]];
    NSString *storeName = [tempDeliv objectForKey:@"customer_street_store_name"];
    NSString *adrsNum = [tempDeliv objectForKey:@"customer_street_address_number"];
    NSString *adrsBuild = [tempDeliv objectForKey:@"customer_street_address_building"];
    NSString *adrsBloc = [tempDeliv objectForKey:@"customer_street_address_bloc"];
    NSString *adrsSuite = [tempDeliv objectForKey:@"customer_street_address_suite"];
    NSString *adrsFloor = [tempDeliv objectForKey:@"customer_street_address_floor"];
    NSString *adrsGate = [tempDeliv objectForKey:@"customer_street_address_code_gate"];
    NSString *adrsEntry = [tempDeliv objectForKey:@"customer_street_address_code_entry"];
    NSString *adrsLift = [tempDeliv objectForKey:@"customer_street_address_code_lift"];
    
    if(storeName != nil)    [params setObject:storeName forKey:@"customer_store_name"];
    if(adrsNum != nil)    [params setObject:adrsNum forKey:@"customer_address_number"];
    if(adrsBuild != nil)    [params setObject:adrsBuild forKey:@"customer_address_building"];
    if(adrsBloc != nil)    [params setObject:adrsBloc forKey:@"customer_address_bloc"];
    if(adrsSuite != nil)    [params setObject:adrsSuite forKey:@"customer_address_suite"];
    if(adrsFloor != nil)    [params setObject:adrsFloor forKey:@"customer_address_floor"];
    if(adrsGate != nil)    [params setObject:adrsGate forKey:@"customer_address_code_gate"];
    if(adrsEntry != nil)    [params setObject:adrsEntry forKey:@"customer_address_code_entry"];
    if(adrsLift != nil)    [params setObject:adrsLift forKey:@"customer_address_code_lift"];
    
	[params setObject:streetId forKey:@"customer_address_street_id"];
	[params setObject:kSecret forKey:@"secret"];
    
    [params removeObjectForKey:@"magsdelivery"];
    [params removeObjectForKey:@"magspickup"];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kCreationMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
        [Utiles stopLoading];
        [Utiles connectionEchecMsg];
		[delegate performSelector:@selector(creationFail:) withObject:connectRequest.responseString];
	}];
	
	[connectRequest setCompletionBlock:^{
		SBJsonParser	*jsonParser			=		[SBJsonParser	new];
		
		if ([[jsonParser objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			NSDictionary	*theObject		=		[jsonParser	objectWithString:connectRequest.responseString];
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]) 
			{
                [self realAccountConnectWithEmail:[params objectForKey:@"customer_email"] andPassword:[params objectForKey:@"customer_password"]];
				[delegate performSelector:@selector(creationFinish:) withObject:[theObject objectForKey:@"result"]];
            }
            else{
                [Utiles stopLoading];
                [delegate performSelector:@selector(creationFail:) withObject:theObject];
            }
		}else{
            [Utiles stopLoading];
            [delegate performSelector:@selector(creationFail:) withObject:nil];
        }
        [jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter release];
}

+(void)lostPasswordWithEmail:(NSString*)email
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 email, @"email",
													 kSecret, @"secret",
													 nil];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kLostPasswordMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(lostPasswordFail:) withObject:@"request fail"];
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
			NSLog(@"theObject : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"]) 
			{
				
				[delegate performSelector:@selector(lostPasswordFinish:) withObject:@"WS"];
			}else
			{
				[delegate performSelector:@selector(lostPasswordFail:) withObject:@"WS"];
			}
			
			
		}else
		{
            [Utiles connectionEchecMsg];
			[delegate performSelector:@selector(lostPasswordFail:) withObject:@"WS"];
		}
		[jsonParser release];
	}];
	
	[connectRequest	startAsynchronous];
	[params release];
    [jsonWriter release];
}

+(void)getCategories
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params				=		[[NSDictionary alloc ] initWithObjectsAndKeys:
												 kSecret, @"secret", nil];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kGetCategoriesMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
        [Utiles stopLoading];
        [Utiles connectionEchecMsg];
		NSLog(@"getCategories fail : %@", connectRequest.error.description);
	}];
	
	[connectRequest setCompletionBlock:^{
		SBJsonParser	*jsonParser			=		[SBJsonParser	new];
		
		if ([[jsonParser objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			NSDictionary	*theObject		=		[jsonParser	objectWithString:connectRequest.responseString];
			//NSLog(@"Categories : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"]) 
			{
				
				[Utiles	writeDictionary:[[theObject objectForKey:@"result"] objectForKey:@"result"] named:@"categories"];
			}
		}
        [jsonParser dealloc];
        [url release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter dealloc];
}



+(void)getStores
{
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params				=		[[NSDictionary alloc ] initWithObjectsAndKeys:
												 kSecret, @"secret", nil];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kGetStoreMethod]];
	
	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
        [Utiles stopLoading];
        [Utiles connectionEchecMsg];
		NSLog(@"getStores fail : %@", connectRequest.error.description);
	}];
	
	[connectRequest setCompletionBlock:^{
		SBJsonParser	*jsonParser			=		[SBJsonParser	new];
		
		if ([[jsonParser objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			NSDictionary	*theObject		=		[jsonParser	objectWithString:connectRequest.responseString];
			//NSLog(@"Stores : %@", theObject);
			
			if ([[theObject objectForKey:@"succes"] isEqualToString:@"1"]
				&& [[[theObject objectForKey:@"result"] objectForKey:@"status"] isEqualToString:@"1"]) 
			{
				
				[Utiles	writeDictionary:[[theObject objectForKey:@"result"] objectForKey:@"result"] named:@"stores"];
			}
		}
        [jsonParser dealloc];
        [url release];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter dealloc];
}




+(void)getStreetWithCity:(NSString*)city
{
	NSDictionary *stores = [Utiles readDictionaryNamed:@"stores"];
	NSString *storeName = @"";
	for (NSString *key in [stores keyEnumerator])
	{
		if ([[[stores objectForKey:key] objectForKey:@"store_city"] isEqualToString:city])
		{
			storeName = key;
		}
	}
	
	[delegate performSelector:@selector(setStoreSelected:) withObject:storeName];
	
	if (stores == nil)
	{
		[delegate performSelector:@selector(getStreetFail:) withObject:@"request fail"];
		return;
	}
	SBJsonWriter	*jsonWriter				=		[SBJsonWriter	new];
	
	NSDictionary	*params					=		[[NSDictionary alloc ] initWithObjectsAndKeys:
													 storeName, @"store_name",
													 kSecret, @"secret",
													 nil];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServicesAppMaker, kGetStreetMethod]];

	ASIFormDataRequest *connectRequest	=	[ASIFormDataRequest requestWithURL:url];
	
	[connectRequest	setPostBody:(NSMutableData *)[[jsonWriter stringWithObject:params] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[connectRequest setFailedBlock:^{
		SBJsonParser	*jsonParser				=		[SBJsonParser	new];
		
		if ([[jsonParser	objectWithString:connectRequest.responseString] isKindOfClass:[NSDictionary class]])
		{
			[delegate performSelector:@selector(getStreetFail:) withObject:@"request fail"];
		}
        else{
            [delegate performSelector:@selector(getStreetFail:) withObject:@"request fail"];
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
				NSDictionary *streetsDict = [[NSDictionary alloc]initWithDictionary:[[theObject objectForKey:@"result"] objectForKey:@"result"]];
				
				NSMutableArray *streets = [[NSMutableArray alloc]init];
				
				for (NSString *key in [streetsDict keyEnumerator])
				{
					NSLog(@"street : %@", [streetsDict objectForKey:key]);
					NSDictionary *street = [[NSDictionary alloc] initWithObjectsAndKeys:
											[[streetsDict objectForKey:key] objectForKey:@"street_type"],@"type",
											[[streetsDict objectForKey:key] objectForKey:@"street_name"],@"name",
											[[streetsDict objectForKey:key] objectForKey:@"street_id"],@"id",
											nil];
					[streets addObject:street];
                    [street release];
				}
				
				[streets sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
				{
					return [[obj1 objectForKey:@"name"] caseInsensitiveCompare:[obj2 objectForKey:@"name"]];
				}];
				
                [streetsDict release];
				[delegate performSelector:@selector(getStreetFinish:) withObject:[streets autorelease]];
                
			}else
			{
				[delegate performSelector:@selector(getStreetFail:) withObject:theObject];
			}
			
		}else
		{
			[delegate performSelector:@selector(getStreetFail:) withObject:nil];
		}
		[jsonParser dealloc];
	}];
	
	[connectRequest	startAsynchronous];
    [params release];
    [jsonWriter dealloc];
}



@end
