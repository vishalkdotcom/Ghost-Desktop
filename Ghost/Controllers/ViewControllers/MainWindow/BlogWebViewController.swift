//
//  BlogWebViewController.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa
import WebKit

class BlogWebViewController: NSViewController, WebUIDelegate {

    var url: NSURL = NSURL()
    
    init(url: NSURL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)!
    }
    
    // MARK: Override
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.view = NSView()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.webView)
        
        self.webView.mainFrame.loadRequest(NSURLRequest(URL: self.url))
        
        let views: Dictionary<String, AnyObject> = ["webView": self.webView]
        
        self.setUpConstraints(views)
    }
    
    // MARK: WebUIDelegate
    func webView(sender: WebView!, runOpenPanelForFileButtonWithResultListener resultListener: WebOpenPanelResultListener!) {
        let openDlg: NSOpenPanel = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        
        if (openDlg.runModal() == NSModalResponseOK) {
            let files: Array = openDlg.URLs
            resultListener.chooseFilenames(files)
        }
    }
    
    // MARK: Getters
    
    lazy var webView: WebView = {
        let webView: WebView = WebView()
        webView.UIDelegate = self
        webView.wantsLayer = true
        webView.layer?.backgroundColor = NSColor.whiteColor().CGColor
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
        } ()
    
    // MARK: Constraints
    
    func setUpConstraints(views: Dictionary<String, AnyObject>) {
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[webView]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views))
    }
    
}
