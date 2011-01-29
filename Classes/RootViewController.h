//
//  RootViewController.h
//  database-iphone
//
//  Created by Matthew Seeley on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "database_iphoneAppDelegate.h"

@interface RootViewController : UITableViewController <UISearchBarDelegate> {
//	NSMutableArray *tableData;
	
	// Source List
	NSMutableArray *arrayOfCharacters;
	NSMutableDictionary *objectsForCharacters;
	
	// Displayed
	NSMutableArray *displayedArrayOfCharacters;
	NSMutableDictionary *displayedObjectsForCharacters;
	
	// Search Results Lists
//	NSMutableArray *searchedArrayOfCharacters;
//	NSMutableDictionary *searchedObjectsForCharacters;
	
	UISearchBar *sBar; //search bar
}
@property(nonatomic,retain)NSMutableArray *dataSource;

@end
