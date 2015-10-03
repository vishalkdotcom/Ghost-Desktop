//
//  Utils.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

class Utils: NSObject {
    
    class func appDelegate() -> AppDelegate
    {
        return NSApp.delegate as! AppDelegate
    }
    
    class func userDefaults() -> NSUserDefaults
    {
        return NSUserDefaults.standardUserDefaults()
    }
    
    class func unarchivedBlogs() -> Array<NSData>
    {
        let blogs: Array<NSData>? = self.userDefaults().arrayForKey(UserDefaultsBlogsKey) as? Array<NSData>
        
        if (blogs == nil) {
            return []
        }
        
        return blogs!
    }
    
    class func blogs() -> Array<BlogViewModel>
    {
        var blogs: Array<BlogViewModel> = []

        if (self.userDefaults().arrayForKey(UserDefaultsBlogsKey) != nil)
        {
            for blogData in self.userDefaults().arrayForKey(UserDefaultsBlogsKey)! {
                blogs.append(NSKeyedUnarchiver.unarchiveObjectWithData(blogData as! NSData)! as! BlogViewModel)
            }
        }
        else
        {
            return []
        }
        
        return blogs
    }

}
