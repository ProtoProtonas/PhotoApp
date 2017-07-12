//
//  CenteredClipView.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/14/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class CenteredClipView: NSClipView  {
    override func constrainBoundsRect(_ proposedBounds: NSRect) -> NSRect {
        var rect = super.constrainBoundsRect(proposedBounds)
        if let containerView = documentView /*as? NSView*/ {
            if (rect.size.width > containerView.frame.size.width) {
                rect.origin.x = (containerView.frame.width - rect.width) / 2
            }
            
            if (rect.size.height > containerView.frame.size.height) {
                rect.origin.y = (containerView.frame.height - rect.height) / 2
            }
        }
        return rect
    }
}
