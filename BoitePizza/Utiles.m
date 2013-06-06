//
//  Utiles.m
//  ParadisLatin
//
//  Created by Mohamed on 06/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Utiles.h"


@implementation Utiles


+(id)delegate
{
	return (id)([UIApplication sharedApplication].delegate);
}

+(void)pushNotificationInscription{
	
	if([Utiles readDictionaryNamed:@"apnsCode"]  == nil)
		[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
}

+(void)connectionEchecMsg
{
    if(connecxionMsgErr == nil){
        connecxionMsgErr = [[UIAlertView alloc] initWithTitle:@"Connexion Internet requise" message:@"Vous devez disposer d'une connexion internet active (Edge, 3G ou Wifi) pour accéder à l'application. \n Veuillez vérifier ces paramétres dans les réglages de votre terminal." delegate:self cancelButtonTitle:@"Fermer" otherButtonTitles:nil] ;
    }
    if(!connecxionMsgErr.isVisible){
        [connecxionMsgErr show];
    }
}

#pragma mark nettoyages des images obsolétes
+ (void)removeOldImageFiles
{
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSFileManager *fm = [NSFileManager defaultManager];
	NSDirectoryEnumerator *direnum = [fm enumeratorAtPath:documentsDir];
	NSString *pname;
	while ((pname = [direnum nextObject]))
	{
		if (!([[pname pathExtension] isEqualToString:@"jpg"] || [[pname pathExtension] isEqualToString:@"png"]))
		{
			[direnum skipDescendents];
		}
		else
		{
			NSDate * lastUpdate = (NSDate *)[[fm attributesOfItemAtPath:[documentsDir stringByAppendingPathComponent:pname] error:NULL] objectForKey:NSFileModificationDate];
			if([lastUpdate timeIntervalSinceNow] < (-1 * 3600 * 24 * 15))
				[fm removeItemAtPath:[documentsDir stringByAppendingPathComponent:pname] error:NULL];
		}
	}
}


+(void)createLoadingPanelView:(UIView*) vue
{
	loadingPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
	loadingPanel.backgroundColor = [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.8] autorelease];
	UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[(CALayer*)[loadingPanel layer] setCornerRadius:10.0];
	
	[loadingPanel setCenter:CGPointMake(120/2 + (vue.frame.size.width - vue.frame.origin.x - 120) / 2, 120/2 + (vue.frame.size.height - vue.frame.origin.y - 120) / 2)];
	
	activity.center = CGPointMake(60, 52);
	[loadingPanel addSubview:activity];
	[activity startAnimating];
	[activity release];
	UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
	tempLabel.text = LocStr(@"Chargement...");
	tempLabel.center = CGPointMake(62, 90);
	[tempLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
	
 	tempLabel.textColor = [UIColor whiteColor];
	tempLabel.textAlignment = UITextAlignmentCenter;
	tempLabel.backgroundColor = [UIColor clearColor];
	[loadingPanel addSubview:tempLabel];
	[tempLabel release];
}


#pragma mark Gestion de l'activityView
+(void)stopLoading
{
	//NSLog(@"stop loading panel");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[[self delegate] window].userInteractionEnabled = YES;
	[loadingPanel removeFromSuperview];
}


+(void) startLoading:(UIView *)vue  :(BOOL) bloqueInteraction
{
	//NSLog(@"start loading panel");
	[[self delegate] window].userInteractionEnabled = bloqueInteraction;	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[Utiles createLoadingPanelView:vue];
	//	loadingPanel.center = vue.center;
	[vue addSubview:loadingPanel];	
}



#pragma mark check correct mail et tel
+(BOOL)isCorrectEmail:(NSString *)string{
	NSString *compare = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	BOOL hasOneAt = NO;
	BOOL hasDotAfterAt = NO;
	if([compare hasSuffix:@"."])
		return NO;
    for (NSUInteger i = 0; i < [compare length]; i++) 
    {
        unichar oneChar = [compare characterAtIndex:i];
        if (oneChar == '@'){
			if(i == 0)
				return NO;
			if(hasOneAt)
				return NO;
			else
				hasOneAt = YES;
		}
		if(oneChar == '.' && hasOneAt){
			if(i == 0)
				return NO;
			if([compare characterAtIndex:(i-1)] != '@'){
				hasDotAfterAt = YES;
			}
		}
    }
    return (hasOneAt && hasDotAfterAt);
}


+(BOOL)isNumeric:(NSString *)string{
	NSString *compare = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSCharacterSet *validCharacters = [NSCharacterSet decimalDigitCharacterSet];
    for (NSUInteger i = 0; i < [compare length]; i++) 
    {
        unichar oneChar = [compare characterAtIndex:i];
        if (![validCharacters characterIsMember:oneChar])
            return NO;
    }
    return YES;
}

#pragma mark images de fond selon langue
+(UIImage *)backRoundSelonLangue:(NSString *)image{
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
	NSString *currentLanguage = [languages objectAtIndex:0];
	
	if([currentLanguage isEqualToString:@"en"])
		return [UIImage imageNamed:[NSString stringWithFormat:@"%@FR.png",image]];
	if([currentLanguage isEqualToString:@"fr"])
		return [UIImage imageNamed:[NSString stringWithFormat:@"%@FR.png",image]];	
	return nil;
}



#pragma mark Gestion du rangement par ordre alphabetics
+(NSArray *)firstLetterList:(NSArray *)dataList{
		
	NSMutableDictionary *alphabets = [NSMutableDictionary dictionary];
 	NSMutableArray *ret = [[NSMutableArray alloc] init];
	
	for(NSDictionary *dataTemp in dataList){	
		//NSString *firstLetter = [[dataTemp objectAtIndex:1] substringToIndex:1];
		NSString *firstLetter = [[dataTemp objectForKey:@"nom"] substringToIndex:1];
		NSString *minisculFirstLetter =  [firstLetter lowercaseString];
		NSString *majisculFirstLetter =  [firstLetter uppercaseString];
			
		if([alphabets objectForKey:majisculFirstLetter] == nil && [alphabets objectForKey:minisculFirstLetter] == nil)	{
			[alphabets setValue:@"" forKey:majisculFirstLetter];
			[ret addObject:majisculFirstLetter];
		}
	}	
	return [ret autorelease];
}


+(NSArray *)ListOfDataBeginWith:(NSString *)firstLetter :(NSArray *)data{
	
	NSMutableArray *ret = [[NSMutableArray alloc] init];
 	
	for(int i =0;i < [data count]; i++){
		NSString *firstLetterData = [[[data objectAtIndex:i] objectForKey:@"nom"] substringToIndex:1];
		NSString *majisculFirstLetter =  [firstLetterData uppercaseString];
		
		if([firstLetter isEqualToString:majisculFirstLetter])	[ret addObject:[data objectAtIndex:i]];
	}	
	return [ret autorelease];
}



//Méthodes à Flo

+(NSString *)md5Hash:(NSString*) string
{
	const char *cStr = [string UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
			];
}

+(NSString*)stringDate:(NSString*)pDate withFormat:(NSString*)pOriginFormat toFormat:(NSString*)pGoalFormat
{

	NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
	[dateFormat setDateFormat:pOriginFormat];
	NSDate *targetDate = [dateFormat dateFromString:pDate];
	[dateFormat setDateFormat:pGoalFormat];
	NSString *tempS = [dateFormat stringFromDate:targetDate];
	[dateFormat release];
	return tempS;
}

+(int)intervalFromStringDate:(NSString*)pDate withFormat:(NSString*)pOriginFormat
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
	[dateFormat setDateFormat:pOriginFormat];
	NSDate *targetDate = [dateFormat dateFromString:pDate];
	[dateFormat release];
	int i = [targetDate timeIntervalSinceNow];
	return i;
}

+(UIImage*)imageNamed:(NSString*)pImageName withExtension:(NSString*)pExtension
{
	if (pExtension == nil ) pExtension = @"png";
	
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:pImageName ofType:pExtension inDirectory:nil]];;
}

+(UIImage*)imageNamed:(NSString*)pImageName
{
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:pImageName ofType:@"png" inDirectory:nil]];;
}


+(void)setIncrustationEffectToView:(UIView*)pView
{
	if ([[[[[UIDevice	currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] < 4) 
		return;

	[pView.layer setShadowOffset:CGSizeMake(0, -1)];
	[pView.layer setShadowRadius:0.5];
	[pView.layer setShadowOpacity:0.5];

}


+(float)distanceBetweenFirstPoint:(CGPoint)fPoint andSecondPoint:(CGPoint)sPoint
{
	float x = sPoint.x - fPoint.x;
	float y = sPoint.y - fPoint.y;
	
	return sqrt(x * x + y * y);
}

+(float)distanceBetweenFirstGpsPoint:(CGPoint)fPoint andSecondGpsPoint:(CGPoint)sPoint
{
	
	float	a = M_PI / 180.0;
	
	float	lat1	=	fPoint.x * a;
	float	lat2	=	sPoint.x * a;
	float	lng1	=	fPoint.y * a;
	float	lng2	=	sPoint.y * a;
	float	t1		=	sinf(lat1) * sinf(lat2);
	float	t2		=	cosf(lat1) * cosf(lat2);
	float	t3		=	cosf(lng1 - lng2);
	float	t4		=	t2 * t3;
	float	t5		=	t1 + t4;
	float	radDist	=	atanf(-t5 / sqrtf(-t5 * t5 + 1)) + 2 * atanf(1);
	
	return (radDist * 3437.74677 * 1.1508) * 1.6093470878864446;

}

+(UIImage *)imageRepresentationOfView:(UIView*)myView 
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef contentContext = CGBitmapContextCreate (
														 NULL,
														 myView.bounds.size.width,myView.bounds.size.height,
														 8, 0, colorSpace, kCGImageAlphaPremultipliedLast
														 );
	CGColorSpaceRelease(colorSpace);
	if (contentContext == nil)
		return nil;
	CGContextScaleCTM(contentContext, 1, -1);
	CGContextTranslateCTM(contentContext, 0, -myView.bounds.size.height);
	[[myView layer] renderInContext:contentContext];
	CGImageRef contentImageRef = CGBitmapContextCreateImage(contentContext);
	UIImage *myImage = [UIImage imageWithCGImage:contentImageRef];
	CGContextRelease(contentContext);
	CGImageRelease(contentImageRef);
	return myImage;
}


//
typedef enum {
    ALPHA = 0,
    BLUE = 1,
    GREEN = 2,
    RED = 3
} PIXELS;


+ (UIImage *)convertToGrayscale:(UIImage *)img 
{
    CGSize size = [img size];
    int width = size.width;
    int height = size.height;
	
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
	
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
	
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [img CGImage]);
	
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
			
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
			
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
	
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
	
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
	
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
	
    // we're done with image now too
    CGImageRelease(image);
	
    return resultUIImage;
}


+(float)resolveOperationFromString:(NSString*)pString
{
	NSPredicate *pred	= [NSPredicate predicateWithFormat:
						   [pString stringByAppendingString:@" == 42"]];
	NSExpression *exp	= [(NSComparisonPredicate *)pred leftExpression];
	NSNumber *result	= [exp expressionValueWithObject:nil context:nil];
	
	
	return	[result	floatValue];
}

+(void)underlineLabel:(UILabel*)pLbl
{
	CGSize textSize = [pLbl.text	sizeWithFont:pLbl.font];
	UIView	*underLine	=	[[UIView	alloc]	initWithFrame:CGRectMake(0, pLbl.frame.size.height*0.9, textSize.width, 2)];
	[underLine setCenter:CGPointMake(pLbl.frame.size.width/2.0, underLine.center.y)];
	underLine.backgroundColor	=	pLbl.textColor;
	[pLbl addSubview:underLine];
	[underLine	release];
}



+(NSDictionary *)readDictionaryNamed:(NSString*)name
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",name]];
	NSDictionary *res = nil;
	NSFileManager *fm = [NSFileManager defaultManager];
	if(![fm fileExistsAtPath:dataFilePath])	
		res = nil;
	else	
		res = [NSDictionary dictionaryWithContentsOfFile:dataFilePath ];
	return res;
}

+(BOOL)writeDictionary:(NSDictionary *)data named:(NSString*)name
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",name]];
	return [data writeToFile:dataFilePath atomically:YES];
}


+(BOOL)deleteDictionaryNamed:(NSString*)name
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",name]];
	BOOL res;
	NSFileManager *fm = [NSFileManager defaultManager];
	if(![fm fileExistsAtPath:dataFilePath])
		res = FALSE;
	else	
		res = [fm	removeItemAtPath:dataFilePath error:nil];
	return res;

	
}

+(BOOL)stringIsNotNull:(NSString*)string
{
	if ([string isKindOfClass:[NSNull class]])
	{
		return FALSE;
	}else if ([string length] < 1)
	{
		return FALSE;
	}else
	{
		return TRUE;
	}
	
	
}

+(BOOL)checkInternet
{
	Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	
	if (internetStatus == NotReachable)
		return FALSE;
	else
		return TRUE;
}

+(NSString*)getNameOfFrenchDepartmentWithNumber:(int)num
{
	NSString	*temp;
	
	switch (num)
	{
		case 1 :
			temp = @"Ain";
			break;
		case 2  :
			temp = @"Aisne";
			break;
		case 3  :
			temp = @"Allier";
			break;
		case 4  :
			temp = @"Alpes-de-Haute-Provence";
			break;
		case 5  :
			temp = @"Hautes-Alpes";
			break;
		case 6  :
			temp = @"Alpes-Maritimes";
			break;
		case 7  :
			temp = @"Ardèche";
			break;
		case 8  :
			temp = @"Ardennes";
			break;
		case 9  :
			temp = @"Ariège";
			break;
		case 10  :
			temp = @"Aube";
			break;
		case 11  :
			temp = @"Aude";
			break;
		case 12  :
			temp = @"Aveyron";
			break;
		case 13  :
			temp = @"Bouches-du-Rhône";
			break;
		case 14  :
			temp = @"Calvados";
			break;
		case 15  :
			temp = @"Cantal";
			break;
		case 16  :
			temp = @"Charente";
			break;
		case 17  :
			temp = @"Charente-Maritime";
			break;
		case 18  :
			temp = @"Cher";
			break;
		case 19  :
			temp = @"Corrèze";
			break;
		case 20  :
			temp = @"Corse";
			break;
		case 21  :
			temp = @"Côte-d'Or";
			break;
		case 22  :
			temp = @"Côtes-d'Armor";
			break;
		case 23  :
			temp = @"Creuse";
			break;
		case 24  :
			temp = @"Dordogne";
			break;
		case 25  :
			temp = @"Doubs";
			break;
		case 26  :
			temp = @"Drôme";
			break;
		case 27  :
			temp = @"Eure";
			break;
		case 28  :
			temp = @"Eure-et-Loir";
			break;
		case 29  :
			temp = @"Finistère";
			break;
		case 30  :
			temp = @"Gard";
			break;
		case 31  :
			temp = @"Haute-Garonne";
			break;
		case 32  :
			temp = @"Gers";
			break;
		case 33  :
			temp = @"Gironde";
			break;
		case 34  :
			temp = @"Hérault";
			break;
		case 35  :
			temp = @"Ille-et-Vilaine";
			break;
		case 36  :
			temp = @"Indre";
			break;
		case 37  :
			temp = @"Indre-et-Loire";
			break;
		case 38  :
			temp = @"Isère";
			break;
		case 39  :
			temp = @"Jura";
			break;
		case 40  :
			temp = @"Landes";
			break;
		case 41  :
			temp = @"Loir-et-Cher";
			break;
		case 42  :
			temp = @"Loire";
			break;
		case 43  :
			temp = @"Haute-Loire";
			break;
		case 44 :
			temp = @"Loire-Atlantique";
			break;
		case 45  :
			temp = @"Loiret";
			break;
		case 46  :
			temp = @"Lot";
			break;
		case 47  :
			temp = @"Lot-et-Garonne";
			break;
		case 48  :
			temp = @"Lozère";
			break;
		case 49  :
			temp = @"Maine-et-Loire";
			break;
		case 50  :
			temp = @"Manche";
			break;
		case 51  :
			temp = @"Marne";
			break;
		case 52  :
			temp = @"Haute-Marne";
			break;
		case 53  :
			temp = @"Mayenne";
			break;
		case 54  :
			temp = @"Meurthe-et-Moselle";
			break;
		case 55  :
			temp = @"Meuse";
			break;
		case 56  :
			temp = @"Morbihan";
			break;
		case 57  :
			temp = @"Moselle";
			break;
		case 58  :
			temp = @"Nièvre";
			break;
		case 59  :
			temp = @"Nord";
			break;
		case 60  :
			temp = @"Oise";
			break;
		case 61  :
			temp = @"Orne";
			break;
		case 62  :
			temp = @"Pas-de-Calais";
			break;
		case 63  :
			temp = @"Puy-de-Dôme";
			break;
		case 64  :
			temp = @"Pyrénées-Atlantiques";
			break;
		case 65  :
			temp = @"Hautes-Pyrénées";
			break;
		case 66  :
			temp = @"Pyrénées-Orientales";
			break;
		case 67  :
			temp = @"Bas-Rhin";
			break;
		case 68  :
			temp = @"Haut-Rhin";
			break;
		case 69  :
			temp = @"Rhône";
			break;
		case 70  :
			temp = @"Haute-Saône";
			break;
		case 71  :
			temp = @"Saône-et-Loire";
			break;
		case 72  :
			temp = @"Sarthe";
			break;
		case 73  :
			temp = @"Savoie";
			break;
		case 74  :
			temp = @"Haute-Savoie";
			break;
		case 75  :
			temp = @"Paris";
			break;
		case 76  :
			temp = @"Seine-Maritime";
			break;
		case 77  :
			temp = @"Seine-et-Marne";
			break;
		case 78  :
			temp = @"Yvelines";
			break;
		case 79  :
			temp = @"Deux-Sèvres";
			break;
		case 80  :
			temp = @"Somme";
			break;
		case 81  :
			temp = @"Tarn";
			break;
		case 82  :
			temp = @"Tarn-et-Garonne";
			break;
		case 83  :
			temp = @"Var";
			break;
		case 84  :
			temp = @"Vaucluse";
			break;
		case 85  :
			temp = @"Vendée";
			break;
		case 86  :
			temp = @"Vienne";
			break;
		case 87  :
			temp = @"Haute-Vienne";
			break;
		case 88  :
			temp = @"Vosges";
			break;
		case 89  :
			temp = @"Yonne";
			break;
		case 90  :
			temp = @"Territoire de Belfort";
			break;
		case 91  :
			temp = @"Essonne";
			break;
		case 92  :
			temp = @"Hauts-de-Seine";
			break;
		case 93  :
			temp = @"Seine-Saint-Denis";
			break;
		case 94  :
			temp = @"Val-de-Marne";
			break;
		case 95  :
			temp = @"Val-d'Oise	";
			break;
		case 971 :
			temp = @" Guadeloupe";
			break;
		case 972 :
			temp = @" Martinique";
			break;
		case 973 :
			temp = @" Guyane";
			break;
		case 974 :
			temp = @" La Réunion";
			break;
		case 976 :
			temp = @"Mayotte";
			break;

		default:
			temp = @"";
			break;
	}

	return temp;
}


+(BOOL)isIpad{
	
	return !([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}


+(UIImage*)maskImage:(UIImage *)maskImage andColor:(UIColor *)colorToFill
{
	
	// load the image
	UIImage * img = maskImage;
	
	// begin a new image context, to draw our colored image onto
	
	if(CGImageGetWidth([img CGImage]) == img.size.width * img.scale){
		UIGraphicsBeginImageContext(CGSizeMake( img.size.width * img.scale, img.size.height * img.scale));
	}else{
		UIGraphicsBeginImageContext(img.size);
	}
	
	// get a reference to that context we created
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShouldAntialias(context, YES);
	// set the fill color
	[colorToFill setFill];
	
	// translate/flip the graphics context (for transforming from CG* coords to UI* coords
	// CGContextTranslateCTM(context, 0, img.size.height);
	// CGContextScaleCTM(context, 1.0, -1.0);
	
	// set the blend mode to color burn, and the original image
	CGContextSetBlendMode(context, kCGBlendModeNormal);
	CGRect rect = CGRectZero;
	
	if(CGImageGetWidth([img CGImage]) == img.size.width * img.scale){
		rect = CGRectMake(0, 0, img.size.width * img.scale, img.size.height * img.scale);
	}else{
		rect = CGRectMake(0, 0, img.size.width, img.size.height);
	}
	
	CGContextDrawImage(context, rect, img.CGImage);
	
	// set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
	CGContextClipToMask(context, rect, img.CGImage);
	CGContextAddRect(context, rect);
	CGContextDrawPath(context,kCGPathFill);
	
	CGImageRef cgImage = CGBitmapContextCreateImage(context);
	UIImage* resultImage = [[[UIImage alloc] initWithCGImage:cgImage scale:img.scale orientation:UIImageOrientationDownMirrored] autorelease];
	CFRelease(cgImage);
	// generate a new UIImage from the graphics context we drew onto
	
	UIGraphicsEndImageContext();
	
	//return the color-burned image
	return resultImage;
}


@end

