//
//  BAPWSCommande.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 29/05/13.
//
//

#import <Foundation/Foundation.h>


@interface BAPWSCommande : NSObject

+(void)setDelegate:(NSObject*)pDelegate;
+(NSObject *)getDelegate;

+(void)addCommande:(NSString*)store :(NSString*)mode :(NSString*)customerId :(NSString*)streetId;
+(void)addProductToCommande:(NSString*)store :(NSString*)sellId :(NSString*)mode :(NSString*)itemRef :(NSString*)itemQt
                           :(NSString*)pate :(NSString*)taille;


@end
