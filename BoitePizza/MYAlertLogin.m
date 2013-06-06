//
//  AlertLogin.m
//  IClaps
//
//  Created by Florent ROBIN on 25/05/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MyAlertLogin.h"


@implementation MyAlertLogin

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle{
	return [self initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle textFieldOriginY:0.0];
}


-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle textFieldOriginY:(CGFloat)textFieldOriginY{
	if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil]){
		self.message = [NSString stringWithFormat: @"%@\n\n\n", message];
		
		txtLogin = [[UITextField alloc]initWithFrame:CGRectMake(12.0, textFieldOriginY + 45.0, 260.0, 25.0)];
		txtLogin.delegate = self;
		txtLogin.autocorrectionType = UITextAutocorrectionTypeNo;
		txtLogin.autocapitalizationType = UITextAutocapitalizationTypeNone;
		txtLogin.keyboardType = UIKeyboardTypeNumberPad;
		txtLogin.backgroundColor = [UIColor whiteColor];
		txtLogin.leftViewMode = UITextFieldViewModeWhileEditing;
		txtLogin.borderStyle = UITextBorderStyleRoundedRect;
		txtLogin.returnKeyType = UIReturnKeyNext;
		txtLogin.placeholder = @"Numéro de votre rue";
		[self addSubview:txtLogin];
		[txtLogin release];
		/*
		txtPwd = [[UITextField alloc]initWithFrame:CGRectMake(12.0, textFieldOriginY + 88.0, 260.0, 25.0)];
		txtPwd.delegate = self;
		txtPwd.backgroundColor = [UIColor clearColor];
		txtPwd.secureTextEntry = YES;
		txtPwd.placeholder = @"mot de passe";
		txtPwd.borderStyle = UITextBorderStyleRoundedRect;
		[self addSubview:txtPwd];
		[txtPwd release];
		*/
		[self addButtonWithTitle:@"Valider"];
	}
	return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if(textField == txtLogin)
		[txtPwd becomeFirstResponder];
	else
		[textField resignFirstResponder];
	return TRUE;
}

- (void)show{
	/*
	if([IClapsAppDelegate delegate].custInfoEmail != nil  && [[IClapsAppDelegate delegate].custInfoEmail length] != 0){
		txtLogin.text = [IClapsAppDelegate delegate].custInfoEmail;
		txtLogin.enabled = NO;
		[txtPwd becomeFirstResponder];
	}
	else
		[txtLogin becomeFirstResponder];
	 */
    [super show];
}

- (BOOL)resignFirstResponder{
	if([txtLogin isFirstResponder])
		[txtLogin resignFirstResponder];
	else if([txtPwd isFirstResponder])
		[txtPwd resignFirstResponder];
	[super resignFirstResponder];
    return TRUE;
}
-(NSString *)login{
	return txtLogin.text;
}
-(NSString *)password{
	return txtPwd.text;
}

-(void)dealloc{
	[txtPwd release];
	[txtLogin release];
	[super dealloc];
}

@end
