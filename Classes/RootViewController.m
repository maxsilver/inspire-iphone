//
//  RootViewController.m
//  database-iphone
//
//  Created by Matthew Seeley on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle


-(void)initializeTableData
{
	arrayOfCharacters = [[NSMutableArray alloc]init];
	objectsForCharacters = [[NSMutableDictionary alloc]init];
	sqlite3 *db = [database_iphoneAppDelegate getNewDBConnection];
	for(char c='A';c<='Z';c++)
	{
		NSMutableString *query;
		query = [NSMutableString stringWithFormat:@"select name from user where name LIKE '%c",c]; 
		[query appendString:@"%'"];
		char *sql = [query cString];
		sqlite3_stmt *statement = nil;
		
		if(sqlite3_prepare_v2(db,sql, -1, &statement, NULL)!= SQLITE_OK)
			NSAssert1(0,@"error preparing statement",sqlite3_errmsg(db));
		else
		{
			NSMutableArray *arrayOfNames = [[NSMutableArray alloc]init];
			while(sqlite3_step(statement)==SQLITE_ROW)
				[arrayOfNames addObject:[NSString stringWithFormat:(NSString *)@"%s",(char*)sqlite3_column_text(statement, 0)]];
			if([arrayOfNames count] >0)
			{
				[arrayOfCharacters addObject:[NSString stringWithFormat:@"%c",c]];
				[objectsForCharacters setObject:arrayOfNames forKey:[NSString stringWithFormat:@"%c",c]];
			}
			[arrayOfNames release];
		}
		sqlite3_finalize(statement);
	}

}



- (void)viewDidLoad {
	NSLog(@"View Loading");
    [super viewDidLoad];


	[self initializeTableData];
	self.title = @"DatabaseTest";
	
	NSLog(@"View did load!!");
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [arrayOfCharacters count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"Returned a row count");
	return [[objectsForCharacters objectForKey:[arrayOfCharacters objectAtIndex:section]] count];
}


// ----------------


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
	for(char c = 'A';c<='Z';c++)
		[toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
	return toBeReturned;
	
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	NSInteger count = 0;
	for(NSString *character in arrayOfCharacters)
	{
		if([character isEqualToString:title])
			return count;
		count ++;
	}
	return 0;// in case of some eror donot crash d application
	
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if([arrayOfCharacters count]==0)
		return @"";
	return [arrayOfCharacters objectAtIndex:section];
}
		


// -----------------------


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSLog(@"Making a cell");
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell
	cell.textLabel.text = [[objectsForCharacters objectForKey:[arrayOfCharacters objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	NSLog(@"Sending back a cell");	
	
	return cell;

	/*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.

    return cell;
	*/
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

