//
//  CustomImageView.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/26/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class CustomImageView: NSView {
    
    var image: NSImage? {
        didSet { needsDisplay = true }
    }
    
    weak var windowController: WindowController?
    
    var mouseLocationDragStart: CGPoint = .zero
    var mouseLocationDragFinish: CGPoint = .zero
    
    var theRect: CGRect = .zero {
        didSet { windowController?.updateCrop(with: CIVector(cgRect: theRect)) }
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        self.mouseLocationDragStart = event.locationInWindow
        theRect.origin = self.mouseLocationDragStart
        NSLog("\(event.locationInWindow) start")
    }
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        theRect.size.width = event.locationInWindow.x
        theRect.size.height = event.locationInWindow.y
        //let vector: CIVector = [mouseLocationDragStart.x, mouseLocationDragStart.y, event.locationInWindow.x, event.locationInWindow.y]
        NSLog("\(CIVector(cgRect: theRect)) dragged")
//        self.windowController?.updateCrop(with: CIVector(cgRect: theRect))
        
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        self.mouseLocationDragFinish = event.locationInWindow
//        self.windowController?.updateCrop(with: CIVector(cgRect: theRect))
        NSLog("\(event.locationInWindow) finish")
        
    }
    
//    let secondImage = NSImage(named: NSImage.Name(rawValue: "logo"))
    
    override func draw(_ dirtyRect: NSRect) {
        var constrainedBounds = self.bounds
        if let image = image {
            let imageAspectRatio = image.size.width / image.size.height
            let boundsAspectRatio = bounds.size.width / bounds.size.height
            if imageAspectRatio > boundsAspectRatio {
                constrainedBounds.size.height = (constrainedBounds.size.width / imageAspectRatio).rounded()
                constrainedBounds.origin.y = ((self.bounds.size.height - (constrainedBounds.size.width / imageAspectRatio)) / 2).rounded()
            } else {
                constrainedBounds.size.width = (constrainedBounds.size.height * imageAspectRatio).rounded()
                constrainedBounds.origin.x = ((self.bounds.size.width - (constrainedBounds.size.height * imageAspectRatio)) / 2).rounded()
            }
            image.draw(in: constrainedBounds)
        }
        
//                if let secondImage = secondImage,
//                    let image = image {
//                    secondImage.draw(in: constrainedBounds, from: image.alignmentRect , operation: .sourceOver, fraction: 1.0)
//                }
        
        
        
    }
    
}
