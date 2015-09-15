//
//  BlogSelectorCellView.m
//  Ghost
//
//  Created by Enric Enrich on 15/09/15.
//
//

#import "BlogSelectorCellView.h"

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
    [self addSubview:self.titleTextField];
    
    NSDictionary *views = @{@"titleTextField": self.titleTextField};
    
    [self setUpConstraintsForViews:views];
}

#pragma mark - Getters

- (NSTextField *)titleTextField
{
    if (!_titleTextField) {
        _titleTextField = [NSTextField new];
        _titleTextField.editable = NO;
        _titleTextField.bordered = NO;
        _titleTextField.selectable = NO;
        _titleTextField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleTextField;
}

#pragma mark - Constraints

- (void)setUpConstraintsForViews:(NSDictionary *)views
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[titleTextField]-2-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleTextField]-2-|" options:0 metrics:nil views:views]];
}

@end
