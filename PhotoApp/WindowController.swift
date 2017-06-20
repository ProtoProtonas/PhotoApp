//
//  WindowController.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/19/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa
import CoreImage

class WindowController: NSWindowController, NSToolbarDelegate {
    
    let zoomInToolbarItemID = "ZoomInControl"
    let zoomOutToolbarItemID = "ZoomOutControl"
    
    @IBOutlet weak var toolbar: NSToolbar!
    @IBOutlet weak var zoomIn: NSToolbarItem!
    @IBOutlet weak var zoomOut: NSToolbarItem!
    
    @IBAction func zoomIn(_ sender: NSToolbarItem) {
        if let view = window?.contentView?.subviews.first as? NSScrollView {
            //NSLog("\(view)")
            //FIXME: Use animator when zooming will be fast
            view.magnification = view.magnification * 1.5
        }
    }
    
    @IBAction func zoomOut(_ sender: NSToolbarItem) {
        if let view = window?.contentView?.subviews.first as? NSScrollView {
            //NSLog("\(view)")
            //FIXME: Use animator when zooming will be fast
            view.magnification = view.magnification * 0.6667
        }
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.toolbar.allowsUserCustomization = true
        self.toolbar.autosavesConfiguration = true
        self.toolbar.displayMode = .iconOnly
        
    }
}

