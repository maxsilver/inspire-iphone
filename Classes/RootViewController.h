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

@interface RootViewController : UITableViewController {
//	NSMutableArray *tableData;
	NSMutableArray *arrayOfCharacters;
	NSMutableDictionary *objectsForCharacters;
}

@end
