//
//  CustomImageView.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/26/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class CustomImageView: NSView {
    
    var image: NSImage? {didSet{needsDisplay = true}}
    
    weak var windowController: WindowController? = nil
    
    var cropRect: CGRect = CGRect.zero {didSet{needsDisplay = true}}
    var mouseLocationDragStart: CGPoint = .zero
    var mouseLocationDragFinish: CGPoint = .zero
    var theOrigin: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var theSize: CGSize = CGSize(width: 1.0, height: 1.0)
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        if windowController?.cropButton.state == NSButton.StateValue.on {
            self.cropRect.origin = convert(event.locationInWindow, to: window?.contentView)
            self.theOrigin = transformOrigin(from: event.locationInWindow)
            self.mouseLocationDragStart = self.theOrigin
        }
    }

    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        let mouseLocation = convert(event.locationInWindow, from: window?.contentView)
        cropRect.size = CGSize(width: mouseLocation.x - cropRect.origin.x, height: mouseLocation.y - cropRect.origin.y)

        if windowController?.cropButton.state == NSButton.StateValue.on {
            cropRect.size = CGSize(width: mouseLocation.x - cropRect.origin.x, height: mouseLocation.y - cropRect.origin.y)
            
            // stuff for crop visualisation
        }
    }
 
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        if windowController?.cropButton.state == NSButton.StateValue.on {
            self.cropRect = .zero
            self.mouseLocationDragFinish = transformOrigin(from: event.locationInWindow)
            theSize.width = abs(mouseLocationDragStart.x - mouseLocationDragFinish.x)
            theSize.height = abs(mouseLocationDragStart.y - mouseLocationDragFinish.y)
            if mouseLocationDragStart.x > mouseLocationDragFinish.x {
                theOrigin.x = mouseLocationDragFinish.x
            }
            if mouseLocationDragStart.y > mouseLocationDragFinish.y {
                theOrigin.y = mouseLocationDragFinish.y
            }
            
            self.windowController?.updateCrop(with: CGRect(origin: self.theOrigin, size: self.theSize))
            windowController?.cropButton.state = NSButton.StateValue.off
        }
    }

    func transformOrigin(from origin: CGPoint) -> CGPoint {
        var newOrigin = self.convert(origin, from: window?.contentView)
        newOrigin.x = newOrigin.x * ((self.image?.size.width)! / (window?.contentView?.frame.size.width)!)
        newOrigin.y = newOrigin.y * ((self.image?.size.height)! / (window?.contentView?.frame.size.height)!)
        
        let imageAspectRatio = (image?.size.width)! / (image?.size.height)!
        let boundsAspectRatio = (window?.contentView?.frame.size.width)! / (window?.contentView?.frame.size.height)!
        var actualX: CGFloat = 0.0
        var actualY: CGFloat = 0.0
        if let image = image {
            if imageAspectRatio < boundsAspectRatio {
                actualX = newOrigin.x * ((window?.contentView?.frame.size.width)! / ((window?.contentView?.frame.size.height)! * imageAspectRatio)) - (((image.size.height * boundsAspectRatio) - image.size.width) / 2)
                actualY = newOrigin.y
            } else {
                actualY = newOrigin.y * ((window?.contentView?.frame.size.height)! / ((window?.contentView?.frame.size.width)! / imageAspectRatio)) - (((image.size.width / boundsAspectRatio) - image.size.height) / 2)
                actualX = newOrigin.x
            }
        }
        if let image = image {
            if actualX > image.size.width {
                actualX = image.size.width
            } else if actualX < 0.0 {
                actualX = 0.0
            }
            if actualY > image.size.height {
                actualY = image.size.height
            } else if actualY < 0.0 {
                actualY = 0.0
            }
        }
        return CGPoint(x: actualX, y: actualY)
    }
    
    
    
    
//    let secondImage = NSImage(named: NSImage.Name(rawValue: "logo"))
// actual imageView stuff for showing the image
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.white.setFill()
        __NSRectFill(cropRect)
        
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
