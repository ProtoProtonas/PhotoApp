//
//  CustomImageView.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/26/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

//FIXME: Remove NSImageView, implement drawRect:
class CustomImageView: NSView {
    
    
//    let view = WindowController().window?.contentView?.subviews.first as? NSScrollView
//    let imageView = view.documentView?.subviews.first as? NSImageView
//    let image1 = imageView.image
    
    //var image: NSImage? = Document().windowControllers.first?.contentViewController //imageView?.image //loadedImage
    
    var image: NSImage? = Document().loadedImage
    var imageFrameStyle: NSImageView.FrameStyle = NSImageView.FrameStyle.none
    var imageAlignment: NSImageAlignment = NSImageAlignment.alignCenter
    var imageScaling: NSImageScaling = NSImageScaling.scaleProportionallyDown
    var animates: Bool = false
    
    
    
    let secondImage = NSImage(named: NSImage.Name(rawValue: "logo"))
    
    override func draw(_ dirtyRect: NSRect) {
        image?.draw(in: dirtyRect)
        if let secondImage = secondImage,
            let image = image {
            //secondImage.draw(at: CGPoint(x: 0.0, y: 0.0), from: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), operation: .sourceOver, fraction: 1.0)
            secondImage.draw(in: image.alignmentRect, from: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), operation: .sourceOver, fraction: 1.0)
        }
    }
    
}
