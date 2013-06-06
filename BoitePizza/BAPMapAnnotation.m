//
//  BAPMapAnnotation.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 04/04/13.
//
//

#import "BAPMapAnnotation.h"

@implementation BAPMapAnnotation
@synthesize coordinate, store;


-(id)initWithStore:(NSDictionary *)pStore{
    
    self = [super init];
    if (self) {
        coordinate.longitude = [[pStore objectForKey:@"store_lon"] floatValue];
        coordinate.latitude = [[pStore objectForKey:@"store_lat"] floatValue];
        store = [pStore copy];
    }
    return self;
}

@end
