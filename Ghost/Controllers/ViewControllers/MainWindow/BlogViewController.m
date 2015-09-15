//
//  BlogViewController.m
//  Ghost
//
//  Created by Enric Enrich on 14/09/15.
//
//

#import "BlogViewController.h"

@interface BlogViewController ()

@property (nonatomic, strong) NSView *contentView;

@end

@implementation BlogViewController

#pragma mark - Initializers

- (instancetype)initWithUrl:(NSURL *)url
{
    self = [super init];
    
    if (self) {
        self.url = url;
        self.contentView = [NSView new];
    }
    
    return self;
}

#pragma mark - Override

- (void)loadView
{
    self.view = self.contentView;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    [self.webView.mainFrame loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    NSDictionary *views = @{@"webView": self.webView};
    
    [self setUpConstraintsForViews:views];
}

#pragma mark - WebUIDelegate

- (void)webView:(WebView *)sender runOpenPanelForFileButtonWithResultListener:(id<WebOpenPanelResultListener>)resultListener
{
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    
    [openDlg setCanChooseFiles:YES];
    
    [openDlg setCanChooseDirectories:NO];
    
    if ([openDlg runModal] == NSOKButton) {
        NSArray *files = [[openDlg URLs]valueForKey:@"relativePath"];
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
