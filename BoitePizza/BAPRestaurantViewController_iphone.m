//
//  BAPRestaurantViewController_iphone.m
//  BoitePizza
//
//  Created by Mohammed on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BAPRestaurantViewController_iphone.h"

@interface BAPRestaurantViewController_iphone ()

@end

@implementation BAPRestaurantViewController_iphone
@synthesize storesTable;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
		
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [stores release];
    [indexArray release];
    stores = [[BAPMethode getStores] copy];
    indexArray = [[BAPMethode getAlphabets:stores] copy];
    [storesTable reloadData];
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
    
    UITableViewCell *cell = [storesTable dequeueReusableCellWithIdentifier:CellIdentifier];
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
	BAPRestaurantDetailViewController_iphone *restauVc	=	[[BAPRestaurantDetailViewController_iphone	alloc]	initWithNibName:@"BAPRestaurantDetailViewController_iphone" bundle:[NSBundle mainBundle]];
	
    NSString *alphabet = [indexArray objectAtIndex:indexPath.section];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"store_city beginswith[c] %@", alphabet];
    NSArray *names = [stores  filteredArrayUsingPredicate:predicate];
    restauVc.store = [names objectAtIndex:indexPath.row];
    
    [self.navigationController	pushViewController:restauVc animated:TRUE];
	[restauVc	release];
}


@end
