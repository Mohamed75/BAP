//
//  BAPWSProducts.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 29/05/13.
//
//

#import <Foundation/Foundation.h>

@interface BAPWSProducts : NSObject

+(void)setDelegate:(NSObject*)pDelegate;
+(NSObject *)getDelegate;

// category = Pizza, Boissons, Entree, Dessert
+(void)getProductWithStoreId:(NSString*)storeId andCategory:(NSString*)category;


//get Menus
+(void)getMenusWithStoreId:(NSString*)storeId;
//get Accompagnements
+(void)getAccompagnementWithStoreId:(NSString*)storeId;
//get Foods
+(void)getFoodCollectionWithStoreId:(NSString*)storeId;

+(void)getListPanierStoreName:(NSString*)storeName andSellId:(NSString*)sellId;

@end
