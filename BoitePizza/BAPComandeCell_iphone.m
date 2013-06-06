//
//  BAPComandeCell.m
//  BoitePizza
//
//  Created by Mohamed Boumansour on 28/03/13.
//
//

#import "BAPComandeCell_iphone.h"
#import "BAPCommande.h"

@implementation BAPComandeCell_iphone


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1)    {
        [[BAPCommande sharedInstance] removeProduct:tempProduct];
        tempProduct = nil;
        UITableView *temp = (UITableView *)self.superview;
        UIViewController *vc = (UIViewController *)temp.delegate;
        [vc viewDidAppear:NO];
    }
}


-(void)addBtnClicked
{
	tempProduct.quantite = [NSString stringWithFormat:@"%i", [tempProduct.quantite intValue] + 1];
    qtLbl.text = [NSString stringWithFormat:@"%i", [tempProduct.quantite intValue]];
    priceTotalLbl.text = [NSString stringWithFormat:@"%.2f €", [priceLbl.text floatValue]*[tempProduct.quantite intValue]];
    UITableView *temp = (UITableView *)self.superview;
    UIViewController *vc = (UIViewController *)temp.delegate;
    [vc viewDidAppear:NO];
}

-(void)lessBtnClicked
{
	if([tempProduct.quantite intValue] > 1){
        tempProduct.quantite = [NSString stringWithFormat:@"%i", [tempProduct.quantite intValue] - 1];
        qtLbl.text = [NSString stringWithFormat:@"%i", [tempProduct.quantite intValue]];
        priceTotalLbl.text = [NSString stringWithFormat:@"%.2f €", [priceLbl.text floatValue]*[tempProduct.quantite intValue]];
        UITableView *temp = (UITableView *)self.superview;
        UIViewController *vc = (UIViewController *)temp.delegate;
        [vc viewDidAppear:NO];
    }else{
        UIAlertView *alertEvent			=		[[UIAlertView alloc]initWithTitle:@""
                                                               message:@"Voulez-vous supprimer ce produit"
                                                              delegate:self
                                                     cancelButtonTitle:@"Non"
                                                     otherButtonTitles:@"Oui",nil];
        [alertEvent		show];
        [alertEvent		release];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier FM:(BOOL)finalMode
{
    xImage = 15;   yImage = 10;
    withImg = 80;  heightImg = 75;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 200)];
		[bgImg setImage:[UIImage imageNamed:@"table-produit"]];
		[self	addSubview:bgImg];
        
        
        img = [[AsyncUIImageView alloc] initWithFrame:CGRectMake(xImage, yImage, withImg, heightImg)];
		[self addSubview:img];
		
		
		
		titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, 190, 20)];
		titleLbl.backgroundColor = [UIColor clearColor];
		titleLbl.textColor = [UIColor colorWithRed:0.82 green:0.11 blue:0.12 alpha:1.0];
		titleLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
		titleLbl.text = @"PIZZAAAA";
       // titleLbl.numberOfLines = 2;
		[self addSubview:titleLbl];
        
		
		
		descrLbl = [[UILabel alloc]initWithFrame:CGRectMake(110, 30, 180, 55)];
		descrLbl.backgroundColor = [UIColor clearColor];
		descrLbl.textColor = [UIColor blackColor];
		descrLbl.numberOfLines = 3;
		descrLbl.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
		descrLbl.text = @"PIZZAAAA DESCRIPTIIOONNN";
		[self addSubview:descrLbl];
		
		
        UILabel *tempLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 95, 80, 20)];
        tempLbl1.text = @"Quantité";
        [self addSubview:tempLbl1];
        [tempLbl1 release];
        
        qtLbl = [[UILabel alloc]initWithFrame:CGRectMake(233, 95, 40, 20)];
		qtLbl.textAlignment = UITextAlignmentCenter;
		qtLbl.backgroundColor = [UIColor clearColor];
		qtLbl.textColor = [UIColor colorWithRed:0.82 green:0.11 blue:0.12 alpha:1.0];
		qtLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
		qtLbl.text = @"0";
		[self addSubview:qtLbl];
        
        
        plusBtn			=	[[UIButton			alloc]	initWithFrame:CGRectMake(270, 95, 20, 20)];
        [plusBtn setImage:[UIImage imageNamed:@"btn-add"] forState:UIControlStateNormal];
        [plusBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        
        moinBtn			=	[[UIButton			alloc]	initWithFrame:CGRectMake(215, 95, 20, 20)];
        [moinBtn setImage:[UIImage imageNamed:@"btn-delete"] forState:UIControlStateNormal];
        [moinBtn addTarget:self action:@selector(lessBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moinBtn];
        
        if(finalMode)   {
            plusBtn.hidden = moinBtn.hidden = YES;
        }else   plusBtn.hidden = moinBtn.hidden = NO;
        
        UILabel *tempLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 133, 160, 20)];
        tempLbl2.text = @"Prix unitaire";
        [self addSubview:tempLbl2];
        [tempLbl2 release];
        
		
		priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(220, 133, 70, 20)];
		priceLbl.textAlignment = UITextAlignmentCenter;
		priceLbl.backgroundColor = [UIColor clearColor];
		priceLbl.textColor = [UIColor colorWithRed:0.82 green:0.11 blue:0.12 alpha:1.0];
		priceLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
		priceLbl.text = @"35€92";
		[self addSubview:priceLbl];
        
        UILabel *tempLbl3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 165, 160, 20)];
        tempLbl3.text = @"Prix total";
        [self addSubview:tempLbl3];
        [tempLbl3 release];
        
        priceTotalLbl = [[UILabel alloc]initWithFrame:CGRectMake(220, 165, 70, 20)];
		priceTotalLbl.textAlignment = UITextAlignmentCenter;
		priceTotalLbl.backgroundColor = [UIColor clearColor];
		priceTotalLbl.textColor = [UIColor colorWithRed:0.82 green:0.11 blue:0.12 alpha:1.0];
		priceTotalLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
		priceTotalLbl.text = @"35€92";
		[self addSubview:priceTotalLbl];

    }
    return self;
}

-(void)setCellWithInfos:(BAPProduct*)product
{
    tempProduct = product;
	titleLbl.text = [product.name capitalizedString];
	descrLbl.text = [product.description capitalizedString];
	
    priceLbl.text = [NSString stringWithFormat:@"%.2f €", [product getPrice]];
    
	qtLbl.text = [NSString stringWithFormat:@"%i", [product.quantite intValue]];
    priceTotalLbl.text = [NSString stringWithFormat:@"%.2f €", [product getPrice]*[product.quantite intValue]];
	
	[img		removeFromSuperview];
	[img		release];
	img			=	nil;
    
    for(UIView *v in bgImg.subviews)    [v removeFromSuperview];
    
    if([product.category isEqualToString:catMenu])    { //Menu
        
        //titleLbl.frame = CGRectMake(20, -6, 190, 30);
        xImage = 20;    yImage = 30;
        withImg = 188;  heightImg = 61.5;
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 290, 84)];
        [(CALayer*)[colorView layer] setCornerRadius:4];
        colorView.backgroundColor = [UIColor grayColor];
        [bgImg insertSubview:colorView atIndex:1];
        [colorView release];
        
    }else{
        
        xImage = 15;   yImage = 10;
        withImg = 80;  heightImg = 75;
    }
	
	img = [[AsyncUIImageView alloc] initWithFrame:CGRectMake(xImage, yImage, withImg, heightImg)];
	[img			setWithLoadingPanel:TRUE];
	[img loadWithContentsOfUrl:[NSURL URLWithString:product.picture] storedImageName:product.name];
	
	[self		addSubview:img];
	
}

@end
