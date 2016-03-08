//
//  AddEditDispDelegate.m
//  Shopper
//
//  Created by Ninan Thomas on 3/5/16.
//
//

#import "AddEditDispDelegate.h"
#import "AppDelegate.h"
#import "common/textdefs.h"

@implementation AddEditDispDelegate

@synthesize pNewItem;

-(void) initializeNewItem
{
    pNewItem = [[LocalItem alloc] init];
    pNewItem.year = 3000;
    pNewItem.price = [NSNumber numberWithDouble:-2.0];
    pNewItem.miles = 0;
    return;
}

-(void) setAlbumNames:(NSString *)noStr fullName:(NSString *)urlStr
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pNewItem.album_name = noStr;
    pDlg.pAlName = urlStr;
    return;
}

-(void) deleteEditItem
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [pDlg.dataSync deletedItem:pDlg.editItem];
}

-(void) setEditAlbumNames:(NSString *)noStr fullName:(NSString *)urlStr
{
     AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.editItem.album_name = noStr;
    pDlg.pAlName = urlStr;

}

-(void) setLocation:(double) lat longitude:(double) longtde
{
    pNewItem.latitude = lat;
    pNewItem.longitude = longtde;
    NSLog(@"Setting new item longitude=%f and latitude=%f\n", longtde, lat);
    return;
}

-(void) stopLocUpdate
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [pDlg stopLocUpdate];
    return;
}

-(bool) updateAddress:(NSString *)street city:(NSString *)city state:(NSString *) state country:(NSString * )country zip:(NSString *)zip
{
    if ([pNewItem.street isEqualToString:street] && [pNewItem.city isEqualToString:city] && [pNewItem.state isEqualToString:state] &&[pNewItem.country isEqualToString:country] && [pNewItem.zip isEqualToString:zip])
    {
        NSLog (@"Addres did not change in updatePlaceMark not updating\n");
        return  false;
    }
    else
    {
        pNewItem.street = street;
        pNewItem.country =country;
        pNewItem.state = state;
        pNewItem.city = city;
        pNewItem.zip = zip;
    }
    return true;
}

-(void) incrementPicCnt
{
    ++pNewItem.pic_cnt;
    return;
}

-(void) saveQAdd:(NSInvocationOperation*) theOp
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [pDlg.saveQ addOperation:theOp];
}

- (void) populateValues:(UITextField *)textField
{
    switch (textField.tag)
    {
        case CAR_NAME:
            pNewItem.name = textField.text;
            break;
            
        case CAR_MODEL:
            pNewItem.model = textField.text;
            break;
            
        case CAR_COLOR:
            pNewItem.color = textField.text;
            break;
            
        case CAR_MAKE:
            pNewItem.make = textField.text;
            break;
            
        case CAR_YEAR:
        {
            NSString *pr = [textField.text stringByTrimmingCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]];
            pNewItem.year = atoi([pr UTF8String]);
        }
            break;
            
        case CAR_PRICE:
        {
            NSString *pr = [textField.text stringByTrimmingCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]];
            pNewItem.price = [NSNumber  numberWithDouble:strtod([pr UTF8String], NULL)];
        }
            break;
            
        case CAR_MILES:
        {
            NSString *pr = [textField.text stringByTrimmingCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]];
            pNewItem.miles = atoi([pr UTF8String]);
        }
            break;
            
        case CAR_STREET:
            pNewItem.street = textField.text;
            break;
            
        case CAR_CITY:
            pNewItem.city = textField.text;
            break;
            
        case CAR_STATE:
            pNewItem.state = textField.text;
            break;
            
        case CAR_COUNTRY:
            pNewItem.country = textField.text;
            break;
            
        case CAR_ZIP:
            pNewItem.zip = textField.text;
            break;
            
        default:
            break;
    }
    
    return;
}

-(NSString *) deleteButtonTitle
{
    return @"Delete House";
}

-(void) populateTextFields:(UITextField *) textField textField1:(UITextField *) textField1 row:(NSUInteger)row
{
    switch (row)
    {
            
        case 1:
        {
            textField.text = pNewItem.model;
            textField.tag = CAR_MODEL;
            textField1.text = pNewItem.color;
            textField1.tag = CAR_COLOR;
        }
            break;
        case 2:
        {
            textField.text = pNewItem.make;
            textField.tag  = CAR_MAKE;
            
            if (pNewItem.year != 3000)
            {
                char year1[64];
                sprintf(year1, "%d", pNewItem.year);
                textField1.text = [NSString stringWithUTF8String:year1];
                
            }
            textField1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textField1.tag = CAR_YEAR;
            
        }
            break;
            
        case 3:
        {
            if ([pNewItem.price doubleValue] >= 0.0 )
            {
                char price1[64];
                sprintf(price1, "%.2f", [pNewItem.price floatValue]);
                textField.text = [NSString stringWithUTF8String:price1];
            }
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textField.tag = CAR_PRICE;
            char miles1[64];
            sprintf(miles1, "%d", pNewItem.miles);
            textField1.text = [NSString stringWithUTF8String:miles1];
            textField1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textField1.tag = CAR_MILES;
            
        }
            break;
            
        case 0:
        {
            AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            if (pNewItem.name == nil)
            {
                NSString *pHseName = @"Car";
                NSString *intStr = [[NSNumber numberWithLongLong:pDlg.COUNT+1] stringValue];
                pHseName = [pHseName stringByAppendingString:intStr];
                textField.text = pHseName;
                pNewItem.name = pHseName;
            }
            else
            {
                textField.text = pNewItem.name;
            }
            textField.tag = CAR_NAME;
        }
            break;
            
        case 8:
            textField.text = pNewItem.street;
            textField.tag = CAR_STREET;
            break;
            
        case 9:
        {
            textField.text = pNewItem.city;
            NSLog(@"Setting city to %@\n", pNewItem.city);
            textField.tag = CAR_CITY;
        }
            break;
            
        case 10:
            textField.text = pNewItem.state;
            textField.tag = CAR_STATE;
            break;
        case 11:
            textField.text = pNewItem.country;
            textField.tag = CAR_COUNTRY;
            break;
        case 12:
            textField.text = pNewItem.zip;
            textField.tag = CAR_ZIP;
            break;
            
        default:
            break;
    }


    return;
}

-(void) populateEditTextFields:(UITextField *) textField textField1:(UITextField *) textField1 row:(NSUInteger)row
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    switch (row)
    {
        case 1:
        {
            textField.text = pDlg.editItem.model;
            textField.tag = CAR_MODEL;
            textField1.text = pDlg.editItem.color;
            textField1.tag = CAR_COLOR;
        }
            break;
        case 2:
        {
            textField.text = pDlg.editItem.make;
            textField.tag = CAR_MAKE;
            if (pDlg.editItem.year != 3000)
            {
                char year1[64];
                sprintf(year1, "%d", pDlg.editItem.year);
                textField1.text = [NSString stringWithUTF8String:year1];
            }
            textField1.tag = CAR_YEAR;
            textField1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            
        }
            break;
            
        case 3:
        {
            if ([pDlg.editItem.price  doubleValue] >= 0.0 )
            {
                char price1[64];
                sprintf(price1, "%.2f", [pDlg.editItem.price floatValue]);
                textField.text = [NSString stringWithUTF8String:price1];
            }
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textField.tag = CAR_PRICE;
            char miles1[64];
            sprintf(miles1, "%d", pDlg.editItem.miles);
            textField1.text = [NSString stringWithUTF8String:miles1];
            textField1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textField1.tag = CAR_MILES;
        }
            break;
        case 0:
            textField.text = pDlg.editItem.name;
            textField.tag = CAR_NAME;
            break;
            
        case 8:
            textField.text = pDlg.editItem.street;
            textField.tag = CAR_STREET;
            break;
            
        case 9:
        {
            textField.text = pDlg.editItem.city;
            textField.tag = CAR_CITY;
            
        }
            break;
            
        case 10:
            textField.text = pDlg.editItem.state;
            textField.tag = CAR_STATE;
            break;
        case 11:
            textField.text = pDlg.editItem.country;
            textField.tag = CAR_COUNTRY;
            break;
        case 12:
            textField.text = pDlg.editItem.zip;
            textField.tag = CAR_ZIP;
            break;
            

        default:
            break;
    }
    

    
    return;
}
-(NSArray *) getFieldNames
{
    return [NSArray arrayWithObjects:@"Name", @"Model", @"Make", @"Price", @"Camera", @"Notes", @"Pictures", @"Map", @"Street", @"City", @"State", @"Country", @"Postal Code", nil];
}

-(NSArray *) getSecondFieldNames
{
    return  [NSArray arrayWithObjects:@"Blank", @"Color", @"Year", @"Miles", nil];
}

-(bool) isTwoFieldRow:(NSUInteger) row
{
    if (row == 1 || row ==2 || row == 3)
        return true;
    return false;
}

-(CGRect) getTextFrame
{
    return CGRectMake(68, 12, 110, 25);
}

-(UILabel *) getLabel
{
    return [[UILabel alloc] initWithFrame:CGRectMake(178, 10, 57, 25)];
}

-(bool) isSingleFieldEditRow:(NSUInteger) row
{
    if(row < 2 || (row > 7 && row < 13))
        return true;
    return false;
}

-(bool) isSingleFieldRow:(NSUInteger) row
{
  if (row < 1 || row > 7)
      return true;
    return false;
}

-(void) incrementEditPicCnt
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ++pDlg.editItem.pic_cnt;
    return;
}

-(void) itemAddCancel
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [pDlg itemAddCancel];
}

-(void) itemAddDone
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [pDlg itemAddDone];
}

-(void) itemEditCancel
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [pDlg itemEditCancel];
    return;
}

-(void) itemEditDone
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [pDlg itemEditDone];
    return;
}

-(NSString *) setTitle
{
    NSString *title = @"Car Info";
    return  title;
}

-(NSString *) getEditItemTitle
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *title ;
    if (pDlg.editItem.year != 3000)
    {
        char year1[64];
        sprintf(year1, "%d", pDlg.editItem.year);
        title = [NSString stringWithUTF8String:year1];
    }
    else
    {
        title = @" ";
    }
    if (pDlg.editItem.model != nil)
    {
        title = [title stringByAppendingString:@" "];
        title = [title stringByAppendingString:pDlg.editItem.model];
    }
    return title;
    
}

-(NSString *) getAlbumTitle;
{
    NSString *title ;
    if (pNewItem.year != 3000)
    {
        char year1[64];
        sprintf(year1, "%d", pNewItem.year);
        title = [NSString stringWithUTF8String:year1];
    }
    else
    {
        title = @" ";
    }
    if (pNewItem.model != nil)
    {
        title = [title stringByAppendingString:@" "];
        title = [title stringByAppendingString:pNewItem.model];
    }
    return  title;
}

-(NSString *) getNotes
{
    return pNewItem.notes;
}

-(NSString *) getEditNotes
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return pDlg.editItem.notes;
}

-(bool) changeCharacters:(NSInteger) tag
{
    switch (tag)
    {
        case CAR_YEAR:
        case CAR_PRICE:
        case CAR_MILES:
            return false;
        break;
            
        default:
            return true;
        break;
    }

    return true;
}

-(bool) rangeFourTag:(NSInteger) tag
{
    if (tag == CAR_YEAR)
        return true;
    return false;
}

-(bool) numbersTag:(NSInteger) tag;
{
    if (tag == CAR_YEAR || tag == CAR_MILES)
        return true;
    return false;
}

-(double) getLongitude
{
    return pNewItem.longitude;
}

-(double) getEditLongitude
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return pDlg.editItem.longitude;
}

-(double) getEditLatitude
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return pDlg.editItem.latitude;
}

-(double) getLatitude
{
    return pNewItem.latitude;
}

- (void) populateEditValues:(UITextField *)textField
{
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    switch (textField.tag)
    {
        case CAR_NAME:
            pDlg.editItem.name = textField.text;
            break;
            
        case CAR_MODEL:
            pDlg.editItem.model = textField.text;
            break;
            
        case CAR_COLOR:
            pDlg.editItem.color = textField.text;
            break;
            
        case CAR_MAKE:
            pDlg.editItem.make = textField.text;
            break;
            
        case CAR_YEAR:
        {
            NSString *pr = [textField.text stringByTrimmingCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]];
            pDlg.editItem.year = atoi([pr UTF8String]);
        }
            break;
            
        case CAR_PRICE:
        {
            NSString *pr = [textField.text stringByTrimmingCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]];
            pDlg.editItem.price = [NSNumber  numberWithDouble:strtod([pr UTF8String], NULL)];
        }
            break;
            
        case CAR_MILES:
        {
            NSString *pr = [textField.text stringByTrimmingCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]];
            pDlg.editItem.miles = atoi([pr UTF8String]);
        }
            break;
            
        case CAR_STREET:
            pDlg.editItem.street = textField.text;
            break;
            
        case CAR_CITY:
            pDlg.editItem.city = textField.text;
            break;
            
        case CAR_STATE:
            pDlg.editItem.state = textField.text;
            break;
            
        case CAR_COUNTRY:
            pDlg.editItem.country = textField.text;
            break;
            
        case CAR_ZIP:
            pDlg.editItem.zip = textField.text;
            break;
            
        default:
            break;
    }
    
    return;
}


@end