//
//  MainWindowController.swift
//  Ghost
//
//  Created by Enric Enrich on 19/09/15.
//  Copyright © 2015 Ghost. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    // MARK: Override
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        self.window?.titleVisibility = NSWindowTitleVisibility.Hidden
        self.window?.titlebarAppearsTransparent = true
        self.window?.styleMask |= NSFullSizeContentViewWindowMask
        
        self.window?.setFrameAutosaveName("BlogsWindow")
    }

}
