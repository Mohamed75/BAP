//
//  BAPWSReduction.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 02/06/13.
//
//

#import <Foundation/Foundation.h>
#import "BAPReduction.h"


@interface BAPWSReduction : NSObject

+(void)setDelegate:(NSObject*)pDelegate;
+(NSObject *)getDelegate;


+(void)getCouponsWithStoreId:(NSString*)storeId :(NSString *)sellId;
+(void)appliquerCoupon:(NSString*)storeId :(NSString *)urlCoupon;

@end
