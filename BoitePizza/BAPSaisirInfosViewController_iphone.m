//
//  BAPSaisirInfosViewController_iphone.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 21/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BAPSaisirInfosViewController_iphone.h"
#import "BAPAccountCell_iphone.h"
#import "BAPAccountSectionView_iphone.h"

@implementation BAPSaisirInfosViewController_iphone
@synthesize accountTable, streetSelected, streetIdSelected;


// ts ce qui concerne ce controller est ds -(void)rightBtnClicked 


- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    if(cellField1 != nil)    [cellField1 release];
    if(cellField2 != nil)    [cellField2 release];
    if(cellField3 != nil)    [cellField3 release];
    if(cellField4 != nil)    [cellField4 release];
    if(cellField5 != nil)    [cellField5 release];
    if(cellField6 != nil)    [cellField6 release];
    if(cellField7 != nil)    [cellField7 release];
    if(cellField8 != nil)    [cellField8 release];
    if(cellField9 != nil)    [cellField9 release];
    if(cellField10 != nil)    [cellField10 release];
    if(cellField11 != nil)    [cellField11 release];
    if(cellField12 != nil)    [cellField12 release];
    
    [addressArray release];
    
    [super dealloc];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[addressArray release];
	addressArray	=	nil;
	addressArray	=	[[NSMutableArray	alloc]	initWithArray:[BAPMethode getMagsDelivery:NO] ];
	
	[self	setRightBtnType:RightBtnTypeModify];
	[self	showRightBtn:TRUE];
    [self	showLeftBtn:TRUE withAnimation:FALSE];
	
    
    [[NSNotificationCenter defaultCenter] addObserver:self	 selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
	
    cellField1		=	[[BAPMethode getName] retain];
    cellField2		=	[[BAPMethode getFirstName] retain];
    cellField3		=	[[BAPMethode getMobile] retain];
    cellField4		=	[[[addressArray lastObject] objectForKey:@"customer_street_address_street"] retain];
    cellField5	=	[[[addressArray lastObject] objectForKey:@"customer_street_address_postcode"] retain];
    cellField6	=	[[[addressArray lastObject] objectForKey:@"customer_street_address_city"] retain];
    cellField7 = [@"" retain];
    cellField8 = [@"" retain];
    cellField9 = [@"" retain];
    cellField10 = [@"" retain];
    cellField11 = [@"" retain];
    cellField12 = [@"" retain];

}


-(void)rightBtnClicked
{
    [self saveTextFieldEtat];
    
    if(cellField1 != nil && cellField3 != nil){
        
        [BAPMethode saveParametre:cellField1 :cellField2 :cellField3 :cellField7
                           :cellField8 :cellField9 :cellField10 :cellField11
                                 :cellField12 :streetIdSelected];
        
        
       // NSLog(@"account : %@", [Utiles readDictionaryNamed:@"account"]);
        if ([BAPMethode accountValidForCreation] && [streetSelected length] > 1)
        {
            
            [BAPAuthentification accountCreationWithStreetId:streetIdSelected];
        }else
        {
            NSLog(@"WTF");
        }
        
        
    }else{
        UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@""
                                                               message:@"Vous devez renseigner votre Nom ainsi que votre Téléphone."
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        [alertEvent		show];
        [alertEvent		release];
    }

	
}



#pragma mark -

#pragma mark TABLEVIEW METHODS

#pragma mark UITableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	NSString	*sectionText;
	
	if (section == 0)
	{
		sectionText				=	@" Informations personnelles";
	}else
	{
		sectionText				=	[NSString stringWithFormat:@" Adresse de livraison N°%i", section];
	}
	
	BAPAccountSectionView_iphone *sectionView	=	[[[BAPAccountSectionView_iphone	alloc]	initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
	sectionView.tag								=	section;
	sectionView.deleteBtn.tag					=	section - 1;
	sectionView.sectionLabel.text				=	sectionText;
	sectionView.deleteBtn.hidden				=	(section == 0);
	
	[sectionView.deleteBtn	 addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	return sectionView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark UITableView dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return (section == 0) ? 3 : 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier =	[NSString stringWithFormat:@"cCellIdentifier%d%d",indexPath.section,indexPath.row];
	
	
	BAPAccountCell_iphone	*cell	=	[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
	
	if (cell == nil)
	{
		cell						=	[[[BAPAccountCell_iphone	alloc]	initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		cell.selectionStyle			=	UITableViewCellSelectionStyleNone;
        
        
        cell.valueField.delegate = self;
        
        if (indexPath.section == 0)
        {
            cell.valueField.userInteractionEnabled = TRUE;
            
            switch (indexPath.row)
            {
                case 0:
                    cell.titleLbl.text				=	@"Nom";
                    cell.valueField.text		=	[BAPMethode getName];
                    break;
                case 1:
                    cell.titleLbl.text				=	@"Prénom";
                    cell.valueField.text		=	[BAPMethode getFirstName];
                    break;
                case 2:
                    cell.titleLbl.text				=	@"Téléphone";
                    cell.valueField.text		=	[BAPMethode getMobile];
                    break;
                    
                default:
                    break;
            }
            
        }else
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.titleLbl.text				=	@"Rue";
                    cell.valueField.text		=	[NSString stringWithFormat:@"%@ %@",
                                                     [[addressArray lastObject] objectForKey:@"customer_street_address_number"],
                                                     [[addressArray lastObject] objectForKey:@"customer_street_address_street"]];
                    cellField4 = [cell.valueField.text retain];
                    cell.valueField.frame = CGRectMake(90, cell.valueField.frame.origin.y, 250,cell.valueField.frame.size.height);
                    break;
                case 1:
                    cell.titleLbl.text				=	@"Code Postal";
                    cell.valueField.text		=	[[addressArray lastObject] objectForKey:@"customer_street_address_postcode"];
                    cellField5 = [cell.valueField.text retain];
                    break;
                case 2:
                    cell.titleLbl.text				=	@"Ville";
                    cell.valueField.text		=	[[addressArray lastObject] objectForKey:@"customer_street_address_city"];
                    cellField6 = [cell.valueField.text retain];
                    break;
                case 3:
                    cell.valueField.userInteractionEnabled = TRUE;
                    cell.titleLbl.text				=	@"Bâtiment";
                    cell.valueField.text			=	[[addressArray lastObject] objectForKey:@"customer_street_address_building"];
                    
                    break;
                case 4:
                    cell.valueField.userInteractionEnabled = TRUE;
                    cell.titleLbl.text				=	@"Bloc";
                    cell.valueField.text			=	[[addressArray lastObject] objectForKey:@"customer_street_address_bloc"];
                    break;
                case 5:
                    cell.valueField.userInteractionEnabled = TRUE;
                    cell.valueField.keyboardType = UIKeyboardTypeNumberPad;
                    cell.titleLbl.text				=	@"Etage";
                    cell.valueField.text			=	[[addressArray lastObject] objectForKey:@"customer_street_address_floor"];
                    break;
                case 6:
                    cell.valueField.userInteractionEnabled = TRUE;
                    cell.titleLbl.text				=	@"Code entrée";
                    cell.valueField.text			=	[[addressArray lastObject] objectForKey:@"customer_street_address_code_entry"];
                    break;
                case 7:
                    cell.valueField.userInteractionEnabled = TRUE;
                    cell.titleLbl.text				=	@"Code ascenseur";
                    cell.valueField.text			=	[[addressArray lastObject] objectForKey:@"customer_street_address_code_lift"];
                    break;
                case 8:
                    cell.valueField.userInteractionEnabled = TRUE;
                    cell.titleLbl.text				=	@"Code porte";
                    cell.valueField.text			=	[[addressArray lastObject] objectForKey:@"customer_street_address_code_gate"];
                    break;
                    
                default:
                    break;
            }
        }
	}
	
	return cell;
}

#pragma mark -
#pragma mark UITextFieldDelegate

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (keyboardShown)
        return;
	
    NSDictionary* info = [aNotification userInfo];
	
    // Get the size of the keyboard.
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
	
    CGRect viewFrame = [accountTable frame];
    viewFrame.size.height -= (keyboardSize.height - 60);
    accountTable.frame = viewFrame;
    
    keyboardShown = YES;
}


// Called when the UIKeyboardDidHideNotification is sent
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
	if(keyboardShown){
		NSDictionary* info = [aNotification userInfo];
		
		// Get the size of the keyboard.
		NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
		CGSize keyboardSize = [aValue CGRectValue].size;
		
		CGRect viewFrame = [accountTable frame];
		viewFrame.size.height += (keyboardSize.height - 60);
		accountTable.frame = viewFrame;
        
		keyboardShown = NO;
	}
}

-(void) resignCells:(int) section{
	
	for(int i = 0; i < [accountTable numberOfRowsInSection:section]; i++)	[((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]]).valueField resignFirstResponder];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self saveTextFieldEtat];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	
    [self saveTextFieldEtat];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self saveTextFieldEtat];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self saveTextFieldEtat];
    
    BAPAccountCell_iphone *tempCell = (BAPAccountCell_iphone *)[textField superview] ;
	int indexRow = [(NSIndexPath *)[accountTable indexPathForCell:tempCell] row];
    int indexSection = [(NSIndexPath *)[accountTable indexPathForCell:tempCell] section];
	
    if(indexSection == 0 ){
        if(indexRow < 2){
            [accountTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow+1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow+1 inSection:0]]).valueField becomeFirstResponder];
        }
        else{
            [accountTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [self resignCells:0];
        }
    }else{
        if(indexRow < 8){
            [accountTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow+1 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow+1 inSection:1]]).valueField becomeFirstResponder];
        }
        else [self resignCells:1];
    }
    
    
	return TRUE;
}


-(void)saveTextFieldEtat{
    
    NSString *anom = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).valueField.text;
	if(anom != nil)	{
		if(cellField1 != nil)	[cellField1 release];
		cellField1 = [anom retain];
	}
	NSString *aprenom = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).valueField.text;
	if(aprenom != nil)	{
		if(cellField2 != nil)	[cellField2 release];
		cellField2 = [aprenom retain];
	}
	NSString *atel = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).valueField.text;
	if(atel != nil)	{
		if(cellField3 != nil)	[cellField3 release];
		cellField3 = [atel retain];
	}
	NSString *arue = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]]).valueField.text;
	if(arue != nil)	{
		if(cellField4 != nil)	[cellField4 release];
		cellField4 = [arue retain];
	}
	NSString *acodePostal = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]]).valueField.text;
	if(acodePostal != nil)	{
		if(cellField5 != nil)	[cellField5 release];
		cellField5 = [acodePostal retain];
	}
	NSString *aville = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]]).valueField.text;
	if(aville != nil)	{
		if(cellField6 != nil)	[cellField6 release];
		cellField6 = [aville retain];
	}
	NSString *abat = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]]).valueField.text;
	if(abat != nil)	{
		if(cellField7 != nil)	[cellField7 release];
		cellField7 = [abat retain];
	}
	NSString *abloc = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]]).valueField.text;
	if(abloc != nil)	{
		if(cellField8 != nil)	[cellField8 release];
		cellField8 = [abloc retain];
	}
    NSString *aetage = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]]).valueField.text;
	if(aetage != nil)	{
		if(cellField9 != nil)	[cellField9 release];
		cellField9 = [aetage retain];
	}
    NSString *acodeE = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:1]]).valueField.text;
	if(acodeE != nil)	{
		if(cellField10 != nil)	[cellField10 release];
		cellField10 = [acodeE retain];
	}
	NSString *acodeA = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:1]]).valueField.text;
	if(acodeA != nil)	{
		if(cellField11 != nil)	[cellField11 release];
		cellField11 = [acodeA retain];
	}
    NSString *acodeP = ((BAPAccountCell_iphone *)[accountTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:1]]).valueField.text;
	if(acodeP != nil)	{
		if(cellField12 != nil)	[cellField12 release];
		cellField12 = [acodeP retain];
	}
}



@end
