//
//  AppDelegate.h
//  AutoSpree
//
//  Created by Ninan Thomas on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "common/MySlider.h"
#import "common/AddViewController.h"
#import "common/DataOps.h"
#import "LocalItem.h"
#import <CoreLocation/CLLocationManager.h>
#import "common/KeychainItemWrapper.h"
#import "common/CommonShareMgr.h"
#import "common/MainViewController.h"
#import "sharing/AppShrUtil.h"
#import "common/AppUtil.h"
#import "DataOpsDelegate.h"


#define PHOTOREQSOURCE_SHARE 2
#define AWS_AUTOSPREE_APPID 1

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MKMapViewDelegate, UIAlertViewDelegate, CLLocationManagerDelegate, MainViewControllerDelegate, MainListViewControllerDelegate, AppUtilDelegate, CommonShareMgrDelegate, ShareMgrDelegate>
{
    NSMetadataQuery *query;
    MKMapView    *mapView;
    CLLocationManager *locmgr;
    AddViewController *aVw;
    NSUbiquitousKeyValueStore *kvstore;
    bool bKvInit;
    bool bFirstActive;
    bool bUpgradeAlert;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) CommonShareMgr *pShrMgr;

@property (nonatomic, retain) IBOutlet UINavigationController *navViewController;

@property (nonatomic, retain) LocalItem* selectedItem;
@property (nonatomic, retain) LocalItem* editItem;
@property (nonatomic, retain) NSString *pSearchStr;
@property (nonatomic, retain) NSString *pAlName;
@property (nonatomic, retain) NSURL *cloudURL;
@property (nonatomic, retain) NSURL *cloudDocsURL;
@property (strong, nonatomic) NSOperationQueue *saveQ;
@property (nonatomic, retain) CLLocation *loc;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *passWord;
@property (nonatomic, strong) NSString *friendList;
@property (nonatomic, retain) DataOps *dataSync;
@property (nonatomic, retain) KeychainItemWrapper *kchain;
@property (nonatomic, retain) InAppPurchase *inapp;
@property (nonatomic, retain) AppUtil *apputil;
@property  (nonatomic, retain) DataOpsDelegate *dataOpsDelegate;


@property bool unlocked;
@property int editIndx;
@property int selectIndx;
@property int sortIndx;
@property bool bDateAsc;
@property bool bPriceAsc;
@property bool bYearAsc;
@property bool bMakeAsc;
@property bool bModelAsc;
@property bool bMilesAsc;
@property bool bColorAsc;
@property bool bRatingsAsc;
@property bool biCloudAvail;
@property bool bPtoPShare;
@property int toggle;
@property bool bInitRefresh;
@property dispatch_queue_t fetchQueue;
@property long long COUNT;
@property long long totcount;
@property int toDownLoad;
@property CGFloat photo_scale;
@property double sysver;
@property bool bNoICloudAlrt;
@property bool bRegistered;
@property bool bPassword;
@property bool bShare;
@property BOOL bTokPut;
@property double oneMonth;
@property bool bSharingDisabled;
@property bool bShareAction;
@property bool bChkdFrndLst;
@property bool bInBackGround;
@property bool bFromShareAction;
@property bool beingLoggedIn;

@property (nonatomic, retain) NSFileManager *pFlMgr;
@property (nonatomic, retain) AppShrUtil *appUtl;

-(void) decodeAndStoreItem :(NSString *) ItemStr;
- (void)itemAdd;
- (void)itemAddDone;
- (void) itemAddCancel;
-(void) itemEdit;
-(void) itemEditDone;
-(void) itemEditCancel;
-(void) setPurchsed;
-(void) popView;
- (void) launchWithSearchStr;
-(void) reloadFetchedResults:(NSNotification*)note;
-(void) reloadMainScreen:(NSNotification*)note;
-(void) stopLocUpdate;
-(void) addToCount;
-(void) addToTotCount;
-(void) addToTotCountNoR;
-(void) shareContactsAdd;
-(void) storeInKeyChain;
-(void) storeFriends;
-(NSString *) getPassword;
-(NSString *) getEmailFbMsg:(id)itm;
-(NSString *) getShareMsg:(id)itm;
-(NSString *) getItemName:(id)itm;
-(NSURL *) getPicUrl:(long long ) shareId picName:(NSString *) name itemName:(NSString *) iName;
-(void) storeThumbNailImage:(NSURL *)picUrl;
-(NSString* ) mainVwCntrlTitle;
-(long long ) getItemShareId:(id) itm;
-(long long) getShareId;

@end
