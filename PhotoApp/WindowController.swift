//  WindowController.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/19/17.
//  Copyright © 2017 Pixelmator. All rights reserved.

import Cocoa
import CoreImage

class WindowController: NSWindowController, NSToolbarDelegate {
    
    @IBOutlet weak var toolbar: NSToolbar!
	@IBOutlet weak var zoomIn: NSToolbarItem!
    @IBOutlet weak var zoomOut: NSToolbarItem!
	@IBOutlet weak var action: NSToolbarItem!
	@IBOutlet weak var save: NSToolbarItem!
	
//	@IBAction func save(_ sender: Any) {
//		let view = window?.contentView?.subviews.first as? NSScrollView
//		let imageView = view?.documentView?.subviews.first as? NSImageView
//		let image = imageView?.image
////		let urlurl: URL = URL("/Desktop/") as URL
////		if  image != nil {
////			try NSImage().savePNGRepresentationToURL(url: urlurl) { }
////		}
//	}
	
	
	@IBAction func filter(_ sender: Any) {
	 //FILTRO KODAS
            if let view = window?.contentView?.subviews.first as? NSScrollView,
                let imageView = view.documentView?.subviews.first as? NSImageView,
                let image = imageView.image {
                let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
                let ciImage = CIImage(cgImage: cgImage)
                //NSLog("\(ciImage)")
                let ciContext = CIContext()
                let filteredImage = ciImage.applyingGaussianBlur(withSigma: 10.0)
                imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
				
            }
	}
	
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
