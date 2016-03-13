//
//  AppDelegate.m
//  AutoSpree
//
//  Created by Ninan Thomas on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "common/MainViewController.h"
#import "common/AddViewController.h"
#import "common/EditViewController.h"
#import "common/DisplayViewController.h"
#import "Item.h"
#import <MapKit/MapKit.h>
#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <sharing/FriendDetails.h>
#import <sharing/AddFriendViewController.h>
#import "SortOptionViewController.h"
#import "AddEditDispDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize navViewController = _navViewController;
@synthesize selectedItem;
@synthesize editItem;
@synthesize editIndx;
@synthesize selectIndx;
@synthesize sortIndx;
@synthesize pSearchStr;
@synthesize pAlName;
@synthesize pFlMgr;
@synthesize saveQ;
@synthesize bDateAsc;
@synthesize bPriceAsc;
@synthesize bMakeAsc;
@synthesize bModelAsc;
@synthesize bYearAsc;
@synthesize bMilesAsc;
@synthesize bColorAsc;
@synthesize biCloudAvail;
@synthesize cloudURL;
@synthesize cloudDocsURL;
@synthesize toggle;
@synthesize loc;
@synthesize attchmnts;
@synthesize bEmailConfirm;
@synthesize bPtoPShare;
@synthesize userName;
@synthesize passWord;
@synthesize dataSync;
@synthesize bInitRefresh;
@synthesize fetchQueue;
@synthesize COUNT;
@synthesize totcount;
@synthesize toDownLoad;
@synthesize photo_scale;
@synthesize sysver;
@synthesize bNoICloudAlrt;
@synthesize bFBAction;
@synthesize unlocked;
@synthesize bRegistered;
@synthesize bPassword;
@synthesize kchain;
@synthesize friendList;
@synthesize bShare;
@synthesize bTokPut;
@synthesize oneMonth;
@synthesize  bSharingDisabled;
@synthesize bShareAction;
@synthesize bChkdFrndLst;
@synthesize bInBackGround;
@synthesize bFromShareAction;
@synthesize beingLoggedIn;
@synthesize inapp;
@synthesize purchased;
@synthesize tabBarController;
@synthesize pShrMgr;
@synthesize apputil;


-(void) setAlbumName:(id) item albumcntrl:(AlbumContentsViewController *) cntrl
{
    LocalItem *itm = item;
    if (selectedItem.icloudsync == YES)
        pAlName = itm.album_name;
    else
        pAlName  = [apputil getAlbumDir:itm.album_name];
    [cntrl setPFlMgr:pFlMgr];
    [cntrl setPAlName:pAlName];
    [cntrl setName:itm.name];
    if (itm.street != nil)
        [cntrl setStreet:itm.street];
    return;
}

-(void) photoActions:(int) source
{
    switch (source)
    {
        case PHOTOREQSOURCE_EMAIL:
            [self emailRightNow];
            break;
            
        case PHOTOREQSOURCE_SHARE:
            [self shareSelFrnds];
            break;
            
        case PHOTOREQSOURCE_FB:
            [self fbshareRightNow];
            break;
            
        default:
            break;
    }
    

    return;
}

-(void) initRefresh
{
    if (bInitRefresh)
    {
        bInitRefresh = false;
        NSLog(@"AppDelegate.bInitRefresh set to false");
    }
    else
    {
        dataSync.refreshNow = true;
        NSLog(@"Setting AppDelegate.dataSync.refreshNow to true");
    }
    return;
}

-(void) searchStrSet:(NSString *)text
{
    pSearchStr = text;
    dataSync.refreshNow = true;
    return;
}

-(void) searchStrReset
{
    pSearchStr = nil;
    dataSync.refreshNow = true;
    return;
}

-(NSString *) getLabelTxt:(id) itm
{
    LocalItem *item = itm;
    NSString *labtxt = item.name;
    labtxt = [labtxt stringByAppendingString:@" - "];
    if (item.year != 3000 && item.model != nil)
        labtxt = [labtxt stringByAppendingFormat:@" %d ", item.year];
    if (item.model != nil && item.color != nil)
    {
        labtxt = [labtxt stringByAppendingString:item.color];
        labtxt = [labtxt stringByAppendingString:@" "];
    }
    if (item.model != nil)
        labtxt = [labtxt stringByAppendingString:item.model];
    return labtxt;
}

-(void) pushSortOptionViewController
{
    SortOptionViewController *aViewController = [[SortOptionViewController alloc]
                                                 initWithNibName:nil bundle:nil];
    [self.navViewController pushViewController:aViewController animated:YES];

    return;
}

-(void) pushDisplayViewController:(id) itm indx:(int)Indx
{
    LocalItem *item = itm;
    selectedItem = item;
    editItem = item;
    selectIndx = Indx;
    editIndx = Indx;
    if (selectedItem.icloudsync == YES)
        pAlName = selectedItem.album_name;
    else
        pAlName = [apputil getAlbumDir:selectedItem.album_name];
    NSLog(@"Setting pDlg.pAlName=%@", pAlName);
    
    DisplayViewController *aViewController = [[DisplayViewController alloc]
                                              initWithNibName:nil bundle:nil];
    [aViewController setPFlMgr:pFlMgr];
    [aViewController setPAlName:pAlName];
    [aViewController setNavViewController:self.navViewController];
    [aViewController setDelegate:[[AddEditDispDelegate alloc]init]];
    
    [self.navViewController pushViewController:aViewController animated:YES];
    return;
}

-(void) populateOneMonth
{
    oneMonth = 30*24*60*60*1000000;
    return;
}

-(void) switchRootView
{
    [self.window setRootViewController:self.navViewController];
    tabBarController.selectedIndex = 0;
}


-(void) popView
{
    //putchar('N');
    [self.navViewController popViewControllerAnimated:YES];
    
    
}

-(void) itemEdit
{
    //putchar('I');
    
    
    EditViewController *aViewController = [[EditViewController alloc]
                                           initWithNibName:nil bundle:nil];
    [aViewController setDelegate:[[AddEditDispDelegate alloc] init]];
    [aViewController setPAlName:pAlName];
    [aViewController setPFlMgr:pFlMgr];
    [aViewController setNavViewController:self.navViewController];
     
    [self.navViewController pushViewController:aViewController animated:YES];
}

-(void) itemEditCancel
{
    NSLog(@"Clicked Edit cancel button\n");
    [self.navViewController popViewControllerAnimated:NO];
       return;
}

-(void) itemEditDone
{
    NSLog(@"Clicked Edit done button\n");
    LocalItem *modItem = self.editItem;
    
    [self.navViewController popViewControllerAnimated:NO];
       self.selectedItem = modItem;
    struct timeval tv;
    gettimeofday(&tv, 0);
    long long sec = ((long long)tv.tv_sec)*1000000;
    long long usec =tv.tv_usec;
	self.editItem.val1 =  sec + usec ;

    [dataSync editedItem:self.editItem];
    DisplayViewController *pDisp = (DisplayViewController *)[self.navViewController topViewController];
    [pDisp.tableView reloadData];
    
}

-(void) stopLocUpdate
{
  mapView.showsUserLocation = NO;
  [locmgr stopUpdatingLocation];
}

-(void) itemAddCancel
{
    bEmailConfirm =false;
    UIAlertView *pAvw = [[UIAlertView alloc] initWithTitle:@"Discard Changes" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [pAvw show];   
}

-(void) itemAddCancelConfirm
{
    mapView.showsUserLocation = NO;
    [locmgr stopUpdatingLocation];
    aVw = nil;
  if ([pFlMgr removeItemAtPath:pAlName error:nil] == YES)
  {
      printf("Removed album %s \n", [pAlName UTF8String]);
  }
  else
  {
      printf("Failed to remove album %s \n", [pAlName UTF8String]);
  }
    self.pAlName = @"";
    [self.navViewController popViewControllerAnimated:YES];
}


- (void) itemAddDone
{
    mapView.showsUserLocation = NO;
    [locmgr stopUpdatingLocation];
    aVw = nil;
          
    AddViewController *pAddViewCntrl = (AddViewController *)[self.navViewController popViewControllerAnimated:NO];
    struct timeval tv;
    gettimeofday(&tv, 0);
    long long sec = ((long long)tv.tv_sec)*1000000;
    long long usec =tv.tv_usec;
    AddEditDispDelegate *pAddView = (AddEditDispDelegate *)pAddViewCntrl.delegate;
    
	pAddView.pNewItem.val1 = sec + usec;

    [dataSync addItem:pAddView.pNewItem];
    NSLog(@"New Item added %@\n", pAddView.pNewItem);
      selectedItem = pAddView.pNewItem;
    editItem = pAddView.pNewItem;
    
}

- (void)itemAdd
{    
  //  UIBarButtonItem *pBarItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(itemAddCancel) ];
    NSLog(@"Adding item purchase = %d COUNT = %lld", purchased, COUNT);
    
    if (!purchased)
    {
        if (COUNT >= 2)
        {
            NSLog(@"Cannot add a new item without upgrade COUNT=%lld", COUNT);
                bUpgradeAlert = true;
            UIAlertView *pAvw = [[UIAlertView alloc] initWithTitle:@"Upgrade now" message:@"Only two cars allowed with free version. Please upgrade now to add unlimited number of cars" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [pAvw show];
            return;

        }
    }
    NSLog(@"Authorization status %d", [CLLocationManager authorizationStatus]);
    UIDevice *dev = [UIDevice currentDevice];
    if (!([[dev systemVersion] doubleValue] < 8.0))
    {
    switch ([CLLocationManager authorizationStatus])
    {
        case kCLAuthorizationStatusNotDetermined:
            [locmgr requestWhenInUseAuthorization];
        break;
            
        default:
            break;
    }
    }
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    [locmgr startUpdatingLocation];
    pSearchStr = nil;
    pMainVwCntrl.pSearchBar.text = nil;
    [pMainVwCntrl.pSearchBar resignFirstResponder];
    [pMainVwCntrl setDelegate:self];
    [pMainVwCntrl setDelegate_1:self];
    AddViewController *aViewController = [[AddViewController alloc]
                                          initWithNibName:nil bundle:nil];
    [aViewController setPFlMgr:pFlMgr];
    [aViewController setNavViewController:self.navViewController];
    [aViewController setDelegate:[[AddEditDispDelegate alloc]init]];
    aVw = aViewController;
    mapView.showsUserLocation = YES;
    [self.navViewController pushViewController:aViewController animated:YES];
  
}

- (void) launchWithSearchStr
{
      
    CGRect tableRect = CGRectMake(0, 50, 320, 1000);
    UITableView *pTVw = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
    //[self.view insertSubview:self.pAllItms.tableView atIndex:1];
        MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    pMainVwCntrl.pAllItms.tableView = pTVw;
 
    
}

-(void) iCloudEmailCancel
{
    
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    pMainVwCntrl.pAllItms.bInEmail = false;
    pMainVwCntrl.pAllItms.bInICloudSync = false;
    [pMainVwCntrl.pAllItms unlockItems];
    [pMainVwCntrl.pAllItms attchmentsClear];
    self.dataSync.dontRefresh = false;
    UIBarButtonItem *pBarItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(iCloudOrEmail)];
    pMainVwCntrl.pAllItms.tableView.tableFooterView = nil;
    
    self.navViewController.navigationBar.topItem.leftBarButtonItem = pBarItem1;

    self.dataSync.updateNow = true;
    [pMainVwCntrl.pAllItms resetSelectedItems];
    self.navViewController.toolbarHidden = YES;
    return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Clicked button at index %ld", (long)buttonIndex);
    if (bSystemAbrt)
    {
        bSystemAbrt = false;
        return;
    }
    if (bUpgradeAlert)
    {
        NSLog(@"Resetting bUpgradeAlert in alertview action");
        bUpgradeAlert = false;
        return;
    }
    
    if (bPersistError)
    {
        bPersistError = false;
      //  abort();
        return;
    }
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    attchmnts = (int)buttonIndex;
    
    if(bNoICloudAlrt)
    {
         [self iCloudEmailCancel];
        bNoICloudAlrt = false;
        return;
    }
    
    switch (attchmnts)
    {
        case 0:
            NSLog(@"Attaching no photos\n");
            if (bFBAction)
            {
                bFBAction = false;
                [self fbshareRightNow];
                return;
            }
            if (bShare)
            {
                bShare = false;
                [self shareSelFrnds];
            }
            if (bEmailConfirm)
            {
                bEmailConfirm = false;
                [self emailRightNow];
            }
            if (bShareAction)
            {
                bShareAction = false;
                bFromShareAction = true;
                [self.dataSync setLoginNow:true];
               
            }

            
            break;
            
        case 1:
        {
            NSLog(@"Attaching all the photos\n");
            if (bFBAction)
            {
                bFBAction = false;
                [pMainVwCntrl.pAllItms getPhotos:0 source:PHOTOREQSOURCE_FB];
                return;
            }
            
            if (bShare)
            {
                bShare = false;
                [pMainVwCntrl.pAllItms getPhotos:0 source:PHOTOREQSOURCE_SHARE];
                return;
            }
            
                        
            if(bEmailConfirm)
            {
                bEmailConfirm =false;
                [pMainVwCntrl.pAllItms getPhotos:0 source:PHOTOREQSOURCE_EMAIL];
            }
            else
            {
                [self itemAddCancelConfirm];
            }
        }
            break;
            
        default:
            break;
    }
    
    NSLog(@"Email selected items\n");
      return;
}

-(NSString *) getEmailFbMsg:(LocalItem *)item
{
    NSString *message = @"";
    NSString *msg =[message stringByAppendingFormat:@"Name:%@\nModel: %@\nMake: %@  Year: %d\nPrice: %.2f  Miles: %d\n Notes: %@\nStreet: %@\nCity: %@\nState: %@\nCountry: %@\n Postal Code: %@\n\n\n",item.name, item.model,
                    item.make,
                    item.year == 3000? 0: item.year, [item.price floatValue] < 0.0? 0.0:[item.price floatValue] < 0.0? 0.0: [item.price floatValue], item.miles, item.notes, item.street,
                    item.city, item.state, item.country, item.zip];
    return msg;
}

-(void) emailRightNow
{
    
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];  
     MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
     controller.mailComposeDelegate = self;
     [controller setSubject:@"Car details"];
    
    LocalItem *item =[pMainVwCntrl.pAllItms getMessage:PHOTOREQSOURCE_EMAIL];
    
    [controller setMessageBody:[self getEmailFbMsg:item] isHTML:NO];
     
    NSUInteger cnt = [pMainVwCntrl.pAllItms.attchments count];
    NSLog (@"Attaching %lu images\n",(unsigned long)cnt);
    for (NSUInteger i=0; i < cnt; ++i) 
    {
        if ([[pMainVwCntrl.pAllItms.movOrImg objectAtIndex:i] boolValue])
        {
            [controller addAttachmentData:[NSData dataWithContentsOfURL:[pMainVwCntrl.pAllItms.attchments objectAtIndex:i]] mimeType:@"image/jpeg" fileName:@"photo"];
        }
        else 
        {
            [controller addAttachmentData:[NSData dataWithContentsOfURL:[pMainVwCntrl.pAllItms.attchments objectAtIndex:i]] mimeType:  @"video/quicktime" fileName:@"video"];    
        }
    }
    if (controller) 
        [pMainVwCntrl presentViewController:controller animated:YES completion:nil];
    [self iCloudEmailCancel];
    return;
}


-(void) fbshareNow
{
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    if(![pMainVwCntrl.pAllItms itemsSelected])
    {
        [self iCloudEmailCancel];
        return;
    }
    bFBAction = true;
    UIAlertView *pAvw = [[UIAlertView alloc] initWithTitle:@"Post Pictures" message:@"Only images can be posted. Movies cannot be posted" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [pAvw show];

    return;
}

-(void) shareRightNow
{

}

-(void) shareSelFrnds
{
        return;
}

-(void) friendsAddDelDone
{
    
      return;
}



-(void) fbshareRightNow
{
     MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0]; 
    SLComposeViewController *fbVwCntrl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    if (fbVwCntrl != nil)
    {
        LocalItem *item =[pMainVwCntrl.pAllItms getMessage:PHOTOREQSOURCE_FB];
        [fbVwCntrl setInitialText:[self getEmailFbMsg:item]];
        NSUInteger cnt = [pMainVwCntrl.pAllItms.attchments count];
        NSLog (@"Attaching %lu images\n",(unsigned long)cnt);
        for (NSUInteger i=0; i < cnt; ++i)
        {
            [fbVwCntrl addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[pMainVwCntrl.pAllItms.attchments objectAtIndex:i]]]];
        }
        [fbVwCntrl setCompletionHandler:^(SLComposeViewControllerResult result)
         {
            if (result == SLComposeViewControllerResultCancelled)
                NSLog(@"User cancelled fb post\n");
             else
                 NSLog(@"Posted to fb\n");
             [self iCloudEmailCancel];
         }
         ];
        [pMainVwCntrl presentViewController:fbVwCntrl animated:YES completion:nil];
    }
    return;
}

-(void) emailNow
{
    if ([MFMailComposeViewController canSendMail])
    {
        MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
        if(![pMainVwCntrl.pAllItms itemsSelected])
        {
            [self iCloudEmailCancel];
            return;
        }
        bEmailConfirm = true;
        
        UIAlertView *pAvw = [[UIAlertView alloc] initWithTitle:@"Attach Pictures" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [pAvw show];
        
    }
   
    return;
}

-(void) syncNow
{
    NSLog(@"Syncing to iCloud selected items\n");
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    [pMainVwCntrl.pAllItms syncSelectedtoiCloud];
    [self iCloudEmailCancel];
    return;
}

-(void) shareNow
{
    NSLog(@"Sharing to openhouses\n");
    
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    if(![pMainVwCntrl.pAllItms itemsSelected])
    {
        [self iCloudEmailCancel];
        return;
    }
    bShare = true;
    UIAlertView *pAvw = [[UIAlertView alloc] initWithTitle:@"Share Pictures" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [pAvw show];

    return;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [pMainVwCntrl dismissViewControllerAnimated:YES completion:nil];
}

-(void) showShareView
{
    MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    UIBarButtonItem *pBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(iCloudEmailCancel) ];
    self.navViewController.navigationBar.topItem.leftBarButtonItem = pBarItem;
    self.navViewController.toolbarHidden = NO;
    
    UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                target:nil action:nil];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 45)];
	footer.backgroundColor = [UIColor clearColor];
	pMainVwCntrl.pAllItms.tableView.tableFooterView = footer;
    UIBarButtonItem *pBarItem1;
    pMainVwCntrl.pAllItms.bInEmail = true;
    self.dataSync.loginNow = true;
    pBarItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareNow)];
    
    [pMainVwCntrl setToolbarItems:[NSArray arrayWithObjects:
                                   flexibleSpaceButtonItem,
                                   pBarItem1,
                                   flexibleSpaceButtonItem,
                                   nil]
                         animated:YES];
    self.dataSync.updateNowSetDontRefresh = true;
    return;
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
     MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    printf("Clicked button at index %ld\n", (long)buttonIndex);
    UIBarButtonItem *pBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(iCloudEmailCancel) ];
    self.navViewController.navigationBar.topItem.leftBarButtonItem = pBarItem;
     self.navViewController.toolbarHidden = NO;
   
    UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                target:nil action:nil];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 45)];
	footer.backgroundColor = [UIColor clearColor];
	pMainVwCntrl.pAllItms.tableView.tableFooterView = footer;
    UIBarButtonItem *pBarItem1;
    if (bUpgradeAction)
    {
        bUpgradeAction = false;
        switch (buttonIndex)
        {
            case 0:
                NSLog(@"Purchasing autospree_full");
                if (!purchased)
                    [inapp start:true];
                else
                    NSLog(@"Already upgraded, ignoring");
                [self iCloudEmailCancel];
            break;
                
            case 1:
                NSLog(@"Restoring autospree_full");
                
                if (!purchased)
                    [inapp start:false];
                else
                    NSLog(@"Already upgraded, ignoring");
                [self iCloudEmailCancel];
                
            break;
                
            default:
                [self iCloudEmailCancel];
              
            break;
        }
        return;
    }
 
    if (buttonIndex == 0)
    {
        NSLog(@"In email \n");
        pMainVwCntrl.pAllItms.bInEmail = true;
        pMainVwCntrl.emailAction = true;
        pBarItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Email" style:UIBarButtonItemStylePlain target:self action:@selector(emailNow)];
        
    }
    else if (buttonIndex == 1)
    {
        UIDevice *dev = [UIDevice currentDevice];
        if ([[dev systemVersion] doubleValue] < 6.0)
        {
            [self iCloudEmailCancel];
            return;
        }
        NSLog(@"In facebook share\n");
        pMainVwCntrl.pAllItms.bInEmail = true;
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            pBarItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Facebook" style:UIBarButtonItemStylePlain target:self action:@selector(fbshareNow)];
            

        }
        else
        {
            UIAlertView *pAvw = [[UIAlertView alloc] initWithTitle:@"No Facebook Account" message:@"Please set up facebook account in settings. House details including pictures can be shared with selected group of friends on Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            bNoICloudAlrt = true;
            [pAvw show];
        }
    }
    else if (buttonIndex == 2)
    {
        
        [self iCloudEmailCancel];
        bUpgradeAction = true;
        UIActionSheet *pSh;
        
        pSh= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Purchase", @"Restore Purchases", nil];
        
        MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
        [pMainVwCntrl.pAllItms lockItems];
        [pSh setDelegate:self];
        [pSh showInView:pMainVwCntrl.pAllItms.tableView];
        

        
    }
    else
    {
        [self iCloudEmailCancel];
        return;
    }

    [pMainVwCntrl setToolbarItems:[NSArray arrayWithObjects:
                                   flexibleSpaceButtonItem,
                                   pBarItem1,
                                   flexibleSpaceButtonItem,
                                   nil]
                         animated:YES];   
    self.dataSync.updateNowSetDontRefresh = true;
    //[pMainVwCntrl.pAllItms.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        return;
    

}


-(void) iCloudOrEmail
{
    NSLog(@"Showing iCloud email action sheet \n");
    
    //Move files to iCloud, pull files from iCloud
    //how to reconcile
    //Album directory name by time of
   
    UIActionSheet *pSh;
    
    pSh= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email", @"Facebook share", @"Upgrade", nil];
   
   MainViewController *pMainVwCntrl = [self.navViewController.viewControllers objectAtIndex:0];
    [pMainVwCntrl.pAllItms lockItems];
    [pSh setDelegate:self];
    [pSh showInView:pMainVwCntrl.pAllItms.tableView];
    
    


    return;
}

- (void)initializeiCloudAccess 
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *containerID = @"3JEQ693MKL.com.rekhaninan.AutoSpree";
        if ([[NSFileManager defaultManager]
             URLForUbiquityContainerIdentifier:containerID] != nil)
        {
            NSLog(@"iCloud is available\n");
            biCloudAvail = true;
        }
        else
            NSLog(@"iCloud,  is not available.\n");
    });
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Got did update user location in AppDelegate latitude=%f longitude=%f\n", locmgr.location.coordinate.latitude, locmgr.location.coordinate.longitude);
    
    if (fabs([locmgr.location.timestamp timeIntervalSinceNow]) > 10.0)
    {
        NSLog(@"Stale location ignoring\n");
        return;
    }
    
    if (fabs(locmgr.location.coordinate.latitude) <= 0.0000001 && fabs(locmgr.location.coordinate.longitude) <= 0.000001  )
    {
        NSLog(@"0 degree longitude and 0 degree latitude, ignoring location\n");
        return;
    }
    
    if (aVw != nil)
        [aVw setLocation:locmgr.location];
    return;
}

- (void)mapView:(MKMapView *)mapViewL didUpdateUserLocation:(MKUserLocation *)userLocation
{
    UIDevice *dev = [UIDevice currentDevice];
    NSLog(@"system version %f", [[dev systemVersion] doubleValue]);
        loc = [userLocation location];
        NSLog(@"Got did update user location in AppDelegate latitude=%f longitude=%f\n", loc.coordinate.latitude, loc.coordinate.longitude);
        if (aVw != nil)
            [aVw setLocation:loc];
}

-(void) setPurchsd
{
    NSLog(@"Setting purchased to true");
    purchased = true;
    NSUserDefaults* kvlocal = [NSUserDefaults standardUserDefaults];
    [kvlocal setBool:YES forKey:@"Purchased"];
    if (kvstore)
        [kvstore setBool:YES forKey:@"Purchased"];
    if (!bShrMgrStarted)
    {
        pShrMgr = [[AutoSpreeShareMgr alloc] init];
        [pShrMgr start];
        bShrMgrStarted = true;
    }

}


-(void) storeDidChange:(NSUbiquitousKeyValueStore *)kstore
{
    if (!bKvInit)
    {
        bKvInit = true;
        [kvstore synchronize];
        NSLog(@"Initialized kvstore\n");
        return;
    }
    COUNT = [kvstore longLongForKey:@"TotRows"];
    totcount = [kvstore longLongForKey:@"TotTrans"];
    NSLog(@"Got storeDidChange counts COUNT=%lld totcount=%lld\n", COUNT, totcount);
    if (!purchased)
    {
        BOOL purch = [kvstore boolForKey:@"Purchased"];
        if (purch == YES)
        {
            purchased = true;
            NSUserDefaults* kvlocal = [NSUserDefaults standardUserDefaults];
            [kvlocal setBool:YES forKey:@"Purchased"];
        }
        
    }

    
    //    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    if (userName == nil)
    {
        userName = [kvstore stringForKey:@"UserName"];
        if (userName != nil && [userName length] > 0)
            bRegistered = true;
        NSLog(@"Got username %@ from ubiquitous kvstore\n", userName);
     #ifdef CLEANUP   
       [kvstore removeObjectForKey:@"UserName"];
       [kvstore removeObjectForKey:@"Friends"];
        [kvstore setLongLong:0 forKey:@"TotRows"];
        [kvstore setLongLong:0 forKey:@"TotTrans"];
    #endif
    }

    return;
}

-(void) addToCount
{
    ++COUNT;
    ++totcount;
    if (kvstore)
    {
        [kvstore setLongLong:COUNT forKey:@"TotRows"];
        [kvstore setLongLong:totcount forKey:@"TotTrans"];
    }
    
        NSUserDefaults* kvlocal = [NSUserDefaults standardUserDefaults];
        [kvlocal setInteger:(NSInteger)COUNT forKey:@"TotRows"];
        [kvlocal setInteger:(NSInteger) totcount forKey:@"TotTrans"];
    
    return;
}

-(void) addToTotCount
{
    ++totcount;
    if (kvstore)
    {
        [kvstore setLongLong:totcount forKey:@"TotTrans"];
    }
    else
    {
        NSUserDefaults* kvlocal = [NSUserDefaults standardUserDefaults];
        [kvlocal setInteger:(NSInteger)totcount forKey:@"TotTrans"];
    }
    return;
}

-(void) addToTotCountNoR
{
    ++totcount;
    if (kvstore)
    {
        [kvstore setLongLong:totcount forKey:@"TotTrans"];
    }
    else
    {
        NSUserDefaults* kvlocal = [NSUserDefaults standardUserDefaults];
        [kvlocal setInteger:(NSInteger)totcount forKey:@"TotTrans"];
    }
    return;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"APPLICATION did receive memory warning\n");
    
}

-(NSString *) getPassword
{
    passWord = [kchain objectForKey:(__bridge id)kSecValueData];
    if (passWord != nil && [passWord length]>0)
    {
        bPassword = true;
        NSLog(@"Getting password %@\n", passWord);
        return passWord;
    }
    NSLog(@"Failed to get password\n");
    return  nil;
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    return;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{

  @try
  {
    NSUserDefaults* kvlocal = [NSUserDefaults standardUserDefaults];
    NSData *tokenNow = [kvlocal dataForKey:@"NotToken"];
    NSLog(@"Did register for remote notification with token %@ tokenNow=%@", deviceToken, tokenNow);
    bool bChange = false;
    if (tokenNow == nil)
    {
        [kvlocal setObject:deviceToken forKey:@"NotToken"];
        bChange = true;
    }
    else
    {
            if (![deviceToken isEqualToData:tokenNow])
            {
                [kvlocal setObject:deviceToken forKey:@"NotToken"];
                bChange = true;
            }
    }
    
    NSLog(@"bRegistered=%s, bChange=%s bTokPut=%s", bRegistered?"true":"false", bChange?"true":"false", bTokPut?"YES":"NO");
    }
   @catch (NSException *exception)
   {
        NSLog(@" Caught %@: %@", [exception name], [exception reason]);
   }
   @finally
   {
       NSLog(@"Doing nothing");
   }
    return;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to register for remote notification %@\n", error);
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"Application did become active");
    if (bFirstActive)
    {
        NSLog(@"First time activation skipping download items on start up as it is called from application didFinishLaunchingWithOptions");
        bFirstActive = false;
        return;
    }
        if (!bRegistered)
    {
        NSString *unameInKChain = [kchain objectForKey:(__bridge id)kSecAttrAccount];
        if (unameInKChain != nil && [unameInKChain length] > 0)
        {
            NSLog(@"Login now as we got a registered signal");
            NSLog(@"Registered Never logged in before so popping up alert to allow push notifications for sharing and then login");
            bShareAction = true;
            userName = unameInKChain;

            UIAlertView *pAvw = [[UIAlertView alloc] initWithTitle:@"Enable Sharing" message:@"Notifications must be allowed for sharing. Please click OK when prompted for \"Autospree App would like to send notifications\" or enable notifications in the notification center." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [pAvw show];

        }
        else
        {
            //This case is to address the scenario  where Autospree app is started and put in background and openhouses did the registration. and now we have to reinitialize kchain object to sync it
             kchain = [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:@"3JEQ693MKL.com.rekhaninan.sinacama"];
            unameInKChain = [kchain objectForKey:(__bridge id)kSecAttrAccount];
            if (unameInKChain != nil && [unameInKChain length] > 0)
            {
                NSLog(@"Login now as we got a registered signal");
                NSLog(@"Registered Never logged in before so popping up alert to allow push notifications for sharing and then login");
                bShareAction = true;
                userName = unameInKChain;
                UIAlertView *pAvw = [[UIAlertView alloc] initWithTitle:@"Enable Sharing" message:@"Notifications must be allowed for sharing. Please click OK when prompted for \"Autospree App would like to send notifications\" or enable notifications in the notification center." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [pAvw show];
                
            }

            //Now try once again
        }

    }
    return;
}

-(void) cleanUpEverything
{
    NSUserDefaults* kvlocal = [NSUserDefaults standardUserDefaults];
    kvstore = [NSUbiquitousKeyValueStore defaultStore];
    if(kvstore)
    {
        [kvstore removeObjectForKey:@"UserName"];
        [kvstore removeObjectForKey:@"Friends"];
        [kvstore setLongLong:0 forKey:@"TotRows"];
        [kvstore setLongLong:0 forKey:@"TotTrans"];
    }
    [kchain resetKeychainItem];
    
    [kvlocal setInteger:0 forKey:@"SelfHelp"];
    [kvlocal setInteger:0 forKey:@"TotRows"];
    [kvlocal setInteger:0 forKey:@"TotTrans"];
    [kvlocal removeObjectForKey:@"NotToken"];
    fetchQueue = dispatch_queue_create("com.rekhaninan.fetchQueue", NULL);
    if (kvstore)
    {
        [[NSNotificationCenter defaultCenter]
         addObserver: self
         selector: @selector (storeDidChange:)
         name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
         object: kvstore];
        dispatch_async(fetchQueue, ^{
            [self storeDidChange:kvstore];
        });
    }
    

    return;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    bShrMgrStarted = false;
    bFirstActive = true;
    pFlMgr = [[NSFileManager alloc] init];
    NSString *pHdir = NSHomeDirectory();
    sortIndx = 0;
    bUpgradeAlert = false;
    unlocked = false;
    bDateAsc = true;
    bPriceAsc = true;
    bMakeAsc = true;
    bYearAsc = true;
    bModelAsc = true;
    bMilesAsc = true;
    bColorAsc = true;
    biCloudAvail = false;
    bEmailConfirm  = false;
    toggle = 0;
    bPtoPShare = false;
    bInitRefresh = true;
    photo_scale = 1.0;
    bNoICloudAlrt = false;
    bFBAction = false;
    bRegistered = false;
    bSharingDisabled = true;
    bShareAction = false;
    bChkdFrndLst = false;
    bPersistError = false;
    bInBackGround = false;
    bFromShareAction = false;
    beingLoggedIn = false;
    purchased = false;
    bUpgradeAction = false;
    bSystemAbrt = false;
    NSLog(@"Launching Autospree");
    inapp = [[InAppPurchase alloc] init];
    [inapp setDelegate:self];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:inapp];
    NSUserDefaults* kvlocal = [NSUserDefaults standardUserDefaults];
    [self populateOneMonth];
    kvstore = [NSUbiquitousKeyValueStore defaultStore];
    apputil = [[AppUtil alloc] init];
    //NSLog(@"sizeof double=%ld sizeof long long = %ld",sizeof(double), sizeof(long long));
   // return YES;
    
 
    NSError *error;
    kchain = [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:@"3JEQ693MKL.com.rekhaninan.sinacama"];
    
#ifdef CLEANUP
         [self cleanUpEverything];
          return YES ;
#endif
    
   
    dataSync = [[DataOps alloc] init];
    [dataSync start];
    
    NSString *pAlbumsDir = [pHdir stringByAppendingPathComponent:@"/Documents/albums"];
    saveQ = [[NSOperationQueue alloc] init];
    NSLog (@"initialized saveQ %s %d \n", __FILE__, __LINE__);
    if ([pFlMgr createDirectoryAtPath:pAlbumsDir withIntermediateDirectories:NO attributes:nil error:&error] == YES)
    {
       
        printf("Created album directory %s \n", [pAlbumsDir UTF8String]);
    }
    else
        printf("Fail to create album directory %s reason %s\n", [pAlbumsDir UTF8String], [[error localizedDescription] UTF8String]);
   // [self initializeiCloudAccess];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainViewController *aViewController = [[MainViewController alloc]
                                           initWithNibName:nil bundle:nil];
    aViewController.pAllItms.bInICloudSync = false;
    aViewController.pAllItms.bInEmail = false;
    aViewController.pAllItms.bAttchmentsInit = false;
    aViewController.delegate = self;
    aViewController.delegate_1  = self;
    
    fetchQueue = dispatch_queue_create("com.rekhaninan.fetchQueue", NULL);
        userName = [kchain objectForKey:(__bridge id)kSecAttrAccount];
    if(userName != nil && [userName length] > 0)
    {
        NSLog(@"userName=%@\n", userName);
        bRegistered = true;
        
    }
    else
    {
        if (kvstore)
            userName = [kvstore stringForKey:@"UserName"];
        if(userName != nil && [userName length] > 0)
        {
            NSLog(@"userName=%@\n", userName);
            bRegistered = true;
        }
        else
        {
            NSLog(@"Not registered for sharing");
        }
            

    }

    
    bKvInit = false;
    
    if (kvstore)
    {
        [[NSNotificationCenter defaultCenter]
         addObserver: self
         selector: @selector (storeDidChange:)
         name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
         object: kvstore];
        dispatch_async(fetchQueue, ^{
            [self storeDidChange:kvstore];
        });
    }
    COUNT = [kvlocal integerForKey:@"TotRows"];
    totcount = [kvlocal integerForKey:@"TotTrans"];
        
    bTokPut = [kvlocal boolForKey:@"TokInAws"];
    
    BOOL purch = [kvlocal boolForKey:@"Purchased"];
    if (purch == YES)
        purchased = true;
    
        // Override point for customization after application launch.
    UINavigationController *navCntrl = [[UINavigationController alloc] initWithRootViewController:aViewController];
    self.navViewController = navCntrl;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:self.navViewController.view];
    [self.window makeKeyAndVisible];
     CGRect mapFrame = CGRectMake(90, 12, 200, 25);
    mapView = [[MKMapView alloc] initWithFrame:mapFrame];
    mapView.showsUserLocation = NO;
    mapView.delegate = self;
    locmgr = [[CLLocationManager alloc] init];
    locmgr.delegate = self;
    UIDevice *dev = [UIDevice currentDevice];
    sysver = [[dev systemVersion] doubleValue];
    
    
    if (sysver >= 6.0)
    {
        NSLog(@"Not pausing location updates automatically\n");
        locmgr.pausesLocationUpdatesAutomatically = NO;
    }
    [locmgr stopUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMainScreen:) name:@"RefetchAllDatabaseData" object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFetchedResults:) name:@"RefreshAllViews" object:self];
    
    if (biCloudAvail)
        NSLog (@"iCloud available\n");
    else
        NSLog (@"iCloud NOT available at this point\n");
    self.window.backgroundColor = [UIColor whiteColor];
    //[self.window addSubview:self.navViewController.view];
    [self.window setRootViewController:self.navViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void) storeInKeyChain
{
    [kchain setObject:userName forKey:(__bridge id)kSecAttrAccount];
    
    // Store password to keychain
    [kchain setObject:passWord forKey:(__bridge id)kSecValueData];
    
    if(kvstore)
    {
        [kvstore setString:userName forKey:@"UserName"];
    }
    passWord = @"";
    bRegistered = true;
    return;
    
}

-(void) storeFriends
{
    if (friendList != nil && [friendList length] > 0)
    {
        NSLog(@"Storing friend list %@ in key chain and kv store", friendList);
        [kchain setObject:friendList forKey:(__bridge id)kSecAttrComment];
        if(kvstore)
        {
            [kvstore setString:friendList forKey:@"Friends"];
        }
    }
    return;
}

-(void)reloadFetchedResults :(NSNotification*)note
{
   
    return;
}

-(void)reloadMainScreen :(NSNotification*)note
{
    dataSync.refreshNow = true;
    return;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    bInBackGround = true;
    self.navViewController.navigationBar.tintColor = nil;
    return;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    bInBackGround = false;
    return;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self.dataSync saveContext];
}

@end
