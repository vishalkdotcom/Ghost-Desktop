//
//  BlogSelectorRowView.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

class BlogSelectorRowView: NSTableRowView {

    // MARK: Override
    
    override func drawSelectionInRect(dirtyRect: NSRect) {
        NSColor.clearColor().setStroke()
        NSColor.clearColor().setFill()
        
        let selectionPath: NSBezierPath = NSBezierPath(rect: dirtyRect)
        selectionPath.fill()
        selectionPath.stroke()
    }
    
}
