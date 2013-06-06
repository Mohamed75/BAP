//
//  SpecialAnnotation.h
//  Micromania
//
//  Created by Mohamed on 15/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface SpecialAnnotation : MKPinAnnotationView {

	CLLocationCoordinate2D coordinate;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;

@end
