//
//  AppDelegate.h
//  Ghost
//
//  Created by Enric Enrich on 09/09/15.
//
//

#import <Cocoa/Cocoa.h>

#import "WindowController.h"
#import "AddBlogWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,NSUserNotificationCenterDelegate>

@property (retain, nonatomic) WindowController *windowController;
@property (retain, nonatomic) AddBlogWindowController *addBlogWindowController;

@end
