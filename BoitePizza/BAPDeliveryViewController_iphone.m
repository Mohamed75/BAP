//
//  BAPDeliveryViewController.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPDeliveryViewController_iphone.h"
#import "BAPMenuViewController_iphone.h"
#import "BAPAuthentification.h"
#import "BAPSaisirInfosViewController_iphone.h"
#import "BAPCommande.h"
#import "BAPMapAnnotation.h"

@interface BAPDeliveryViewController_iphone ()

@end

@implementation BAPDeliveryViewController_iphone

@synthesize advertiseLbl;
@synthesize contentView;
@synthesize addressBtn;
@synthesize createBtn;
@synthesize mapBtn;
@synthesize addressView;
@synthesize createView;
@synthesize mapView;
@synthesize dptBtn;
@synthesize cityBtn;
@synthesize streetBtn;
@synthesize adressesTable;
@synthesize alertRueAdresse;
@synthesize map;
@synthesize geoCoder;


// le but de ce controller est la recuperation de la rue y compris le numero de rue 
// ajout de cette adresse en dure [self addAdressAcount] qui fait appel a sont tour
// [BAPMethode accountAddStore]
// puis afficher la vue BAPSaisirInfosViewController_iphone


- (void)dealloc{
    
    [map release];
    [picker release];
    [streetsId release];
    [cities release];
    [adressesArray release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization
        geoCoder = [[CLGeocoder alloc] init];
    }
    return self;
}



- (void)viewDidLoad
{
    initialisationMap = 0;
    
    [super 	viewDidLoad];
    [self.view	setFrame:CGRectMake(0, self.view.frame.origin.y, 320, [UIScreen mainScreen].bounds.size.height-113)];
    
    alertRueAdresse			=		[[MyAlertLogin alloc]initWithTitle:@""
                                                   message:@"Veuillez saisir votre numéro de rue"
                                                  delegate:self
                                         cancelButtonTitle:@"Annuler"
                                           textFieldOriginY:10];
	
	[BAPAuthentification	setDelegate:self];
	
	[self	showLeftBtn:TRUE withAnimation:FALSE];
	
	[self.contentView.layer		setBorderColor: [[UIColor colorWithRed:0.175 green:0.175 blue:0.175 alpha:0.5] CGColor]];
	[self.contentView.layer		setBorderWidth:1.0];

	[self.contentView.layer		setCornerRadius:8.0];
	
	contentView.userInteractionEnabled	=	TRUE;
	streetSelected = @"";
	[contentView				addSubview:addressView];
	
	picker = [[PickerWithToolBar alloc] init];
	picker.delegate = self;
	[picker setRowHeight:40];
	CGRect frame = picker.frame;
	frame.origin.y = self.view.frame.size.height;
	[picker setFrame:frame];
	
	[self.view addSubview:picker];
	
	actionSelected = kDptAction;
	
    [self refreshAdressesTable];
    [self initMap];
}



-(void)setStoreSelected:(NSString*)store
{
	[storeSelected release];
	storeSelected = nil;
	
	storeSelected = [[NSString alloc]	initWithString:store];
}


#pragma mark -
#pragma mark Actions

-(IBAction)segmentBtnClicked:(UIButton*)btn
{
	if (!btn.selected)
		return;
	
	addressBtn.selected	=	TRUE;
	createBtn.selected	=	TRUE;
	mapBtn.selected		=	TRUE;
	btn.selected		=	FALSE;
	
	for (UIView *toRemove in [contentView subviews])
		[toRemove		removeFromSuperview];
	
	if ([btn isEqual:addressBtn])
	{
        [self refreshAdressesTable];
		[contentView	addSubview:addressView];
		advertiseLbl.text	=	@"Choisissez une adresse de livraison";
	}else if ([btn isEqual:createBtn])
	{
		[contentView	addSubview:createView];
		advertiseLbl.text	=	@"Saisissez une nouvelle adresse de livraison";
	}else if ([btn isEqual:mapBtn])
	{
		[contentView	addSubview:mapView];
		advertiseLbl.text	=	@"Localisez une nouvelle adresse de livraison";
	} 

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1)    {
        if(alertRueAdresse.login != nil && ![alertRueAdresse.login isEqualToString:@""])
            [self addAdressAcount:alertRueAdresse.login];
    }
}

-(IBAction)validBtnClicked
{
    [alertRueAdresse		show];
    //[alertRueAdresse		release];
}

#pragma mark -
#pragma mark Saisie

-(IBAction)dptClicked:(id)sender
{
	actionSelected = kDptAction;
	
	[picker setContent:[BAPMethode getDpt]];
	[UIView animateWithDuration:0.3 
					 animations:^
	{
		CGRect frame = picker.frame;
		frame.origin.y -= frame.size.height;
		[picker setFrame:frame];
	}
					 completion:^(BOOL finish){    }];
	
}

-(IBAction)cityClicked:(id)sender
{
	actionSelected = kCityAction;
	
	[cities release];
	cities = nil;
	cities = [[NSArray alloc] initWithArray:[BAPMethode getCityWithDpt:dptSelected]];
	
	NSMutableArray *citiesNames = [[NSMutableArray alloc] init];
	
	for (NSDictionary*city in cities)
	{
		[citiesNames addObject:[city objectForKey:@"city"]];
	}
	
	[picker setContent:citiesNames];
	
	[citiesNames release];
	
	[UIView animateWithDuration:0.3 
					 animations:^
	 {
		 CGRect frame = picker.frame;
		 frame.origin.y -= frame.size.height;
		 [picker setFrame:frame];
	 }
					 completion:^(BOOL finish){    }];
}

-(IBAction)streetClicked:(id)sender
{
	actionSelected = kStreetAction;
	[BAPAuthentification getStreetWithCity:citySelected];
	[Utiles startLoading:self.view :FALSE];
}

#pragma mark -
#pragma mark getStreetDelegate

-(void)setStreetInPicker:(NSArray *)streetsName{
    
    [picker setContent:streetsName];
	
	
	[UIView animateWithDuration:0.3
					 animations:^
	 {
		 CGRect frame = picker.frame;
		 frame.origin.y -= frame.size.height;
		 [picker setFrame:frame];
	 }
					 completion:^(BOOL finish){    }];
}

-(void)getStreetFinish:(NSArray*)streets
{
	NSMutableArray *streetsName = [[NSMutableArray alloc] init];
	
	[streetsId release];
	streetsId = nil;
	streetsId = [[NSMutableArray alloc] init];
    [Utiles stopLoading];
    
	for (NSDictionary *street in streets)
	{
		[streetsName addObject:[NSString stringWithFormat:@"%@ %@",
								[street objectForKey:@"type"],
								[street objectForKey:@"name"]]];
		[streetsId addObject:[street objectForKey:@"id"]];
	}
	
	if(!createBtn.selected)  [self setStreetInPicker:streetsName];
	if(!mapBtn.selected)  [self checkStreet:streetsName];
    
    [streetsName release];
}

-(void)getStreetFail:(id)error
{
	[Utiles stopLoading];
    [Utiles connectionEchecMsg];
}

#pragma mark -
#pragma mark accountCreationDelegate

-(void)creationFinish:(NSObject*)response
{
	NSLog(@"creation : %@", response);
	UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Félicitation"
														   message:@"Votre compte a bien été créé"
														  delegate:nil
												 cancelButtonTitle:@"Ok"
												 otherButtonTitles:nil];
	[alertEvent		show];
	[alertEvent		release];
	
    [self.navigationController popViewControllerAnimated:NO];
    
	BAPMenuViewController_iphone	*menuVc	=	[[BAPMenuViewController_iphone	alloc]	initWithNibName:@"BAPMenuViewController_iphone" bundle:[NSBundle	mainBundle]];
	[self.navigationController	pushViewController:menuVc animated:TRUE];
	[menuVc	release];
	NSLog(@"creation OK : %@", response);
}

-(void)creationFail:(NSDictionary*)response
{
	NSLog(@"creation NOK : %@", response);
}


#pragma mark -AuthentificationDelegate

-(void)authentificationFinish:(NSString*)response
{
	NSLog(@"AUTH OK : %@", response);
}

-(void)authentificationFail:(NSString*)response
{
	NSLog(@"AUTH NOK : %@", response);
}


#pragma mark -
#pragma mark pickerDelegate

-(void)pickerCancel
{
	
}

-(void)pickerValidWithTitle:(NSString*)title forRow:(int)index
{
	[UIView animateWithDuration:0.3 
					 animations:^
	 {
		 CGRect frame = picker.frame;
		 frame.origin.y += frame.size.height;
		 [picker setFrame:frame];
	 }
					 completion:^(BOOL finish){    }];
	switch (actionSelected)
	{
		case kDptAction:
			dptSelected = [title copy];
			[dptBtn setTitle:title forState:UIControlStateNormal];
			[cityBtn setTitle:@"Ville" forState:UIControlStateNormal];
			[streetBtn setTitle:@"Rue" forState:UIControlStateNormal];
			cityBtn.enabled = TRUE;
			streetBtn.enabled = FALSE;
			streetSelected = @"";
			break;
		case kCityAction:
			citySelected = [title copy];
			[cityBtn setTitle:title forState:UIControlStateNormal];
			[streetBtn setTitle:@"Rue" forState:UIControlStateNormal];
			streetBtn.enabled = TRUE;
			streetSelected = @"";
			indexCitySelected = index;
			break;
		case kStreetAction:
			streetSelected = [title copy];
			streetIdSelected = index;
			[streetBtn setTitle:title forState:UIControlStateNormal];
			break;
			
		default:
			break;
	}
}


-(void)addAdressAcount:(NSString *) numRue
{
    if ([BAPMethode accountValidForCreation] && [streetSelected length] > 1)
	{
		
		BAPCommande *commande = [BAPCommande sharedInstance];
		commande.streetId = streetSelected;
		commande.storeId = storeSelected;
		
		[BAPMethode accountAddStore:storeSelected
										 zip:[[cities objectAtIndex:indexCitySelected] objectForKey:@"zip"]
										city:[[cities objectAtIndex:indexCitySelected] objectForKey:@"city"]
								   andStreet:streetSelected
                                   numStreet:numRue];
		
		
        BAPSaisirInfosViewController_iphone *saisirInfos = [[BAPSaisirInfosViewController_iphone	alloc] initWithNibName:@"BAPSaisirInfosViewController_iphone" bundle:[NSBundle mainBundle]];
        saisirInfos.streetSelected = streetSelected;
        saisirInfos.streetIdSelected = [streetsId objectAtIndex:streetIdSelected];
        [self.navigationController pushViewController:saisirInfos animated:TRUE];
        [saisirInfos release];
		
	}else
	{
		UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Erreur"
															   message:@"Vous devez rentrer une adresse valide."
															  delegate:self
													 cancelButtonTitle:@"Ok"
													 otherButtonTitles:nil];
		[alertEvent		show];
		[alertEvent		release];
	}
}


/////////////////////////   vue liste adress  ////////////////////////////////////////////


-(void)refreshAdressesTable{
    
    [adressesArray release];
    adressesArray = nil;
    adressesArray = [[BAPMethode getMagsDelivery:YES] copy];
    [adressesTable reloadData];
}


#pragma mark UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [adressesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = @"AdresseCell";
	
    UITableViewCell	*cell	=	[tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;;
	
	if (cell == nil)
	{
		cell						=	[[[UITableViewCell	alloc]	initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    NSDictionary *tempDico = [adressesArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",
                           [tempDico objectForKey:@"customer_street_address_number"],
                           [tempDico objectForKey:@"customer_street_address_street"]];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempDico = [adressesArray objectAtIndex:indexPath.row];
    
    BAPCommande *commande = [BAPCommande sharedInstance];
    commande.streetId = [tempDico objectForKey:@"customer_street_address_street"];
    commande.storeId = [tempDico objectForKey:@"customer_street_store_name"];
    
    BAPMenuViewController_iphone	*menu = [[BAPMenuViewController_iphone alloc] initWithNibName:@"BAPMenuViewController_iphone" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:menu animated:TRUE];
    [menu release];
    
}


#pragma mark UITableView MAPView


-(void)initMap{
    
    CLLocationCoordinate2D center;
    center.latitude = 2.24; center.longitude = 48.0;
    float zoom = 10;
    
	if(map.userLocation.location != nil){
        center = map.userLocation.coordinate;
        zoom = 0.5;
    }
    MKCoordinateRegion region;
    region.center = center;
	MKCoordinateSpan span;
	span.latitudeDelta = zoom;
	span.longitudeDelta = zoom;
	region.span = span;
    [map setRegion:region];
    
    if(map.annotations.count <= 1){
        NSArray *stores = [BAPMethode getStores];
        for(NSDictionary *store in stores){
            BAPMapAnnotation *annotation = [[BAPMapAnnotation alloc] initWithStore:store];
            [map addAnnotation:annotation];
            [annotation release];
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[BAPMapAnnotation class]]){
        SpecialAnnotation *specialAnnotation = [[SpecialAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationViewID"];
        specialAnnotation.annotation = annotation;
        return [specialAnnotation autorelease];
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    if(initialisationMap == 0){
        [self initMap];
        initialisationMap = 1;
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
	
    [self setStoreSelected:[BAPMethode getKeyStores:((BAPMapAnnotation*)(view.annotation)).store] ];
    
    [self.geoCoder reverseGeocodeLocation: map.userLocation.location completionHandler:
     
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         NSDictionary *locatedAt = placemark.addressDictionary;
         [self afficheResult:[locatedAt objectForKey:@"Street"] :((BAPMapAnnotation*)(view.annotation)).store];
     }];
    
    [map deselectAnnotation:view.annotation animated:NO];
}


-(void)afficheResult:(NSString*)rue :(NSDictionary *)store{
    
    [rueMap release];
    rueMap = [rue retain];
    [BAPAuthentification getStreetWithCity:[store objectForKey:@"store_city"]];
	[Utiles startLoading:self.view :FALSE];
}

-(void)checkStreet:(NSArray *)streetsName{
    
    BOOL livrable = false;
    int index = 0;
    for(NSString *street in streetsName){
        if([street isEqualToString:rueMap]) {
            livrable = true;
            index = [streetsName indexOfObject:street];
        }
    }
    
    if(livrable){
        streetIdSelected =      index;
        [alertRueAdresse		show];
    }else{
        UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@"Nous somme désolé"
                                                               message:@"Votre rue n'est pas livrable par ce magasin"
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        [alertEvent		show];
        [alertEvent		release];
    }

}

@end
