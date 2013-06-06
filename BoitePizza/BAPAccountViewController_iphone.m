//
//  BAPAccountViewController_iphone.m
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPAccountViewController_iphone.h"
#import "BAPAccountCell_iphone.h"
#import "BAPAccountSectionView_iphone.h"


@interface BAPAccountViewController_iphone()

-(void)deleteBtnClicked:(UIButton*)deleteBtn;

@end




@implementation BAPAccountViewController_iphone

@synthesize accountTable;


- (void)viewDidLoad
{
    [super viewDidLoad];
	modifying	=	FALSE;
	
	[self	setRightBtnType:RightBtnTypeModify];
	[self	showRightBtn:TRUE];
	
    /*
	[addressArray release];
	addressArray	=	nil;
	addressArray	=	[[NSMutableArray	alloc]	initWithArray:[BAPAuthentification getMagsDelivery:YES] ];
	*/
	
}


-(void)viewDidAppear:(BOOL)animated{
    [addressArray release];
	addressArray	=	nil;
	addressArray	=	[[NSMutableArray	alloc]	initWithArray:[BAPMethode getMagsDelivery:NO] ];
    [accountTable reloadData];
}


-(void)rightBtnClicked
{
	
	modifying =	!modifying;

	for (BAPAccountSectionView_iphone *editableSection in self.accountTable.subviews)
	{
		if (editableSection.tag != 0)
		{
			[UIView animateWithDuration:0.3 
							 animations:^{[editableSection.deleteBtn setFrame:CGRectMake(modifying ? 230 : 320 , 2, 80, 26)]; }
							 completion:^(BOOL finish){    }];
			
		}
	}
}


-(void)deleteBtnClicked:(UIButton*)deleteBtn
{
    if(addressArray.count > 1){
        [BAPMethode removeMagsDelivery:[addressArray objectAtIndex:deleteBtn.tag]];
        [addressArray 		removeObjectAtIndex:deleteBtn.tag];
        [self.accountTable	reloadData];
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

	
	if (modifying)
		[sectionView.deleteBtn setFrame:CGRectMake(230, 2, 80, 26)];
	
	return sectionView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark UITableView dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [addressArray count] + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return (section == 0) ? 3 : 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier =	@"AccountCell";
	

	BAPAccountCell_iphone	*cell	=	[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;;
	
	if (cell == nil)
	{
		cell						=	[[[BAPAccountCell_iphone	alloc]	initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		cell.selectionStyle			=	UITableViewCellSelectionStyleNone;
	}
	
	
	if (indexPath.section == 0)
	{
		switch (indexPath.row)
		{
			case 0:
				cell.titleLbl.text				=	@"Nom";
				cell.valueField.placeholder		=	[BAPMethode getName];
				break;
			case 1:
				cell.titleLbl.text				=	@"Prénom";
				cell.valueField.placeholder		=	[BAPMethode getFirstName];
				break;
			case 2:
				cell.titleLbl.text				=	@"Téléphone";
				cell.valueField.placeholder		=	[BAPMethode getMobile];
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
				cell.valueField.placeholder		=	[NSString stringWithFormat:@"%@ %@ %@",
                                                     [[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_number"],
													 [[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_street_type"],
													 [[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_street"]];
				cell.valueField.frame = CGRectMake(90, cell.valueField.frame.origin.y, 250,cell.valueField.frame.size.height);
                break;
			case 1:
				cell.titleLbl.text				=	@"Code Postal";
				cell.valueField.placeholder		=	[[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_postcode"];
				break;
			case 2:
				cell.titleLbl.text				=	@"Ville";
				cell.valueField.placeholder		=	[[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_city"];
				break;
			case 3:
				cell.titleLbl.text				=	@"Bâtiment";
				cell.valueField.placeholder		=	[[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_building"];
				break;
			case 4:
				cell.titleLbl.text				=	@"Bloc";
				cell.valueField.placeholder		=	[[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_bloc"];
				break;
			case 5:
				cell.titleLbl.text				=	@"Etage";
				cell.valueField.placeholder		=	[[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_floor"];
				break;
			case 6:
				cell.titleLbl.text				=	@"Code entrée";
				cell.valueField.placeholder		=	[[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_code_entry"];
				break;
			case 7:
				cell.titleLbl.text				=	@"Code ascenseur";
				cell.valueField.placeholder		=	[[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_code_lift"];
				break;
			case 8:
				cell.titleLbl.text				=	@"Code porte";
				cell.valueField.placeholder		=	[[addressArray objectAtIndex:indexPath.section-1] objectForKey:@"customer_street_address_code_gate"];
				break;
				
			default:
				break;
		}
	}
	
	
	return cell;
}

@end
