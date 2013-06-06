//
//  BAPCartViewController_iphone.m
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPCartViewController_iphone.h"

@interface BAPCartViewController_iphone ()

@end

@implementation BAPCartViewController_iphone
@synthesize carteTable, tabBarMode, validationlMode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
		tabBarMode = false;
        validationlMode = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	
	if(!tabBarMode)    [self	showLeftBtn:TRUE withAnimation:FALSE];
}

-(void)viewDidAppear:(BOOL)animated{
    
	cartesArray	=	nil;
	//cartesArray	=	((BAPCommande *)[BAPCommande sharedInstance]).products;
    cartesArray	= ((BAPCommande *)[BAPCommande getCommandes].lastObject).products;
    [carteTable reloadData];
}



#pragma mark -

#pragma mark TABLEVIEW METHODS

#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 199;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark UITableView dataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([cartesArray count] != 0)   return [cartesArray count]+1;
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = @"CommandeCell";
	
    UITableViewCell *cell;
    if(indexPath.row == [cartesArray count]){
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%d", CellIdentifier, indexPath.row]];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@%d", CellIdentifier, indexPath.row]] autorelease];
        }
        UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 40)];
		[bgImg setImage:[UIImage imageNamed:@"bg-title"]];
		[cell	addSubview:bgImg];
        [bgImg release];
        
        UILabel *tempLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 80, 20)];
        tempLbl1.text = @"Prix total";
        tempLbl1.backgroundColor = [UIColor clearColor];
        [cell addSubview:tempLbl1];
        [tempLbl1 release];
        
        UILabel *prixLbl = [[UILabel alloc]initWithFrame:CGRectMake(240, 30, 80, 20)];
		prixLbl.textAlignment = UITextAlignmentCenter;
		prixLbl.backgroundColor = [UIColor clearColor];
		prixLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
		prixLbl.text =  [NSString stringWithFormat:@"%.2f €", [[BAPCommande sharedInstance] prixTotal]];
		[cell addSubview:prixLbl];
        [prixLbl release];
        
        if(!tabBarMode){
            UIButton *validerBtn			=	[[UIButton			alloc]	initWithFrame:CGRectMake(85, 115, 148, 33)];
            [validerBtn setImage:[UIImage imageNamed:@"btn_valider"] forState:UIControlStateNormal];
            [validerBtn addTarget:self action:@selector(validerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:validerBtn];
        }
    }else{
        
        cell = (BAPComandeCell_iphone*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
        if (cell == nil)
        {
            if ([validationlMode isEqualToString:@"reduction"])
                cell = [[[BAPComandeCell_iphone alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier FM:YES] autorelease];
            else
                cell = [[[BAPComandeCell_iphone alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier FM:tabBarMode] autorelease];
        }
        [(BAPComandeCell_iphone*)cell setCellWithInfos:[cartesArray objectAtIndex:indexPath.row]];
    }
	
	return cell;
}


-(void)validerBtnClicked
{
    BAPCommande *commande = [BAPCommande sharedInstance];
    if(commande.commedhab){
        
        BAPFinalCmdViewController_iphone *vC = [[BAPFinalCmdViewController_iphone	alloc] initWithNibName:@"BAPFinalCmdViewController_iphone" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vC animated:YES];
        [vC release];
        
    }else{
        
        /*
         if([validationlMode isEqualToString:@"autre"])
         
         [BAPCommande validerCommande:self];
         
         else*/
        if ([validationlMode isEqualToString:@"reduction"]){
            
            // traitement appliquer reduction
            
            BAPFinalCmdViewController_iphone *vC = [[BAPFinalCmdViewController_iphone	alloc] initWithNibName:@"BAPFinalCmdViewController_iphone" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:vC animated:YES];
            [vC release];
            
        }else{
            
            BAPAutresViewController_iphone *autresVC = [[BAPAutresViewController_iphone alloc] initWithNibName:@"BAPAutresViewController_iphone" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:autresVC animated:TRUE];
            [autresVC release];
        }
    }
    
}

@end
