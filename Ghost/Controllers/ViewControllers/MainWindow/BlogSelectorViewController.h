//
//  BlogSelectorViewController.h
//  Ghost
//
//  Created by Enric Enrich on 14/09/15.
//
//

#import <Cocoa/Cocoa.h>

@class BlogViewModel;

@interface BlogSelectorViewController : NSViewController

- (BlogViewModel *)selectedBlog;

@end
