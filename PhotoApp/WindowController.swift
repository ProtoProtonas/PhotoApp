//  WindowController.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/19/17.
//  Copyright © 2017 Pixelmator. All rights reserved.

import Cocoa
import CoreImage

class WindowController: NSWindowController, NSToolbarDelegate {
	
	let ZoomToolbarItemID = "Zoom"
	let filterToolbarItemID = "Filter"
    
	@IBOutlet var toolbar: NSToolbar!
	//zoom valdymas
    @IBOutlet var zoomControlView: NSView!
    @IBAction func changeZoom(_ sender: NSSegmentedControl) {
		let whichButton = sender.selectedSegment
		self.zoom(index: whichButton)
	}
	
	//filtru valdymas
	@IBOutlet var filterView: NSView!
	@IBOutlet weak var applyButton: NSButton!
	
	@IBOutlet weak var filterChoicePopUpButton: NSPopUpButton!
	let filterNames = ["CIBoxBlur", "CIDiscBlur", "CIGaussianBlur", "CIMaskedVariableBlur", "CIMedianFilter", "CIMotionBlur", "CINoiseReduction", "CIZoomBlur"]
	@IBAction func filter(_ sender: Any) {
		//FILTRO KODAS
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? NSImageView,
			let image = imageView.image {
			let filterName = filterNames[filterChoicePopUpButton.indexOfSelectedItem]
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			//NSLog("\(ciImage)")
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter(filterName, withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			
		}
	}
	
	
    override func windowDidLoad() {
        super.windowDidLoad()
		self.toolbar.allowsUserCustomization = true
        self.toolbar.autosavesConfiguration = true
        self.toolbar.displayMode = .iconOnly
		
    }
	
	func zoom(index: Int) {
		if let view = window?.contentView?.subviews.first as? NSScrollView {
			switch(index) {
			case 0: view.magnification = view.magnification / 1.5
			case 1: view.magnification = view.magnification * 1.5
			default: print("Invalid selection")
			}
		}
	}
	
	func customToolbarItem(itemForItemIdentifier itemIdentifier: String, label: String, paletteLabel: String, toolTip: String, target: AnyObject, itemContent: AnyObject, action: Selector?, menu: NSMenu?) -> NSToolbarItem? {
		
		let toolbarItem = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: itemIdentifier))
		
		toolbarItem.label = label
		toolbarItem.paletteLabel = paletteLabel
		toolbarItem.toolTip = toolTip
		toolbarItem.target = target
		toolbarItem.action = action
		
		// Set the right attribute, depending on if we were given an image or a view.
		if (itemContent is NSImage) {
			let image: NSImage = itemContent as! NSImage
			toolbarItem.image = image
		}
		else if (itemContent is NSView) {
			let view: NSView = itemContent as! NSView
			toolbarItem.view = view
		}
		else {
			assertionFailure("Invalid itemContent: object")
		}
		
		// We actually need an NSMenuItem here, so we construct one.
		let menuItem: NSMenuItem = NSMenuItem()
		menuItem.submenu = menu
		menuItem.title = label
		toolbarItem.menuFormRepresentation = menuItem
		
		return toolbarItem
	}
	
	func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		
		var toolbarItem: NSToolbarItem = NSToolbarItem()
		
		/* We create a new NSToolbarItem, and then go through the process of setting up its
		attributes from the master toolbar item matching that identifier in our dictionary of items.
		*/
		if (itemIdentifier == ((ZoomToolbarItemID as NSString) as NSToolbarItem.Identifier)) {
			// 1) Zoom toolbar item.
			toolbarItem = customToolbarItem(itemForItemIdentifier: ZoomToolbarItemID, label: "Zoom", paletteLabel:"Zoom", toolTip: "Change your zoom level", target: self, itemContent: self.zoomControlView, action: nil, menu: nil)!
		} else if (itemIdentifier == ((filterToolbarItemID as NSString) as NSToolbarItem.Identifier)) {
			// 2) Filter toolbar item.
			toolbarItem = customToolbarItem(itemForItemIdentifier: filterToolbarItemID, label: "Filter", paletteLabel:"Filter", toolTip: "Apply filter to the image", target: self, itemContent: self.filterView, action: nil, menu: nil)!
		}
		
		return toolbarItem
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		
		return [NSToolbarItem.Identifier(rawValue: ZoomToolbarItemID),
		NSToolbarItem.Identifier(rawValue: filterToolbarItemID)]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		
		return [ NSToolbarItem.Identifier(rawValue: ZoomToolbarItemID),
		         NSToolbarItem.Identifier(rawValue: filterToolbarItemID),
		         NSToolbarItem.Identifier.space,
		         NSToolbarItem.Identifier.flexibleSpace]
	}
}
