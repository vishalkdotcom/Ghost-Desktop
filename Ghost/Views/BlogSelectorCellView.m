//
//  BlogSelectorCellView.m
//  Ghost
//
//  Created by Enric Enrich on 15/09/15.
//
//

#import "BlogSelectorCellView.h"

@interface BlogSelectorCellView ()

@property (nonatomic, strong) NSView *selectView;

@end

@implementation BlogSelectorCellView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

#pragma mark - Initializers

- (void)initialize
{
    [self addSubview:self.imageView];
    [self addSubview:self.textField];
    [self addSubview:self.selectView];
    
    NSDictionary *views = @{@"imageView": self.imageView,
                            @"textField": self.textField,
                            @"selectView": self.selectView};
    
    [self setUpConstraintsForViews:views];
}

#pragma mark - Public

- (void)selectCell
{
    self.textField.font = [NSFont boldSystemFontOfSize:12];
    self.selectView.layer.backgroundColor = [NSColor grayColor].CGColor;
}

- (void)unselectCell
{
    self.textField.font = [NSFont systemFontOfSize:12];
    self.selectView.layer.backgroundColor = [NSColor clearColor].CGColor;
}

#pragma mark - Getters

- (NSTextField *)textField
{
    if (!_textField) {
        _textField = [NSTextField new];
        _textField.editable = NO;
        _textField.bordered = NO;
        _textField.selectable = NO;
        _textField.alignment = NSCenterTextAlignment;
        _textField.font = [NSFont systemFontOfSize:12];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_textField.cell setLineBreakMode:NSLineBreakByTruncatingTail];
        [_textField.cell setUsesSingleLineMode:YES];
    }
    
    return _textField;
}

- (NSImageView *)imageView
{
    if (!_imageView) {
        _imageView = [NSImageView new];
        _imageView.imageAlignment = NSImageAlignCenter;
        _imageView.wantsLayer = YES;
        _imageView.layer.borderWidth = 0.0;
        _imageView.layer.cornerRadius = 40 / 2;
        _imageView.layer.masksToBounds = YES;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _imageView;
}

- (NSView *)selectView
{
    if (!_selectView) {
        _selectView = [NSView new];
        _selectView.wantsLayer = YES;
        _selectView.layer.backgroundColor = [NSColor clearColor].CGColor;
        _selectView.layer.cornerRadius = 1.5;
        _selectView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _selectView;
}

#pragma mark - Constraints

- (void)setUpConstraintsForViews:(NSDictionary *)views
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(40)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[textField]-2-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[selectView(3)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[imageView(40)]-5-[textField]-5-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[selectView(40)]" options:0 metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
}

@end
