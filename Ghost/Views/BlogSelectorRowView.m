//
//  BlogSelectorRowView.m
//  Ghost
//
//  Created by Enric Enrich on 15/09/15.
//
//

#import "BlogSelectorRowView.h"

@implementation BlogSelectorRowView

- (void)drawSelectionInRect:(NSRect)dirtyRect
{
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone)
    {
        [[NSColor clearColor] setStroke];
        [[NSColor clearColor] setFill];
        
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:dirtyRect];
        [selectionPath fill];
        [selectionPath stroke];
    }
}

@end
