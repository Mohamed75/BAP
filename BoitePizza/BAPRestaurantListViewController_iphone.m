//
//  BAPRestaurantListViewController.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPRestaurantListViewController_iphone.h"
#import "BAPMapAnnotation.h"


@interface BAPRestaurantListViewController_iphone ()

@end

@implementation BAPRestaurantListViewController_iphone

@synthesize listBtn;
@synthesize mapBtn;
@synthesize contentView;
@synthesize mapV;
@synthesize listView;

- (void)dealloc{
    
    [mapV release];
    [listBtn release];
    [stores release];
    [listView release];
    [indexArray release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 568)
    {
        contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y,
                                   contentView.frame.size.width, contentView.frame.size.height+88);
        
        listView.frame = CGRectMake(listView.frame.origin.x, listView.frame.origin.y,
                                       listView.frame.size.width, listView.frame.size.height+88);
        
        mapV.frame = listView.frame;
    }
    
	[self			showLeftBtn:TRUE withAnimation:FALSE];
	[contentView	addSubview:listView];
}

-(void)viewDidAppear:(BOOL)animated{
    
    initialisationMap = 0;
    
    [stores release];
    [indexArray release];
    stores = [[NSArray alloc] initWithArray:[BAPMethode getStores] ];
    indexArray = [[NSArray alloc] initWithArray:[BAPMethode getAlphabets:stores] ];
    [listView reloadData];
    [self initMap];
}

-(IBAction)segmentBtnClicked:(UIButton*)btn
{
	if (!btn.selected)
		return;
	
	listBtn.selected	=	TRUE;
	mapBtn.selected		=	TRUE;
	btn.selected		=	FALSE;
	
	for (UIView *toRemove in [contentView subviews])
		[toRemove		removeFromSuperview];
	
	if ([btn isEqual:listBtn])
	{
		[contentView	addSubview:listView];
	}else if ([btn isEqual:mapBtn])
	{
		[contentView	addSubview:mapV];
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [indexArray count];
}

//---set the title for each section---
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [indexArray objectAtIndex:section];
    
}

//---set the index for the table---
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return indexArray;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *alphabet = [indexArray objectAtIndex:section];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"store_city beginswith[c] %@", alphabet];
    NSArray *names = [stores  filteredArrayUsingPredicate:predicate];
    return [names count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [listView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString *alphabet = [indexArray objectAtIndex:indexPath.section];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"store_city beginswith[c] %@", alphabet];
    NSArray *names = [stores  filteredArrayUsingPredicate:predicate];
    cell.textLabel.text = [[names objectAtIndex:indexPath.row] objectForKey:@"store_city"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *alphabet = [indexArray objectAtIndex:indexPath.section];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"store_city beginswith[c] %@", alphabet];
    NSArray *names = [stores  filteredArrayUsingPredicate:predicate];
	NSDictionary *tempDico = [names objectAtIndex:indexPath.row];
    
    BAPCommande *commande = [BAPCommande sharedInstance];
    commande.storeId = [BAPMethode getKeyStores:tempDico];
    
    [BAPMethode accountAddStore:commande.storeId];
    
    BAPMenuViewController_iphone	*menu = [[BAPMenuViewController_iphone alloc] initWithNibName:@"BAPMenuViewController_iphone" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:menu animated:TRUE];
    [menu release];
}

#pragma mark UITableView MAPView


-(void)initMap{
    
    CLLocationCoordinate2D center;
    center.latitude = 2.24; center.longitude = 48.0;
    float zoom = 10;
    
	if(mapV.userLocation.location != nil){
        center = mapV.userLocation.location.coordinate;
        zoom = 0.5;
    }
    MKCoordinateRegion region;
    region.center = center;
	MKCoordinateSpan span;
	span.latitudeDelta = zoom;
	span.longitudeDelta = zoom;
	region.span = span;
    [mapV setRegion:region];
    
    if(mapV.annotations.count <= 1){
        for(NSDictionary *store in stores){
            BAPMapAnnotation *annotation = [[BAPMapAnnotation alloc] initWithStore:store];
            [mapV addAnnotation:annotation];
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
	
    BAPCommande *commande = [BAPCommande sharedInstance];
    commande.storeId = [BAPMethode getKeyStores:((BAPMapAnnotation*)(view.annotation)).store];
    
    [BAPMethode accountAddStore:commande.storeId];
    
	BAPMenuViewController_iphone	*menu = [[BAPMenuViewController_iphone alloc] initWithNibName:@"BAPMenuViewController_iphone" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:menu animated:TRUE];
    [menu release];
    
    [mapV deselectAnnotation:view.annotation animated:NO];
}


@end