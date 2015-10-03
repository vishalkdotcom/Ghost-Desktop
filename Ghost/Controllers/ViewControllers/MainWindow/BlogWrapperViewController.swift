//
//  BlogWrapperViewController.swift
//  Ghost
//
//  Created by Enric Enrich on 03/10/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

class BlogWrapperViewController: NSViewController {
    
    var blogsControllers = Dictionary<String, NSViewController>()
    
    // Override
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createNeededControllers()
    }
    
    override func loadView() {
        self.view = NSView()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "blogSelectionDidChange:", name: BlogSelectionDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didAddBlog:", name: DidAddBlogNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didRemoveBlog:", name: DidRemoveBlogNotification, object: nil)
        
        // UI
        self.view.addSubview(self.blogSelectorViewController.view)
        self.view.addSubview(self.separator)
        self.view.addSubview(self.webViewsContainer)
        
        let views: Dictionary = ["blogSelectorView": self.blogSelectorViewController.view, "separator": self.separator, "webViewsContainer": self.webViewsContainer]
        
        self.setUpConstraints(views)
    }
    
    // Actions
    
    func blogSelectionDidChange(notification: NSNotification) {
        let blog: BlogViewModel = notification.object as! BlogViewModel
        let blogWebViewController: BlogWebViewController = self.blogsControllers[blog.urlString()] as! BlogWebViewController
        
        if (self.webViewsContainer.subviews.count > 0) {
            self.webViewsContainer.replaceSubview(self.webViewsContainer.subviews[0], with: blogWebViewController.view)
        } else {
            self.webViewsContainer.addSubview(blogWebViewController.view)
        }
        
        self.webViewsContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: ["view": blogWebViewController.view]))
        self.webViewsContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: ["view": blogWebViewController.view]))
    }

    func didAddBlog(notification: NSNotification) {
        let blog: BlogViewModel = notification.object as! BlogViewModel
        let blogWebViewController: BlogWebViewController = BlogWebViewController(url: blog.url())
        
        self.blogsControllers[blog.urlString()] = blogWebViewController
    }

    func didRemoveBlog(notification: NSNotification) {
        print("Did Remove Blog")
    }
    
    // Helpers
    
    func createNeededControllers() {
        for blog: BlogViewModel in Utils.blogs() {
            let blogWebViewController: BlogWebViewController = BlogWebViewController(url: blog.url())
            self.blogsControllers[blog.urlString()] = blogWebViewController
        }
    }

    // Getters
    
    lazy var separator: NSView = {
        let view: NSView = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    lazy var webViewsContainer: NSView = {
        let view: NSView = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.whiteColor().CGColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    lazy var blogSelectorViewController: BlogSelectorViewContorller = {
        let viewController: BlogSelectorViewContorller = BlogSelectorViewContorller()
        return viewController
    } ()
    
    // Constraints
    
    internal func setUpConstraints(views: Dictionary<String, AnyObject>) {
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[blogSelectorView(75)][separator(0.5)][webViewsContainer]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[blogSelectorView]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[separator]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[webViewsContainer]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
    }
    
}
