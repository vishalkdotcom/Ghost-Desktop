//
//  BlogViewModel.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

class BlogViewModel: NSObject, NSCoding {
    
    private let BlogViewBlogInfoKey: String = "BlogViewBlogInfoKey"
    
    let blogInfo: Dictionary<String, AnyObject>
    
    // MARK: Init
    
    init(blogInfo: Dictionary<String, AnyObject>) {
        self.blogInfo = blogInfo
    }
    
    required init(coder aDecoder: NSCoder) {
        self.blogInfo = aDecoder.decodeObjectForKey(BlogViewBlogInfoKey) as! Dictionary
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.blogInfo, forKey: BlogViewBlogInfoKey)
    }
    
    // MARK: Public
    
    func name() -> String {
        return self.blogInfo[UserDefaultsBlogNameKey] as! String
    }
    
    func urlString() -> String {
        return self.blogInfo[UserDefaultsBlogUrlKey] as! String
    }
    
    func url() -> NSURL {
        return NSURL(string: self.blogInfo[UserDefaultsBlogUrlKey] as! String)!
    }

}
