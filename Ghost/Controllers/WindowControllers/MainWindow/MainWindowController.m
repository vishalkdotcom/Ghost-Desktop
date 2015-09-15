//
//  MainWindowController.m
//  Ghost
//
//  Created by Enric Enrich on 14/09/15.
//
//

#import "MainWindowController.h"
#import "BlogViewController.h"

#import "BlogViewModel.h"

@interface MainWindowController ()

@property (nonatomic, strong) NSMutableDictionary *blogsControllers;

@end

@implementation MainWindowController

#pragma mark - Initializers

- (instancetype)init
{
    self = [super initWithWindowNibName:@"MainWindow"];
    
    if (self) {
        self.blogsControllers = [NSMutableDictionary new];
        
        [self createNeededControllers];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blogSelectionDidChange:) name:BlogSelectionDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddBlog:) name:DidAddBlogNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRemoveBlog:) name:DidRemoveBlogNotification object:nil];
    }
    
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

#pragma mark - Actions

- (void)blogSelectionDidChange:(NSNotification *)notification
{
    BlogViewModel *blog = (BlogViewModel *)notification.object;
    BlogViewController *blogViewController = (BlogViewController *)self.blogsControllers[blog.urlString];
    
    if (self.blogView.subviews.count > 0) {
        [self.blogView replaceSubview:self.blogView.subviews[0] with:blogViewController.view];
    } else {
        [self.blogView addSubview:blogViewController.view];
    }
    
    [self.blogView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": blogViewController.view}]];
    [self.blogView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": blogViewController.view}]];
}

- (void)didAddBlog:(NSNotification *)notification
{
    BlogViewModel *blog = (BlogViewModel *)notification.object;
    
    BlogViewController *blogViewController = [[BlogViewController alloc] initWithUrl:blog.url];
    [self.blogsControllers setObject:blogViewController forKey:blog.urlString];
}

- (void)didRemoveBlog:(NSNotification *)notification
{
    NSLog(@"DidRemoveBlog");
}

#pragma mark -

- (void)createNeededControllers
{
    for (BlogViewModel *blog in [Utils blogs]) {
        BlogViewController *blogViewController = [[BlogViewController alloc] initWithUrl:blog.url];
        [self.blogsControllers setObject:blogViewController forKey:blog.urlString];
    }
}

@end
