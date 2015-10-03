//
//  BlogSelectorViewContorller.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

class BlogSelectorViewContorller: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    internal var blogs: Array<AnyObject> = []
    internal var selectedRow: Int = 0
    
    override func loadView() {
        self.view = NSView()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        self.view.addSubview(self.tableScrollView)
        self.view.addSubview(self.addBlogButton)
        
        let views: Dictionary = ["tableScrollView": self.tableScrollView, "addBlogButton": self.addBlogButton]
        
        self.setUpConstraints(views)
        
        // Data
        self.fetchBlogs()
        self.tableView.reloadData()
        
        // Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didAddBlog:", name: DidAddBlogNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didRemoveBlog:", name: DidRemoveBlogNotification, object: nil)
    }
    
    // NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.blogs.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let blog: BlogViewModel = self.blogs[row] as! BlogViewModel
        
        let cellView: BlogSelectorCellView = BlogSelectorCellView()
        cellView.imageView.image = NSImage(named: "GhostIcon")
        cellView.textField.stringValue = blog.name()
        
        return cellView
    }
    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return BlogSelectorRowView()
    }
    
    // NSTableViewDelegate
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 75.0
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let previousCellView: BlogSelectorCellView = self.tableView.viewAtColumn(0, row: self.selectedRow, makeIfNecessary: true) as! BlogSelectorCellView
        previousCellView.unselectCell()
        
        let currentCellView: BlogSelectorCellView = self.tableView.viewAtColumn(0, row: self.tableView.selectedRow, makeIfNecessary: true) as! BlogSelectorCellView
        currentCellView.selectCell()
        
        self.selectedRow = self.tableView.selectedRow
        
        NSNotificationCenter.defaultCenter().postNotificationName(BlogSelectionDidChangeNotification, object: self.blogs[self.selectedRow])
    }
    
    // Actions
    
    internal func didAddBlog(notification: NSNotification) {
        self.fetchBlogs()
        self.tableView.reloadData()
    }
    
    internal func didRemoveBlog(notification: NSNotification) {
        self.fetchBlogs()
        self.tableView.reloadData()
    }
    
    internal func openAddButtonWindow(sender: AnyObject?) {
        Utils.appDelegate().addBlogWindowController.showWindow(nil)
    }
    
    // Public
    
    func selectedBlog() -> BlogViewModel {
        return BlogViewModel(blogInfo: self.blogs[0] as! Dictionary)
    }
    
    // Getters
    
    internal lazy var tableScrollView: NSScrollView = {
        let scrollView: NSScrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.verticalScrollElasticity = NSScrollElasticity.None
        scrollView.documentView = self.tableView
        scrollView.borderType = NSBorderType.NoBorder
        scrollView.drawsBackground = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    } ()
    
    internal lazy var tableView: NSTableView = {
        let column: NSTableColumn = NSTableColumn(identifier: "Column")
        column.width = 73
        column.editable = false
        
        let tableView: NSTableView = NSTableView()
        tableView.headerView = nil
        tableView.setDataSource(self)
        tableView.setDelegate(self)
        tableView.allowsEmptySelection = false
        tableView.backgroundColor = NSColor.clearColor()
        tableView.addTableColumn(column)
        return tableView
    } ()
    
    internal lazy var addBlogButton: NSButton = {
        let button: NSButton = NSButton()
        button.title = "+"
        button.bezelStyle = NSBezelStyle.RoundedBezelStyle
        button.target = self
        button.action = "openAddButtonWindow:"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    // Constraints
    
    internal func setUpConstraints(views: Dictionary<String, AnyObject>) {
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 75))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableScrollView]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[addBlogButton]-10-|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-22-[tableScrollView]-10-[addBlogButton(55)]-10-|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
    }
    
    // Data
    
    internal func fetchBlogs() {
        self.blogs = Utils.blogs()
    }
    
}
