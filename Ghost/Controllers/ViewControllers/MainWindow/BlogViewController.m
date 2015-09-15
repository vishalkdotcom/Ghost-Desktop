//
//  BlogViewController.m
//  Ghost
//
//  Created by Enric Enrich on 14/09/15.
//
//

#import "BlogViewController.h"

@interface BlogViewController ()

@end

@implementation BlogViewController

#pragma mark - Initializers

- (instancetype)initWithUrl:(NSURL *)url
{
    self = [super init];
    
    if (self) {
        self.view = [NSView new];
        [self.webView.mainFrame loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
    return self;
}

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    NSDictionary *views = @{@"webView": self.webView};
    
    [self setUpConstraintsForViews:views];
}

#pragma mark - WebUIDelegate

- (void)webView:(WebView *)sender runOpenPanelForFileButtonWithResultListener:(id<WebOpenPanelResultListener>)resultListener
{
    // Create the File Open Dialog class
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog
    [openDlg setCanChooseFiles:YES];
    
    // Enable the selection of directories in the dialog
    [openDlg setCanChooseDirectories:NO];
    
    if ([openDlg runModal] == NSOKButton) {
        NSArray* files = [[openDlg URLs]valueForKey:@"relativePath"];
        [resultListener chooseFilenames:files];
    }
}

#pragma mark - Getters

- (WebView *)webView
{
    if (!_webView) {
        _webView = [WebView new];
        _webView.UIDelegate = self;
        _webView.wantsLayer = YES;
        _webView.layer.backgroundColor = [NSColor whiteColor].CGColor;
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _webView;
}

#pragma mark - Constraints

- (void)setUpConstraintsForViews:(NSDictionary *)views
{
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webView]|" options:0 metrics:nil views:views]];
}

@end
