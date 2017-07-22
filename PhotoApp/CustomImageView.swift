//
//  CustomImageView.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/26/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

//FIXME: Remove NSImageView, implement drawRect:

//class CustomImageView: NSImageView { }

class CustomImageView: NSView {
    
    var image: NSImage?
    var imageFrameStyle: NSImageView.FrameStyle = NSImageView.FrameStyle.none
    var imageAlignment: NSImageAlignment = NSImageAlignment.alignCenter
    var imageScaling: NSImageScaling = NSImageScaling.scaleProportionallyDown
    var animates: Bool = false
    var isEditable: Bool = true
    var allowsCutCopyPaste: Bool = true
    
    //let secondImage = NSImage(named: NSImage.Name(rawValue: "logo"))
    
    override func draw(_ dirtyRect: NSRect) {
        image?.draw(in: dirtyRect)
//
//        if let secondImage = secondImage,
//            let image = image {
//            secondImage.draw(at: CGPoint(x: 0.0, y: 0.0), from: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), operation: .sourceOver, fraction: 1.0)
//        }
    
    }
    
}
