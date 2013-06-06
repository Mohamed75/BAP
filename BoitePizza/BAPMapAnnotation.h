//
//  BAPMapAnnotation.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 04/04/13.
//
//

#import <Foundation/Foundation.h>
#import "SpecialAnnotation.h"

@interface BAPMapAnnotation : NSObject  <MKAnnotation>

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic,retain) NSDictionary    *store;

-(id)initWithStore:(NSDictionary *)pStore;

@end
