//
//  SortOptionViewController.m
//  Shopper
//
//  Created by Ninan Thomas on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SortOptionViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@implementation SortOptionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
       // CGRect tableRect = CGRectMake(0, 50, 320, 360);
            }
    return self;
}

-(void) loadView
{
    [super loadView];
    CGRect tableRect = CGRectMake(0, 50, 60, 230);
    UITableView *pTVw = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    //[self.view insertSubview:self.pAllItms.tableView atIndex:1];
    self.tableView = pTVw;
    return;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *pBarItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Car List" style:UIBarButtonItemStylePlain target:self action:nil ];
    self.navigationItem.backBarButtonItem = pBarItem1;
    NSString *title = @"Sort By";
    //printf("%s", [title UTF8String]);
   
    self.navigationItem.title = [NSString stringWithString:title];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
     AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.dataSync.refreshNow = true;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) priceToggle
{
    NSLog(@"Received price toggle \n");
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.bPriceAsc = !pDlg.bPriceAsc;
    [self.tableView reloadData];
    return;
}

- (void) dateToggle
{
    NSLog(@"Received date toggle \n");
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.bDateAsc = !pDlg.bDateAsc;
    [self.tableView reloadData];
    return;
    
}

- (void) makeToggle
{
    NSLog(@"Received make toggle \n");
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.bMakeAsc = !pDlg.bMakeAsc;
    [self.tableView reloadData];
    
    return;
    
}

- (void) yearToggle
{
    NSLog(@"Received year toggle \n");
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.bYearAsc = !pDlg.bYearAsc;
    [self.tableView reloadData];
    return;
}

- (void) modelToggle
{
    NSLog(@"Received model toggle \n");
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.bModelAsc = !pDlg.bModelAsc;
    [self.tableView reloadData];
    return;
    
}

- (void) colorToggle
{
    NSLog(@"Received color toggle \n");
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.bColorAsc = !pDlg.bColorAsc;
    [self.tableView reloadData];
    return;
    
}


- (void) milesToggle
{
    NSLog(@"Received miles toggle \n");
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pDlg.bMilesAsc = !pDlg.bMilesAsc;
    [self.tableView reloadData];
    return;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SortCell";
    static NSArray* fieldNames = nil;
    if (!fieldNames)
    {
        fieldNames = [NSArray arrayWithObjects:@"Viewed", @"Price", @"Make", @"Year", @"Model", @"Miles", @"Color", nil];
    }
    NSLog(@"Sortoption cellforRowAtIndexPath %d", indexPath.row);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;  
        NSArray *pVws = [cell.contentView subviews];
        int cnt = [pVws count];
        for (NSUInteger i=0; i < cnt; ++i)
        {
            [[pVws objectAtIndex:i] removeFromSuperview];
        }

    }
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 75, 25)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont boldSystemFontOfSize:14];
    [cell.contentView addSubview:label];
     NSString* fieldName = [fieldNames objectAtIndex:indexPath.row];
    label.text = fieldName;
    UIButton *button= [[UIButton alloc] initWithFrame:CGRectMake(90, 10, 75, 25)];
    //UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSString *date = pDlg.bDateAsc?@"first":@"last";
    NSString *price = pDlg.bPriceAsc?@"low":@"high";
    NSString *make = pDlg.bMakeAsc?@"A":@"Z";
    NSString *year = pDlg.bYearAsc?@"old":@"new";
    NSString *model = pDlg.bModelAsc?@"A":@"Z";
    NSString *miles = pDlg.bMilesAsc?@"low":@"high";
    NSString *color = pDlg.bColorAsc?@"A":@"Z";
    
    switch (indexPath.row)
    {
        case 0:
            NSLog(@"Setting date button title %@ \n" , date);
            [button setTitle:date forState:UIControlStateNormal];
            button.backgroundColor = pDlg.bDateAsc?[UIColor brownColor]:[UIColor blueColor];
            [button addTarget:self action:@selector(dateToggle) forControlEvents:UIControlEventTouchDown];
        break;
        
        case 1:
            NSLog(@"Setting price button title %@ \n" , price);
            [button setTitle:price forState:UIControlStateNormal];
            button.backgroundColor = [UIColor brownColor];
            button.backgroundColor = pDlg.bPriceAsc?[UIColor brownColor]:[UIColor blueColor];
            [button addTarget:self action:@selector(priceToggle) forControlEvents:UIControlEventTouchDown];
        break;
        
        case 2:
            NSLog(@"Setting make button title %@ \n" , make);
            [button setTitle:make forState:UIControlStateNormal];
            button.backgroundColor = [UIColor brownColor];
            button.backgroundColor = pDlg.bMakeAsc?[UIColor brownColor]:[UIColor blueColor];
            [button addTarget:self action:@selector(makeToggle) forControlEvents:UIControlEventTouchDown];
        break;
            
        case 3:
            NSLog(@"Setting year button title %@ \n" , year);
            [button setTitle:year forState:UIControlStateNormal];
            button.backgroundColor = [UIColor brownColor];
            button.backgroundColor = pDlg.bYearAsc?[UIColor brownColor]:[UIColor blueColor];
            [button addTarget:self action:@selector(yearToggle) forControlEvents:UIControlEventTouchDown];
            break;
            
        case 4:
            NSLog(@"Setting model button title %@ \n" , model);
            [button setTitle:model forState:UIControlStateNormal];
            button.backgroundColor = [UIColor brownColor];
            button.backgroundColor = pDlg.bModelAsc?[UIColor brownColor]:[UIColor blueColor];
            [button addTarget:self action:@selector(modelToggle) forControlEvents:UIControlEventTouchDown];
            break;
            
        case 5:
            NSLog(@"Setting miles button title %@ \n" , miles);
            [button setTitle:miles forState:UIControlStateNormal];
            button.backgroundColor = [UIColor brownColor];
            button.backgroundColor = pDlg.bMilesAsc?[UIColor brownColor]:[UIColor blueColor];
            [button addTarget:self action:@selector(milesToggle) forControlEvents:UIControlEventTouchDown];
            break;
      
        case 6:
            NSLog(@"Setting color button title %@ \n" , color);
            [button setTitle:color forState:UIControlStateNormal];
            button.backgroundColor = [UIColor brownColor];
            button.backgroundColor = pDlg.bColorAsc?[UIColor brownColor]:[UIColor blueColor];
            [button addTarget:self action:@selector(colorToggle) forControlEvents:UIControlEventTouchDown];
            break;
        default:
        
            break;
            
    }
  //  [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //[butview addSubview:button];
    [cell.contentView addSubview:button];
    UILabel  *label1 = [[UILabel alloc] initWithFrame:CGRectMake(179, 10, 75, 25)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont boldSystemFontOfSize:14];
    [cell.contentView addSubview:label1];
    switch (indexPath.row)
    {
        case 0:
            label1.text = pDlg.bDateAsc?@" to last":@" to first";
            break;
            
        case 1:
           label1.text = pDlg.bPriceAsc?@" to high":@" to low";
            break;
        case 2:
            label1.text = pDlg.bMakeAsc?@" to   Z":@" to   A";
            break;
        case 3:
            label1.text = pDlg.bYearAsc?@" to new":@" to old";
            break;
        case 4:
            label1.text = pDlg.bModelAsc?@" to   Z":@" to   A";
            break;
        case 5:
            label1.text = pDlg.bMilesAsc?@" to high":@" to low";
            break;
            
        case 6:
            label1.text = pDlg.bColorAsc?@" to   Z":@" to   A";
            break;

            
        default:
            
            break;
            
    }

    
    if (pDlg.sortIndx == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell; 
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AppDelegate *pDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (pDlg.sortIndx == indexPath.row)
        return;
     NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:pDlg.sortIndx inSection:0];
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone)
    {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        pDlg.sortIndx =  indexPath.row;
    }
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) 
    {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    pDlg.dataSync.refreshNow = true;
    return;
    
}

@end
