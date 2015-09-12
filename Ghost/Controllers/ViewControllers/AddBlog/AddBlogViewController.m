//
//  AddBlogViewController.m
//  Ghost
//
//  Created by Enric Enrich on 12/09/15.
//
//

#import "AddBlogViewController.h"

@interface AddBlogViewController ()

@property (nonatomic, strong) NSImageView *logoImageView;
@property (nonatomic, strong) NSTextField *blogUrlTextField;
@property (nonatomic, strong) NSButton *addBlogButton;

@end

@implementation AddBlogViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.blogUrlTextField];
    [self.view addSubview:self.addBlogButton];
    
    NSDictionary *views = @{@"logoImageView": self.logoImageView,
                            @"blogUrlTextField": self.blogUrlTextField,
                            @"addBlogButton": self.addBlogButton};
    
    [self setUpConstraintsForViews:views];
}

#pragma mark - Getters

- (NSImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [NSImageView new];
        _logoImageView.image = [NSImage imageNamed:@"ghostLogoAddBlog"];
        _logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _logoImageView;
}

- (NSTextField *)blogUrlTextField
{
    if (!_blogUrlTextField) {
        _blogUrlTextField = [NSTextField new];
        _blogUrlTextField.placeholderString = NSLocalizedString(@"Ghost Blog URL", nil);
        _blogUrlTextField.focusRingType = NSFocusRingTypeNone;
        _blogUrlTextField.bezelStyle = NSTextFieldRoundedBezel;
        _blogUrlTextField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _blogUrlTextField;
}

- (NSButton *)addBlogButton
{
    if (!_addBlogButton) {
        _addBlogButton = [[NSButton alloc] init];
        _addBlogButton.title = NSLocalizedString(@"Add Blog", nil);
        _addBlogButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_addBlogButton setButtonType:NSMomentaryLightButton];
        [_addBlogButton setBezelStyle:NSRoundedBezelStyle];
        [_addBlogButton setTarget:self];
        [_addBlogButton setAction:@selector(addBlog:)];
    }
    
    return _addBlogButton;
}

#pragma mark - Actions

- (void)addBlog:(id)sender
{
    NSLog(@"Verify URL: %@", self.blogUrlTextField.stringValue);
}

#pragma mark - Constraints

- (void)setUpConstraintsForViews:(NSDictionary *)views
{
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[logoImageView]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[blogUrlTextField]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[addBlogButton]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[logoImageView]-60-[blogUrlTextField(30)]-5-[addBlogButton(30)]" options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
}

@end
