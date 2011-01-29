//
//  database_iphoneAppDelegate.h
//  database-iphone
//
//  Created by Matthew Seeley on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface database_iphoneAppDelegate : NSObject <UIApplicationDelegate> {
    
   IBOutlet UIWindow *window;
   IBOutlet UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

