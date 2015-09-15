//
//  MainWindowController.m
//  Ghost
//
//  Created by Enric Enrich on 14/09/15.
//
//

#import "MainWindowController.h"
#import "BlogViewController.h"

@implementation MainWindowController

#pragma mark - Initializers

- (instancetype)init
{
    self = [super initWithWindowNibName:@"MainWindow"];
    
    return self;
}

#pragma mark - Override

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.titlebarAppearsTransparent = YES;
    self.window.styleMask |= NSFullSizeContentViewWindowMask;
    
    [self.window setFrameAutosaveName:@"BlogsWinddow"];
}

@end
