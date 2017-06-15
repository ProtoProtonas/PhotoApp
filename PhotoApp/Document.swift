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
        super.init() //super - super class (auksciausia hierachijos grandineje) || init() - is dokumentacijos
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
            viewController.imageView?.image = loadedImage
        }
    }
    
    

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        loadedImage = NSImage(data: data)
    }
    
}
