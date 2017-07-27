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
