//
//  AddBlogWindowController.m
//  Ghost
//
//  Created by Enric Enrich on 12/09/15.
//
//

#import "AddBlogWindowController.h"

@implementation AddBlogWindowController

- (instancetype)init
{
    self = [super initWithWindowNibName:@"AddBlogWindow"];
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.titlebarAppearsTransparent = YES;
    self.window.styleMask |= NSFullSizeContentViewWindowMask;
    
    [self.window setFrameAutosaveName:@"AddWindow"];
}

@end
