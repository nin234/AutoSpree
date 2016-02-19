//
//  LocalItem.m
//  Shopper
//
//  Created by Ninan Thomas on 11/17/12.
//
//

#import "LocalItem.h"
#import "Item.h"
#import "Constants.h"


@implementation LocalItem
@synthesize name;
@synthesize album_name;
@synthesize notes;
@synthesize price;
@synthesize pic_cnt;
@synthesize street;
@synthesize city;
@synthesize state;
@synthesize zip;
@synthesize country;
@synthesize longitude;
@synthesize latitude;
@synthesize make;
@synthesize model;
@synthesize miles;
@synthesize color;
@synthesize year;
@synthesize icloudsync;
@synthesize val1;
@synthesize val2;
@synthesize str1;
@synthesize str2;
@synthesize str3;

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        icloudsync = NO;
        val1 = 0.0;
        val2 = 0.0;
    }
    return self;
}

-(id) initWithItem:(CarItem *)item
{
    self = [super init];
    if (self != nil)
    {
        [self copyFromItem:item];
    }
    return self;
}

-(id) copyFromItem:(CarItem *)item
{
    self.name = item.name;
	self.album_name = item.album_name;
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

    return self;
}

-(NSString *) getItemKeyLastEl
{
	NSArray *lalbum_arr = [album_name componentsSeparatedByString:@"/"];
	NSUInteger lalindx = [lalbum_arr count];
	if (lalindx >=2)
    {
        lalindx -= 2;
    }
	else if (lalindx == 1)
    {
        lalindx -= 1;
    }
	else
	{
	    return nil;
	}
	
    NSString* lalbum_lastpath = [lalbum_arr objectAtIndex:lalindx];
    return lalbum_lastpath;
}


@end
