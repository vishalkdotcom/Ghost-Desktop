//
//  AddBlogViewController.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

class AddBlogViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.logoImageView)
        self.view.addSubview(self.blogUrlTextField)
        self.view.addSubview(self.addBlogButton)
        
        let views: Dictionary<String, AnyObject> = ["logoImageView": self.logoImageView, "blogUrlTextField": self.blogUrlTextField, "addBlogButton": self.addBlogButton]
        
        self.setUpConstraints(views)
    }
    
    // Getters
    
    private lazy var logoImageView: NSImageView = {
        let imageView: NSImageView = NSImageView()
        imageView.image = NSImage(named: "GhostLogoAddBlog")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private lazy var blogUrlTextField: NSTextField = {
        let textField: NSTextField = NSTextField()
        textField.placeholderString = NSLocalizedString("Ghost Blog Url", comment: "")
        textField.focusRingType = NSFocusRingType.None
        textField.bezelStyle = NSTextFieldBezelStyle.RoundedBezel
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    private lazy var addBlogButton: NSButton = {
        let button: NSButton = NSButton()
        button.title = NSLocalizedString("Add Blog", comment: "")
        button.bezelStyle = NSBezelStyle.RoundedBezelStyle
        button.target = self
        button.action = "addBlog:"
        button.setButtonType(NSButtonType.MomentaryLightButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    // Actions
    
    func addBlog(sender: AnyObject?) {
        let originalUrl: NSURL = NSURL(string: self.blogUrlTextField.stringValue)!
        let filteredUrl: String = originalUrl.scheme + "://" + originalUrl.host!
        
        // Check if the "/ghost path works
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(filteredUrl, parameters: nil, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            
            // Filter HTML to get needed information
            let doc: TFHpple = TFHpple(HTMLData: responseObject as! NSData)
            
            let titles: Array = doc.searchWithXPathQuery("//title")
            let generators: Array = doc.searchWithXPathQuery("//meta[@name='generator']")
            let adminUrlString: String = filteredUrl + "/ghost"
            
            if (titles.count > 0 && generators.count > 0)
            {
                let title: TFHppleElement = titles[0] as! TFHppleElement
                let generator: TFHppleElement = generators[0] as! TFHppleElement
                
                if (generator.objectForKey("content").containsString("Ghost"))
                {
                    // Don't add already added blogs
                    for blog: BlogViewModel in Utils.blogs() {
                        if (blog.urlString() == adminUrlString) { return }
                    }
                    
                    // Check if the "/ghost path works
                    let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
                    manager.responseSerializer = AFHTTPResponseSerializer()
                    manager.GET(adminUrlString, parameters: nil, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                        
                        if (operation.response!.statusCode == 200)
                        {
                            let blogInfo: Dictionary = [UserDefaultsBlogNameKey: title.text(), UserDefaultsBlogUrlKey: adminUrlString]
                            let blog: BlogViewModel = BlogViewModel(blogInfo: blogInfo)
                            
                            var blogs: Array = Utils.unarchivedBlogs()
                            blogs.append(NSKeyedArchiver.archivedDataWithRootObject(blog))
                            
                            Utils.userDefaults().setObject(blogs, forKey: UserDefaultsBlogsKey)
                            Utils.userDefaults().synchronize()
                            
                            NSNotificationCenter.defaultCenter().postNotificationName(DidAddBlogNotification, object: blog)
                        }
                        
                    }, failure: { (requestOperation, error) -> Void in
                            
                        print("Error")
                            
                    })
                }
            }
            
        }, failure: { (requestOperation, error) -> Void in
                
            print("Error")
                
        })
    }
    
    // Constraints
    
    private func setUpConstraints(views: Dictionary<String, AnyObject>) {
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logoImageView]", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[blogUrlTextField]-20-|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[addBlogButton]-20-|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[logoImageView]-60-[blogUrlTextField(30)]-5-[addBlogButton(30)]", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.logoImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
    }
    
}
