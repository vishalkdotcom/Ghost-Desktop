//
//  AppDelegate.m
//  Ghost
//
//  Created by Enric Enrich on 09/09/15.
//
//

#import "AppDelegate.h"
#import "WindowController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{    
    if ([Utils blogs].count > 0) {
        self.windowController = [[WindowController alloc] initWithURL:[Utils blogs][0][kBlogUrl]];
        [self.windowController setWindowParams];
        [self.windowController showWindow:self];
    } else {
        self.addBlogWindowController = [[AddBlogWindowController alloc] init];
        [self.addBlogWindowController showWindow:self];
    }
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication*)application hasVisibleWindows:(BOOL)visibleWindows
{
    if (!visibleWindows) {
        [self.windowController.window makeKeyAndOrderFront:nil];
    }
    
    return YES;
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

@end
