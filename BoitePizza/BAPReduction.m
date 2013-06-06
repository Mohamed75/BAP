//
//  BAPReduction.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import "BAPReduction.h"

@implementation BAPReduction
@synthesize reference;
@synthesize name;
@synthesize valeur;
@synthesize picture;


- (id)init {
    self = [super init];
    if (self) {
        reference = @"";
		name = @"";
        valeur = @"";
		picture = @"";
    }
    return self;
}

@end
