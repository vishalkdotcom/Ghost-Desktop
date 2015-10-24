//
//  BlogSelectorCellView.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

class BlogSelectorCellView: NSView {
    
    // MARK: Override
    
    init() {
        super.init(frame: CGRectZero)
        self.initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Initializer
    
    func initialize() {
        self.addSubview(self.imageView)
        self.addSubview(self.textField)
        self.addSubview(self.selectView)
        
        let views: Dictionary = Dictionary(dictionaryLiteral: ("imageView", self.imageView), ("textField", self.textField), ("selectView", self.selectView))
        
        self.setUpConstraints(views)
    }
    
    // MARK: Actions
    
    func selectCell() {
        self.textField.font = NSFont.boldSystemFontOfSize(12)
        self.selectView.layer?.backgroundColor = NSColor.grayColor().CGColor
        self.imageView.layer?.borderWidth = 1.5
    }
    
    func unselectCell() {
        self.textField.font = NSFont.systemFontOfSize(12)
        self.selectView.layer?.backgroundColor = NSColor.clearColor().CGColor
        self.imageView.layer?.borderWidth = 0.0
    }

    // MARK: Getters
    
    lazy var imageView: NSImageView = {
        let imageView: NSImageView = NSImageView()
        imageView.imageAlignment = NSImageAlignment.AlignCenter
        imageView.wantsLayer = true
        imageView.layer?.borderWidth = 0.0
        imageView.layer?.borderColor = NSColor.whiteColor().CGColor
        imageView.layer?.cornerRadius = 40 / 2
        imageView.layer?.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    lazy var textField: NSTextField = {
        let textField: NSTextField = NSTextField()
        textField.editable = false
        textField.bordered = false
        textField.selectable = false
        textField.alignment = NSTextAlignment.Center
        textField.font = NSFont.systemFontOfSize(12)
        textField.drawsBackground = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.cell?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        textField.cell?.usesSingleLineMode = true
        return textField
    } ()
    
    private lazy var selectView: NSView = {
        let view: NSView = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.clearColor().CGColor
        view.layer?.cornerRadius = 1.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    // MARK: Constraints
    
    private func setUpConstraints(views: Dictionary<String, AnyObject>) {
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[imageView(40)]", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[textField]-2-|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[selectView(3)]", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[imageView(40)]-5-[textField]-5-|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[selectView(40)]", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        
        self.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
    }
    
}
