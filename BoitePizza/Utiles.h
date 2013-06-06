//
//  Utiles.h
//  ParadisLatin
//
//  Created by Mohamed on 06/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"

#define LocStr(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

UIView      *loadingPanel;
UIAlertView *connecxionMsgErr;


@interface Utiles : NSObject 
{

}


+(id)delegate;
+(void)pushNotificationInscription;
+(void)connectionEchecMsg;
+ (void)removeOldImageFiles;
+(void)createLoadingPanelView:(UIView*)vue;
+(BOOL)isCorrectEmail:(NSString *)string;
+(BOOL)isNumeric:(NSString *)string;
+(void)stopLoading;
+(void) startLoading:(UIView *)vue  :(BOOL) bloqueInteraction;
+(UIImage *)backRoundSelonLangue:(NSString *)image;
+(NSArray *)firstLetterList:(NSArray *)dataList;
+(NSArray *)ListOfDataBeginWith:(NSString *)firstLetter :(NSArray *)data;


//Méthodes à Flo
+(NSString *)md5Hash:(NSString*) string;
+(NSString*)stringDate:(NSString*)pDate withFormat:(NSString*)pOriginFormat toFormat:(NSString*)pGoalFormat;
+(int)intervalFromStringDate:(NSString*)pDate withFormat:(NSString*)pOriginFormat;
+(UIImage*)imageNamed:(NSString*)pImageName withExtension:(NSString*)pExtension;
+(UIImage*)imageNamed:(NSString*)pImageName;
+(void)setIncrustationEffectToView:(UIView*)pView;


+(float)distanceBetweenFirstPoint:(CGPoint)fPoint andSecondPoint:(CGPoint)sPoint;
+(float)distanceBetweenFirstGpsPoint:(CGPoint)fPoint andSecondGpsPoint:(CGPoint)sPoint;
+(UIImage *)imageRepresentationOfView:(UIView*)myView;

+(UIImage *)convertToGrayscale:(UIImage *)img ;

+(float)resolveOperationFromString:(NSString*)pString;

+(void)underlineLabel:(UILabel*)pLbl;

+(NSDictionary *)readDictionaryNamed:(NSString*)name;
+(BOOL)writeDictionary:(NSDictionary *)data named:(NSString*)name;
+(BOOL)deleteDictionaryNamed:(NSString*)name;

+(BOOL)stringIsNotNull:(NSString*)string;
+(BOOL)checkInternet;

+(NSString*)getNameOfFrenchDepartmentWithNumber:(int)num;
+(BOOL)isIpad;
+(UIImage*)maskImage:(UIImage *)maskImage andColor:(UIColor *)colorToFill;

@end
