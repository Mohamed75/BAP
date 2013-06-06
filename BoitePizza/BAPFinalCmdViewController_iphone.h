//
//  BAPFinalCmdViewController_iphone.h
//  BoitePizza
//
//  Created by Mohamed Boumansour on 30/03/13.
//
//

#import <UIKit/UIKit.h>
#import "BAPCommande.h"

@interface BAPFinalCmdViewController_iphone : UIViewController
{
    BOOL check;
}

@property (nonatomic, retain)	IBOutlet	UITextView	*txtV;
@property (nonatomic, retain)	IBOutlet	UITextView	*txtV2;

-(IBAction)validerBtnClicked:(id)sender;

@end
