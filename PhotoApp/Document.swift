//
//  Document.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/14/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    override init() {
        super.init()
    }
    
    override class var autosavesInPlace: Bool {
        return true
    }
    
    var loadedImage: NSImage?
    
    override func makeWindowControllers() {
        // padaro storyboard kuris atvaizduoja dokumenta
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil) //sukuriamas storyboard
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController // sukuria window controller
        self.addWindowController(windowController)
        
        if let viewController = windowControllers.first?.contentViewController as? ViewController {
            let actuallyLoadedImage: NSImage
            if let image = loadedImage {
                actuallyLoadedImage = image
            } else {
                actuallyLoadedImage = NSImage(named: NSImage.Name(rawValue: "photo"))!
            }
            viewController.imageView?.image = actuallyLoadedImage
            windowController.window?.setFrame(CGRect(origin: origin(winsize: winsizeXY(imgsize: actuallyLoadedImage.size)), size: winsizeXY(imgsize: actuallyLoadedImage.size)), display: true)
        }
        
    }
    
    func winsizeXY(imgsize: CGSize) -> CGSize {
        
        let toolHeight: CGFloat = 75.0 //NSWindow().toolbarHeight()
        let dispX: CGFloat = (NSScreen.main?.visibleFrame.width)!
        let dispY: CGFloat = (NSScreen.main?.visibleFrame.height)!
        let imgX: CGFloat = imgsize.width
        let imgY: CGFloat = imgsize.height
        var winX: CGFloat
        var winY: CGFloat
        var tooBigX: Bool = false
        var tooBigY: Bool = false
        
        if imgY > dispY { tooBigY = true }
        if imgX > dispX { tooBigX = true }
        
        let imgRatio: CGFloat = imgX/imgY
        let tooBig = (tooBigX, tooBigY)
        
        switch tooBig {
        case (true, false) :
            winX = dispX
            winY = winX/imgRatio
        case (false, true) :
            winY = dispY
            winX = winY*imgRatio
        case (true, true) :
            let dispRatio: CGFloat = dispX/dispY
            
            if dispRatio < imgRatio {
                winX = dispX
                winY = winX/imgRatio
            }
            else {
                winY = dispY
                winX = winY*imgRatio
            }
        default:
        if imgY > 150.0 {
            winY = imgY
        } else { winY = 150.0 }
        
        if imgX > 300.0 {
            winX = imgX
        } else { winX = 300.0 }
        }
        winX = winX - toolHeight*imgRatio
        //winY = winY + toolHeight
        return CGSize(width: winX, height: winY)
    }
    
    func origin(winsize: CGSize) -> CGPoint {
        //get display size
        let dispX: CGFloat = (NSScreen.main?.frame.width)!
        let dispY: CGFloat = (NSScreen.main?.frame.height)!
        let winX: CGFloat = winsize.width
        let winY: CGFloat = winsize.height
        let point: CGPoint = CGPoint(x: (dispX - winX)/2, y: (dispY - winY)/2)
        return point
    }
    
    override func data(ofType typeName: String) throws -> Data {
        return loadedImage!.tiffRepresentation!
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        loadedImage = NSImage(data: data)
    }
}


extension NSWindow {
    func toolbarHeight() -> CGFloat {
        var toolbar: NSToolbar?
        var toolbarHeight: CGFloat = CGFloat(0.0)
        var windowFrame: NSRect
        toolbar = self.toolbar
        if let toolbar = toolbar {
            if toolbar.isVisible {
                windowFrame = NSWindow.contentRect(forFrameRect: self.frame, styleMask: self.styleMask)
                toolbarHeight = windowFrame.height - (self.contentView?.frame.height)!
            }
        }
        return CGFloat(toolbarHeight)
    }
}
