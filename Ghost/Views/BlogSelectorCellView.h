//
//  BlogSelectorCellView.h
//  Ghost
//
//  Created by Enric Enrich on 15/09/15.
//
//

#import <Cocoa/Cocoa.h>

@interface BlogSelectorCellView : NSView

@property (nonatomic, strong) NSImageView *imageView;
@property (nonatomic, strong) NSTextField *textField;

- (void)selectCell;
- (void)unselectCell;

@end
