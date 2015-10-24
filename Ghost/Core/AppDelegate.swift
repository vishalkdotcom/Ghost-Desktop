//
//  AppDelegate.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(aNotification: NSNotification)
    {        
        if (Utils.blogs().count > 0) {
            self.mainWindowController.showWindow(self)
        } else {
            self.addBlogWindowController.showWindow(self)
        }
        
        // Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didAddBlog:", name: DidAddBlogNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didRemoveBlog", name: DidRemoveBlogNotification, object: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification)
    {
        
    }
    
    // MARK: Actions
    
    func didAddBlog(notification: NSNotification)
    {
        self.mainWindowController.showWindow(self)
        self.addBlogWindowController.close()
    }
    
    func didRemoveBlog(notification: NSNotification)
    {
        print("DidRemoveBlog")
    }
    
    // MARK: Getters
    
    lazy var mainWindowController: MainWindowController = {
        let storyBoard: NSStoryboard = NSStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyBoard.instantiateControllerWithIdentifier("MainWindowController") as! MainWindowController
    } ()
    
    lazy var addBlogWindowController: AddBlogWindowController = {
        let storyBoard: NSStoryboard = NSStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyBoard.instantiateControllerWithIdentifier("AddBlogWindowController") as! AddBlogWindowController
    } ()

}

