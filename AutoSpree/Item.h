//
//  Item.h
//  Shopper
//
//  Created by Ninan Thomas on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LocalItem;

@interface CarItem : NSManagedObject

@property (nonatomic, retain) NSString * album_name;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString *country;
@property BOOL icloudsync;
@property double latitude;
@property double longitude;
@property (nonatomic, retain) NSString * make;
@property int miles;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property int pic_cnt;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *str1;
@property (nonatomic, retain) NSString *str2; //Stores the ratings value
@property (nonatomic, retain) NSString *str3;
@property (nonatomic, retain) NSString *street;
@property double val1;
@property double val2;
@property int year;
@property (nonatomic, retain) NSString *zip;

-(void) copyFromLocalItem:(LocalItem *)item copyAlbumName:(bool) bCopy;
-(void) updateItem:(LocalItem*)item;

@end
