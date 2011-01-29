//
//  database_iphoneAppDelegate.m
//  database-iphone
//
//  Created by Matthew Seeley on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "database_iphoneAppDelegate.h"
#import "RootViewController.h"


@implementation database_iphoneAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    NSLog(@"Starting App");
    // Override point for customization after application launch.
	[self createEditableCopyOfDatabaseIfNeeded];
	
    
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];

	NSLog(@"App Started!");
    return YES;
}



- (void)createEditableCopyOfDatabaseIfNeeded {
	
	NSLog(@"Creating editable copy of database");
	// First, test for existence.
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"data_new.sqlite"];
	success = [fileManager fileExistsAtPath:writableDBPath];
	if (success) return;
	// The writable database does not exist, so copy the default to the appropriate location.
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data_new.sqlite"];
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	if (!success) {
		NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

+(sqlite3 *)getNewDBConnection{
	sqlite3 *newDBconnection;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data_new.sqlite"];
	
	if (sqlite3_open([path UTF8String], &newDBconnection) == SQLITE_OK){
		NSLog(@"Database successfully opened!");
	}else{
		NSLog(@"Error opening database!");
	}
	return newDBconnection;
}

/*
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[self createEditableCopyOfDatabaseIfNeeded];
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}
*/

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

