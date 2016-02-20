//
//  OpenHousesTranslator.m
//  Shopper
//
//  Created by Rekha Thomas on 2/6/16.
//
//

#import "AutoSpreeTranslator.h"
#include "Constants.h"

@implementation AutoSpreeTranslator

-(char *) getItems:(long long)shareId msgLen:(int *)len
{
    return [self getItems:shareId msgLen:len msgId:GET_AUTOSPREE_ITEMS];
}


@end
