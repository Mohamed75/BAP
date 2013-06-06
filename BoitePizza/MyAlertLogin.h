//
//  AlertLogin.h
//  IClaps
//
//  Created by Florent ROBIN on 25/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyAlertLogin : UIAlertView <UITextFieldDelegate> {
	UITextField *txtLogin;
	UITextField *txtPwd;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle;
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle textFieldOriginY:(CGFloat)textFieldOriginY;
- (void)show;
- (NSString *)login;
- (NSString *)password;
- (BOOL)resignFirstResponder;
@end
