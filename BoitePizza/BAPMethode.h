//
//  BAPMethode.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import <Foundation/Foundation.h>
#import "BAPProduct.h"


@interface BAPMethode : NSObject

+(void)createEmptyAccount;
+(int)getIndexMsgDelivrery:(NSDictionary *)msgDelivrery;
+(void)accountAddStore:(NSString*)store;
+(void)accountAddStore:(NSString*)store
				   zip:(NSString*)zip
				  city:(NSString*)city
             andStreet:(NSString*)street
             numStreet:(NSString *)num;

+(void)saveParametre:(NSString*)name :(NSString*)fName :(NSString*)mobile :(NSString*)building
                    :(NSString*)bloc :(NSString*)floor :(NSString*)cEntry :(NSString*)cLift
                    :(NSString*)cGate :(NSString*)streetIdSelected;
    
+(NSArray*)getDpt;
+(NSArray*)getCityWithDpt:(NSString*)dpt;
+(void)removeMagsDelivery:(NSDictionary *)adresse;
+(NSArray*)getMagsDelivery:(BOOL)check;
+(NSString*)getName;
+(NSString*)getFirstName;
+(NSString*)getMobile;
+(BOOL)accountValidForCreation;
+(NSArray*)getStores;
+(NSArray*)getAlphabets:(NSArray *) array;
+(NSString *)getKeyStores:(NSDictionary *)adresse;
+(BOOL)checkLivrableAdress:(NSString *)rue :(NSString *)zip;
+(NSMutableDictionary *)reorganiserArrayPizzas:(NSArray *)pizzas;

@end
