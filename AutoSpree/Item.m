//
//  Item.m
//  Shopper
//
//  Created by Ninan Thomas on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Item.h"
#import "LocalItem.h"
#include <sys/time.h>


@implementation CarItem
@dynamic album_name;
@dynamic color;
@dynamic year;
@dynamic name;
@dynamic icloudsync;
@dynamic notes;
@dynamic price;
@dynamic pic_cnt;
@dynamic street;
@dynamic city;
@dynamic state;
@dynamic zip;
@dynamic country;
@dynamic longitude;
@dynamic latitude;
@dynamic make;
@dynamic model;
@dynamic miles;
@dynamic val1;
@dynamic val2;
@dynamic str1;
@dynamic str2;
@dynamic str3;


-(void) copyFromLocalItem:(LocalItem *)item copyAlbumName:(bool)bCopy
{
    self.name = item.name;
    if (bCopy)
    {
        self.album_name = item.album_name;
    }
	self.notes = item.notes;
	self.price = item.price;
	self.pic_cnt = item.pic_cnt;
	self.street = item.street;
	self.city = item.city;
	self.state = item.state;
	self.zip = item.zip;
	self.country = item.country;
	self.longitude = item.longitude;
	self.latitude = item.latitude;
	self.make = item.make;
	self.model = item.model;
	self.color = item.color;
	self.miles = item.miles;
	self.year = item.year;
	self.icloudsync = item.icloudsync;
	self.val1 = item.val1;
	self.val2 = item.val2;
	self.str1 = item.str1;
	self.str2 = item.str2;
	self.str3 = item.str3;
    return;
}

-(void) updateItem:(LocalItem*)item
{
    self.str1 = item.str1;
    self.val1 = item.val1;
}

@end
