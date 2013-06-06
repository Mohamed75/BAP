//
//  BAPSaisirInfosViewController_iphone.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 21/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAPAuthentification.h"

@interface BAPSaisirInfosViewController_iphone : BAPParentViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{

	NSMutableArray		*addressArray;
    
    BOOL keyboardShown;
    
    NSString *cellField1,*cellField2,*cellField3;
    NSString *cellField4,*cellField5,*cellField6;
    NSString *cellField7,*cellField8,*cellField9;
    NSString *cellField10,*cellField11,*cellField12;
}

@property (nonatomic, retain)	IBOutlet	UITableView	*accountTable;
@property (nonatomic, assign)  NSString 			*streetSelected;    //nom de la rue
@property (nonatomic, assign)  NSString				*streetIdSelected;  //id de la rue

@end
