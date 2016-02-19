//
//  LocalItem.h
//  Shopper
//
//  Created by Ninan Thomas on 11/17/12.
//
//

#import <Foundation/Foundation.h>



@class CarItem;

@interface LocalItem : NSObject
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * album_name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString * make;
@property int miles;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *country;
@property int pic_cnt;
@property int year;
@property BOOL icloudsync;
@property double longitude;
@property double latitude;
@property double val1;
@property double val2;
@property (nonatomic, retain) NSString *str1;
@property (nonatomic, retain) NSString *str2;
@property (nonatomic, retain) NSString *str3;

-(id) init;
-(id) initWithItem:(CarItem *)item;

-(id) copyFromItem:(CarItem *)item;



-(NSString *) getItemKeyLastEl;

@end
