//
//  CustomImageView.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/26/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa
import MetalKit

class CustomImageView: NSView {
    
    var windowController: WindowController? = nil
    
    var image: CIImage? = nil
    
    
    var cropRect: CGRect = CGRect.zero {didSet{needsDisplay = true}}
    var mouseLocationDragStart: CGPoint = .zero
    var mouseLocationDragFinish: CGPoint = .zero
    var theOrigin: CGPoint = .zero
    var theSize: CGSize = CGSize(width: 1.0, height: 1.0)
    var initialRotationAngle: CGFloat = 0.0
    var finalRotationAngle: CGFloat = 0.0
    
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        
        if let indexOfButton = windowController?.geometryControls.indexOfSelectedItem {
            
            image = (windowController?.contentViewController as! ViewController).image
            switch indexOfButton {
            case 0:
                if let view = window?.contentView,
                    let scrollView = view.subviews.first as? NSScrollView,
                    let clipView = scrollView.subviews.first as? CenteredClipView,
                    let metalView = clipView.subviews.first as? MTKView,
                    let customView = metalView.subviews.first as? CustomImageView {
                    self.cropRect.origin = self.window!.contentView!.convert(event.locationInWindow, to: self)
                }
                self.theOrigin = transformCoordinate(from: event.locationInWindow)
                self.mouseLocationDragStart = self.theOrigin
            case 1:
                self.mouseLocationDragStart = transformCoordinate(from: event.locationInWindow)
                
                if let image = self.image {
                    self.initialRotationAngle = pointToAngle(from: self.mouseLocationDragStart, imageSize: image.extent.size)
                }
                
            default:
                NSLog("mouseDown default statement")
            }
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        let mouseLocation = self.window!.contentView!.convert(event.locationInWindow, to: self)
        
        if let indexOfButton = windowController?.geometryControls.selectedSegment,
            (windowController?.geometryControls.isSelected(forSegment: indexOfButton))! {
            switch indexOfButton {
            case 0:
                cropRect.size = CGSize(width: mouseLocation.x - cropRect.origin.x, height: mouseLocation.y - cropRect.origin.y)
            case 1:
                finalRotationAngle = pointToAngle(from: transformCoordinate(from: event.locationInWindow), imageSize: image!.extent.size)
                self.windowController?.updateRotation(with: finalRotationAngle - initialRotationAngle)
            default:
                _ = 4
            }
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        if let indexOfButton = windowController?.geometryControls.selectedSegment,
            (windowController?.geometryControls.isSelected(forSegment: indexOfButton))! {
            switch indexOfButton {
            case 0:
                self.mouseLocationDragFinish = transformCoordinate(from: event.locationInWindow)
                theSize.width = abs(mouseLocationDragStart.x - mouseLocationDragFinish.x)
                theSize.height = abs(mouseLocationDragStart.y - mouseLocationDragFinish.y)
                if mouseLocationDragStart.x > mouseLocationDragFinish.x {
                    theOrigin.x = mouseLocationDragFinish.x
                }
                if mouseLocationDragStart.y > mouseLocationDragFinish.y {
                    theOrigin.y = mouseLocationDragFinish.y
                }
                
                self.windowController?.updateCrop(with: CGRect(origin: self.theOrigin, size: self.theSize))
                windowController?.geometryControls.setSelected(false, forSegment: indexOfButton)
                self.cropRect = .zero
                
            case 1:
                self.mouseLocationDragFinish = transformCoordinate(from: event.locationInWindow)
                
                if let image = image {
                    self.finalRotationAngle = pointToAngle(from: self.mouseLocationDragFinish, imageSize: image.extent.size)
                }
                self.windowController?.updateRotation(with: finalRotationAngle - initialRotationAngle)
                windowController?.geometryControls.setSelected(false, forSegment: indexOfButton)
            default:
                NSLog("mouseUp default statement")
            }
        }
    }
    
    func transformCoordinate(from origin: CGPoint) -> CGPoint {
        var newOrigin = self.convert(origin, from: window?.contentView)
        newOrigin.x = newOrigin.x * ((self.image?.extent.size.width)! / (window?.contentView?.frame.size.width)!)
        newOrigin.y = newOrigin.y * ((self.image?.extent.size.height)! / (window?.contentView?.frame.size.height)!)
        
        let imageAspectRatio = (image?.extent.size.width)! / (image?.extent.size.height)!
        let boundsAspectRatio = (window?.contentView?.frame.size.width)! / (window?.contentView?.frame.size.height)!
        var actualX: CGFloat = 0.0
        var actualY: CGFloat = 0.0
        
        if let image = image {
            if imageAspectRatio < boundsAspectRatio {
                actualX = newOrigin.x * ((window?.contentView?.frame.size.width)! / ((window?.contentView?.frame.size.height)! * imageAspectRatio)) - (((image.extent.size.height * boundsAspectRatio) - image.extent.size.width) / 2)
                actualY = newOrigin.y
            } else {
                actualY = newOrigin.y * ((window?.contentView?.frame.size.height)! / ((window?.contentView?.frame.size.width)! / imageAspectRatio)) - (((image.extent.size.width / boundsAspectRatio) - image.extent.size.height) / 2)
                actualX = newOrigin.x
            }
        }
        if let image = image {
            if actualX > image.extent.size.width {
                actualX = image.extent.size.width
            } else if actualX < 0.0 {
                actualX = 0.0
            }
            if actualY > image.extent.size.height {
                actualY = image.extent.size.height
            } else if actualY < 0.0 {
                actualY = 0.0
            }
        }
        return CGPoint(x: actualX, y: actualY)
    }
    
    func pointToAngle(from point: CGPoint, imageSize: CGSize) -> CGFloat {
        let middleX = imageSize.width / 2
        let middleY = imageSize.height / 2
        
        let theX = middleX - point.x
        let theY = middleY - point.y
        let half: CGFloat
        let quarterTuple = (middleX < point.x, middleY < point.y)
        switch quarterTuple {
        case(true, false):
            half = 0.0
        case(false, false):
            half = 1.0
        case(false, true):
            half = 1.0
        default:
            half = 0.0
        }
        
        return (atan(theY / theX)  + (half * 3.14159265))
    }
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.systemGray.setStroke()
        NSBezierPath(rect: cropRect).stroke()
        NSColor(white: 1.0, alpha: 0.3).setFill()
        NSBezierPath(rect: cropRect).fill()
    }
    
}
