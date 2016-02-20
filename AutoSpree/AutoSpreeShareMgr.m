//
//  OpenHousesShareMgr.m
//  Shopper
//
//  Created by Ninan Thomas on 2/17/16.
//
//

#import "AutoSpreeShareMgr.h"
#import "AutoSpreeTranslator.h"
#import "AutoSpreeDecoder.h"

@implementation AutoSpreeShareMgr


-(void) getItems
{
    char *pMsgToSend = NULL;
    int len =0;
    pMsgToSend = [self.pTransl getItems:self.share_id msgLen:&len];
    [self putMsgInQ:pMsgToSend msgLen:len];
    return;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.pTransl = [[AutoSpreeTranslator alloc] init];
        self.pDecoder = [[AutoSpreeDecoder alloc] init];
    }
    return self;
}


@end
