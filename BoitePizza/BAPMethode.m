//
//  BAPMethode.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import "BAPMethode.h"

@implementation BAPMethode


+(void)createEmptyAccount
{
	[Utiles		deleteDictionaryNamed:@"account"];
	
	NSDictionary *magsDelivery = [NSDictionary dictionaryWithObjectsAndKeys:
								  @"", @"customer_street_address_bloc",
								  @"", @"customer_street_address_building",
								  @"", @"customer_street_address_city",
								  @"", @"customer_street_address_code_entry",
								  @"", @"customer_street_address_code_gate",
								  @"", @"customer_street_address_code_lift",
								  @"", @"customer_street_address_floor",
								  @"", @"customer_street_address_number",
								  @"", @"customer_street_address_postcode",
								  @"", @"customer_street_address_street",
								  @"", @"customer_street_address_street_type",
								  @"", @"customer_street_address_suite",
								  @"", @"customer_street_address_to",
								  @"", @"customer_street_id",
								  @"", @"customer_street_store_name",
								  nil];
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							@"save",					@"form_action",
							@"",						@"customer_email",
							@"",						@"customer_password",
							@"",						@"customer_firstname",
							@"",						@"customer_id",
							@"",						@"customer_mobile",
							@"",						@"customer_name",
							@"",						@"customer_phone",
							[NSDictionary dictionaryWithObject:magsDelivery forKey:@"0"],	@"magsdelivery",
							[NSDictionary dictionary],	@"magspickup",
							nil];
	[Utiles writeDictionary:params named:@"account"];
}


+(int)getIndexMsgDelivrery:(NSDictionary *)msgDelivrery{
    
    int newId = 0;
	
	for (NSString *key in msgDelivrery)
	{
		if ([key intValue] == 0)
		{
			newId = 0;
			break;
		}
		if ([key intValue] >= newId)
			newId = [key intValue] + 1;
	}
    return newId;
}

+(void)accountAddStore:(NSString*)store{
    
    NSMutableDictionary *account = [[NSMutableDictionary alloc] initWithDictionary:[Utiles readDictionaryNamed:@"account"]];
    
    NSMutableDictionary *stores = [[NSMutableDictionary alloc] initWithDictionary:[account objectForKey:@"magspickup"]];
	[stores setObject:store forKey:store];
	[account setObject:stores forKey:@"magspickup"];
	[stores release];
    
    [Utiles writeDictionary:account named:@"account"];
	
	[account	release];
}


+(void)accountAddStore:(NSString*)store
				   zip:(NSString*)zip
				  city:(NSString*)city
			 andStreet:(NSString*)street
             numStreet:(NSString *)num
{
	
	NSMutableDictionary *account = [[NSMutableDictionary alloc] initWithDictionary:[Utiles readDictionaryNamed:@"account"]];
	
	
    int newId = [self getIndexMsgDelivrery:[account objectForKey:@"magsdelivery"]];
	NSDictionary *magsDelivery = [NSDictionary dictionaryWithObjectsAndKeys:
								  @"", @"customer_street_address_bloc",
								  @"", @"customer_street_address_building",
								  city, @"customer_street_address_city",
								  @"", @"customer_street_address_code_entry",
								  @"", @"customer_street_address_code_gate",
								  @"", @"customer_street_address_code_lift",
								  @"", @"customer_street_address_floor",
								  num, @"customer_street_address_number",
								  zip, @"customer_street_address_postcode",
								  street, @"customer_street_address_street",
								  @"", @"customer_street_address_street_type",
								  @"", @"customer_street_address_suite",
								  @"", @"customer_street_address_to",
								  [NSString stringWithFormat:@"%i", newId], @"customer_street_id",
								  store, @"customer_street_store_name",
								  nil];
	
	NSMutableDictionary *magsDeliveries = [[NSMutableDictionary alloc] initWithDictionary:[account objectForKey:@"magsdelivery"]];	
	[magsDeliveries setObject:magsDelivery forKey:[NSString stringWithFormat:@"%i", newId]];
	[account setObject:magsDeliveries forKey:@"magsdelivery"];
	[magsDeliveries release];
	
	[Utiles writeDictionary:account named:@"account"];
	
	[account	release];
	
}



+(void)saveParametre:(NSString*)name :(NSString*)fName :(NSString*)mobile :(NSString*)building
                    :(NSString*)bloc :(NSString*)floor :(NSString*)cEntry :(NSString*)cLift
                    :(NSString*)cGate :(NSString*)streetIdSelected{
    
    NSMutableDictionary *account = [[NSMutableDictionary alloc] initWithDictionary:[Utiles readDictionaryNamed:@"account"]];
	
	
	int lastId = [self getIndexMsgDelivrery:[account objectForKey:@"magsdelivery"]];
    if(lastId != 0) lastId = lastId - 1;
    
	NSMutableDictionary *magsDelivery = [[NSMutableDictionary alloc] initWithDictionary:[[account objectForKey:@"magsdelivery"] objectForKey:[NSString stringWithFormat:@"%i", lastId]]];
    [magsDelivery setObject:building forKey:@"customer_street_address_building"];
    [magsDelivery setObject:bloc forKey:@"customer_street_address_bloc"];
    [magsDelivery setObject:floor forKey:@"customer_street_address_floor"];
    [magsDelivery setObject:cEntry forKey:@"customer_street_address_code_entry"];
    [magsDelivery setObject:cLift forKey:@"customer_street_address_code_lift"];
    [magsDelivery setObject:cGate forKey:@"customer_street_address_code_gate"];
    [magsDelivery setObject:streetIdSelected forKey:@"customer_street_id"];
    
	
	NSMutableDictionary *magsDeliveries = [[NSMutableDictionary alloc] initWithDictionary:[account objectForKey:@"magsdelivery"]];
	[magsDeliveries setObject:magsDelivery forKey:[NSString stringWithFormat:@"%i", lastId]];
	[account setObject:magsDeliveries forKey:@"magsdelivery"];
	[magsDeliveries release];
    [magsDelivery release];
    
    [account setObject:name forKey:@"customer_name"];
    [account setObject:fName forKey:@"customer_firstname"];
    [account setObject:mobile forKey:@"customer_mobile"];
	
	[Utiles writeDictionary:account named:@"account"];
	
	[account	release];
}



+(NSArray*)getDpt
{
	NSDictionary *stores = [Utiles readDictionaryNamed:@"stores"];
	
	NSMutableArray *dptArray = [[NSMutableArray alloc] init];
	for (NSString *key in [stores keyEnumerator])
	{
		NSString *zipCode = [[stores objectForKey:key]objectForKey:@"store_postcode"];
		
		int dptCodeLength = ([zipCode length] > 5) ? 3 : 2;
		NSString *dptCode = [zipCode substringToIndex:dptCodeLength];
		
		NSString *dptString = [NSString stringWithFormat:@"%@ - %@",dptCode,[Utiles getNameOfFrenchDepartmentWithNumber:[dptCode intValue]]];
		if (![dptArray containsObject:dptString])
		{
			[dptArray addObject:dptString];
		}
		
	}
	
	[dptArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [[NSNumber numberWithInt:[obj1 intValue]] compare:[NSNumber numberWithInt:[obj2 intValue]]];
	}];
	
	return [dptArray autorelease];
}

+(NSArray*)getCityWithDpt:(NSString*)dpt
{
	NSDictionary *stores = [Utiles readDictionaryNamed:@"stores"];
	
	NSMutableArray *cityArray = [[NSMutableArray alloc] init];
	
	NSString *onlyDpt = [[dpt componentsSeparatedByString:@" - "] objectAtIndex:0];
	
	for (NSString *key in [stores keyEnumerator])
	{
		NSString *zipCode = [[stores objectForKey:key]objectForKey:@"store_postcode"];
		
		int dptCodeLength = ([zipCode length] > 5) ? 3 : 2;
		NSString *dptCode = [zipCode substringToIndex:dptCodeLength];
		
		if ([onlyDpt isEqualToString:dptCode])
		{
			NSString *city = [[stores objectForKey:key]objectForKey:@"store_city"];
			[cityArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								  city, @"city",
								  zipCode, @"zip",
								  nil]];
		}
	}
	
	
	[cityArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [[obj1 objectForKey:@"city"] caseInsensitiveCompare:[obj2 objectForKey:@"city"]];
	}];
	
	return [cityArray autorelease];
	
}



+(void)removeMagsDelivery:(NSDictionary *)adresse{
    
    NSMutableDictionary *account = (NSMutableDictionary*)[Utiles readDictionaryNamed:@"account"];
    for (NSString *key in [account objectForKey:@"magsdelivery"])
    {
        NSDictionary *tempDico = [[account objectForKey:@"magsdelivery"] objectForKey:key];
        if([tempDico isEqualToDictionary:adresse]) {
            [[account objectForKey:@"magsdelivery"] removeObjectForKey:key];
            [Utiles writeDictionary:account named:@"account"];
            return ;
        }
    }
}

+(NSArray*)getMagsDelivery:(BOOL)check
{
	NSMutableArray *magsDelivery = [[NSMutableArray alloc] init] ;
    NSDictionary *account = [Utiles readDictionaryNamed:@"account"];
    
	NSString *nom = [account objectForKey:@"customer_name"];
    NSString *tel = [account objectForKey:@"customer_mobile"];
    Boolean nonVide = (nom != nil && tel != nil && ![nom isEqualToString:@""] && ![tel isEqualToString:@""]);
    
    if(check){
        if(nonVide){
            
            for (NSString *key in [account objectForKey:@"magsdelivery"])
            {
                [magsDelivery addObject:[[account objectForKey:@"magsdelivery"] objectForKey:key]];
            }
            
            [magsDelivery sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [[obj1 objectForKey:@"customer_street_id"] compare:[obj2 objectForKey:@"customer_street_id"]];
            }];
        }
    }else{
        for (NSString *key in [account objectForKey:@"magsdelivery"])
        {
            [magsDelivery addObject:[[account objectForKey:@"magsdelivery"] objectForKey:key]];
        }
        
        [magsDelivery sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[obj1 objectForKey:@"customer_street_id"] compare:[obj2 objectForKey:@"customer_street_id"]];
        }];
    }
	
	return [magsDelivery autorelease];
}
           

+(NSString*)getName
{
	return [[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_name"];
}

+(NSString*)getFirstName
{
	return [[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_firstname"];
}

+(NSString*)getMobile
{
	return [[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_mobile"];
}

+(BOOL)accountValidForCreation
{
	return TRUE;
	BOOL name = ([[[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_name"] length] > 0);
	BOOL firstName = ([[[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_firstname"] length] > 0);
	BOOL mobile = ([[[Utiles readDictionaryNamed:@"account"] objectForKey:@"customer_mobile"] length] > 0);
	
	return (name && firstName && mobile);
}


+(NSArray*)getStores{
    
    NSDictionary *dico = [Utiles readDictionaryNamed:@"stores"];
    
    NSMutableArray *stores = [[NSMutableArray alloc]init];
    for (NSString *key in [dico keyEnumerator])
    {
        [stores addObject:[dico objectForKey:key]];
    }
    
    [stores sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
     {
         return [[obj1 objectForKey:@"store_city"] caseInsensitiveCompare:[obj2 objectForKey:@"store_city"]];
     }];
    
    return [stores autorelease];
}

+(NSArray*)getAlphabets:(NSArray *) array{
    
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    for (NSDictionary *row in array) {
        NSString *uniChar = [[row objectForKey:@"store_city"] substringToIndex:1];
        if (![indexArray containsObject:uniChar]){
            [indexArray addObject:uniChar];
        }
    }
    
    return [indexArray autorelease];
}

+(NSString *)getKeyStores:(NSDictionary *)adresse{
    
    NSDictionary *stores = [Utiles readDictionaryNamed:@"stores"];
    for (NSString *key in stores)
    {
        NSDictionary *tempDico = [stores objectForKey:key];
        if([tempDico isEqualToDictionary:adresse]) {
            return key;
        }
    }
    return @"";
}

+(BOOL)checkLivrableAdress:(NSString *)rue :(NSString *)zip{
    
    
    return NO;
}

+(NSMutableDictionary *)reorganiserArrayPizzas:(NSArray *)pizzas{
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:pizzas];
    [mutableArray sortUsingComparator:^NSComparisonResult(BAPProduct *obj1, BAPProduct *obj2) {
        return [obj1.category2 compare:obj2.category2];
    }];
    
    NSMutableDictionary *dico = [[NSMutableDictionary alloc] init];
    NSString *cat = ((BAPProduct *)[mutableArray objectAtIndex:0]).category2;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(BAPProduct *obj in mutableArray){
        
        if(![obj.category2 isEqualToString:cat]){
            [dico setObject:array forKey:cat];
            cat = obj.category2;
            [array release];
            array = [[NSMutableArray alloc] init];
            [array addObject:obj];
        }
        else{
            [array addObject:obj];
        }
    }
    [dico setObject:array forKey:cat];
    [array release];
    [mutableArray release];
    [dico removeObjectForKey:@""];
    
    return [dico autorelease];
}

@end
