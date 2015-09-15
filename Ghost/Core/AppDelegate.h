//
//  AppDelegate.h
//  Ghost
//
//  Created by Enric Enrich on 09/09/15.
//
//

#import <Cocoa/Cocoa.h>

#import "MainWindowController.h"
#import "AddBlogWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,NSUserNotificationCenterDelegate>

@property (retain, nonatomic) MainWindowController *mainWindowController;
@property (retain, nonatomic) AddBlogWindowController *addBlogWindowController;

@end
