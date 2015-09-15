//
//  AppDelegate.m
//  Ghost
//
//  Created by Enric Enrich on 09/09/15.
//
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{    
    if ([Utils blogs].count > 0) {
        [self.mainWindowController showWindow:self];
    } else {
        [self.addBlogWindowController showWindow:self];
    }
    
    // Notifications
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddBlog:) name:DidAddBlogNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRemoveBlog:) name:DidRemoveBlogNotification object:nil];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication*)application hasVisibleWindows:(BOOL)visibleWindows
{
    if (!visibleWindows) {
        [self.mainWindowController.window makeKeyAndOrderFront:nil];
    }
    
    return YES;
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

#pragma mark - Actions

- (void)didAddBlog:(NSNotification *)notification
{
    [self.mainWindowController showWindow:self];
    [self.addBlogWindowController close];
}

- (void)didRemoveBlog:(NSNotification *)notification
{
    NSLog(@"DidRemoveBlog");
}

#pragma mark - Getters

- (MainWindowController *)mainWindowController
{
    if (!_mainWindowController) {
        _mainWindowController = [MainWindowController new];
    }
    
    return _mainWindowController;
}

- (AddBlogWindowController *)addBlogWindowController
{
    if (!_addBlogWindowController) {
        _addBlogWindowController = [AddBlogWindowController new];
    }
    
    return _addBlogWindowController;
}

@end
