//
//  DataOpsDelegate.m
//  Shopper
//
//  Created by Ninan Thomas on 3/9/16.
//
//

#import "DataOpsDelegate.h"
#import "AppDelegate.h"
#import "Item.h"
#import "LocalItem.h"

@implementation DataOpsDelegate


-(bool) updateEditedItem:(id) itm local:(id) litm
{
    CarItem *item = itm;
    LocalItem *litem = litm;
    NSArray *album_arr = [item.album_name componentsSeparatedByString:@"/"];
    NSArray *lalbum_arr = [litem.album_name componentsSeparatedByString:@"/"];
    NSUInteger alindx = [album_arr count];
    NSUInteger lalindx = [lalbum_arr count];
    if (alindx >=2)
        alindx -= 2;
    else if (alindx == 1)
        alindx -= 1;
    else
        return false;
    if (lalindx >=2)
        lalindx -= 2;
    else if (lalindx == 1)
        lalindx -= 1;
    else
        return  false;
NSString *album_name = [album_arr objectAtIndex:alindx];
NSString *lalbum_name = [lalbum_arr objectAtIndex:lalindx];
if ([album_name isEqualToString:lalbum_name])
{
    [item copyFromLocalItem:litem copyAlbumName:true];
    NSLog(@"Updated edited item %@ album_name=%@ lalbum_name=%@\n", item.name, album_name, lalbum_name);
    return true;
}
    return false;
    
}

-(NSString *) getAlbumName:(id) itm
{
    if ([itm isKindOfClass:[CarItem class]])
    {
        CarItem *item = itm;
        return item.album_name;
    }
    else
    {
        LocalItem *litem = itm;
        return litem.album_name;
    }
    return nil;
}

-(id) getNewItem:(NSEntityDescription *) entity context:(NSManagedObjectContext *) managedObjectContext
{
    CarItem *newItem = [[CarItem alloc]
     initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    return newItem;
}

-(void) addToCount
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [pDlg addToCount];
    return;
}

-(NSString *) getSearchStr
{
  AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return pDlg.pSearchStr;
}

-(void) copyFromLocalItem:(id) itm local:(id)litm
{
    CarItem *item = itm;
    LocalItem *litem = litm;
    [item copyFromLocalItem:litem copyAlbumName:true];
    return;
}

-(void) copyFromItem:(id) itm local:(id)litm
{
    CarItem *item = itm;
    LocalItem *litem = litm;
    [litem copyFromItem:item];
    return;
}

-(NSString *) sortDetails:(bool *)ascending
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    switch (pDlg.sortIndx)
    {
            
        case 1:
        {
            *ascending = pDlg.bPriceAsc;
            return @"price";
        }
        break;
        case 2:
        {
            *ascending = pDlg.bMakeAsc;
            return @"make";
        }
        break;
        case 3:
        {
            *ascending = pDlg.bYearAsc;
            return @"year";
           
        }
        break;
        case 4:
        {
            *ascending = pDlg.bModelAsc;
            return @"model";
        }
            break;
        case 5:
        {
            *ascending = pDlg.bMilesAsc;
            return @"miles";
        }
        break;
        case 0:
        {
            *ascending = pDlg.bDateAsc;
            return @"date";
        }
            break;
            
        default:
            break;
    }

    return nil;
}

-(NSString *)getAddtionalPredStr:(NSUInteger) scnt predStrng:(NSString *)predStr
{


    predStr = [predStr stringByAppendingString:@" OR "];
    for (NSUInteger i=0; i < scnt; ++i)
    {
        if (i == 0)
            predStr = [predStr stringByAppendingString:@"(model contains [cd] %@"];
        else
            predStr = [predStr stringByAppendingString:@"model contains [cd] %@"];
    
        if (i != scnt -1)
            predStr = [predStr stringByAppendingString:@" AND "];
        else
            predStr = [predStr stringByAppendingString:@" )"];
    
    }

    predStr = [predStr stringByAppendingString:@" OR "];
    for (NSUInteger i=0; i < scnt; ++i)
    {
        if (i == 0)
            predStr = [predStr stringByAppendingString:@"(make contains [cd] %@"];
        else
            predStr = [predStr stringByAppendingString:@"make contains [cd] %@"];
    
        if (i != scnt -1)
            predStr = [predStr stringByAppendingString:@" AND "];
        else
            predStr = [predStr stringByAppendingString:@" )"];
    
    }

    predStr = [predStr stringByAppendingString:@" OR "];
    for (NSUInteger i=0; i < scnt; ++i)
    {
        if (i == 0)
            predStr = [predStr stringByAppendingString:@"(color contains [cd] %@"];
        else
            predStr = [predStr stringByAppendingString:@"color contains [cd] %@"];
    
        if (i != scnt -1)
            predStr = [predStr stringByAppendingString:@" AND "];
        else
            predStr = [predStr stringByAppendingString:@" )"];
    
    }
    return predStr;
}

-(id) getLocalItem
{
    return [[LocalItem alloc] init];
}

-(MainViewController *) getMainViewController
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [pDlg.navViewController.viewControllers objectAtIndex:0];
}

@end
