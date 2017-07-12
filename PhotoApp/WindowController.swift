//  WindowController.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/19/17.
//  Copyright © 2017 Pixelmator. All rights reserved.

import Cocoa
import CoreImage

class WindowController: NSWindowController, NSToolbarDelegate, NSPopoverDelegate {
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  toolbar
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	let ZoomToolbarItemID = "Zoom"
	let blurFilterToolbarItemID = "Blur Filter"
	
	@IBOutlet var toolbar: NSToolbar!
	
	//zoom valdymas
    @IBOutlet var zoomControlView: NSView!
    @IBAction func changeZoom(_ sender: NSSegmentedControl) {
		let whichButton = sender.selectedSegment
		self.zoom(index: whichButton)
	}
	
	//blur filtru valdymas
	@IBOutlet var blurFilterView: NSView!
	@IBOutlet weak var applyButton: NSButton!
	
    @IBOutlet weak var blurFilterPopUpButton: NSPopUpButton!
	let blurFilterNames = ["", "CIBoxBlur", "CIDiscBlur", "CIGaussianBlur", "CIMaskedVariableBlur", "CIMedianFilter", "CIMotionBlur", "CINoiseReduction", "CIZoomBlur"]
	
	@IBAction func blurFilter(_ sender: Any) {
		//FILTRO KODAS
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? NSImageView,
			let image = imageView.image {
			let blurFilterName = blurFilterNames[blurFilterPopUpButton.indexOfSelectedItem]
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			//NSLog("\(ciImage)")
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter(blurFilterName, withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			
		}
	}
	
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  popover
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	var myPopover: NSPopover?
	var popoverViewController: NSViewController?
	var detachedWindow: NSWindow?
	
	@IBAction func showPopoverAction(_ sender: NSButton) {
		if blurFilterPopUpButton.indexOfSelectedItem != 0
		{
			self.createPopover()
			let targetButton: NSButton = sender
			let prefEdge: NSRectEdge = NSRectEdge.maxY
			self.myPopover?.show(relativeTo: targetButton.bounds, of: sender as NSView, preferredEdge: prefEdge)
		}
	}
	
	func createPopover() {
		if (self.myPopover == nil)
		{
			myPopover = NSPopover.init()
			self.myPopover?.contentViewController = self.popoverViewController;
			self.myPopover?.animates = true
			self.myPopover?.appearance = NSAppearance.init(named: NSAppearance.Name.vibrantLight)
			self.myPopover?.behavior = NSPopover.Behavior.transient
			self.myPopover?.delegate = self //as? NSPopoverDelegate
		}
	}
	
	
	
    override func windowDidLoad() {
        super.windowDidLoad()
		
		// toolbar
		
		self.toolbar.allowsUserCustomization = true
        self.toolbar.autosavesConfiguration = true
        self.toolbar.displayMode = .iconOnly
		
		// popover
		
		popoverViewController = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PopoverViewController")) as? NSViewController
		let frame: NSRect = self.popoverViewController!.view.bounds
		let styleMask: NSWindow.StyleMask =  [.closable, .titled]
		let rect: NSRect = NSWindow.contentRect(forFrameRect: frame, styleMask: styleMask)
		detachedWindow = NSWindow.init(contentRect: rect, styleMask: styleMask, backing: NSWindow.BackingStoreType.buffered, defer: true)
		self.detachedWindow?.contentViewController = self.popoverViewController
		self.detachedWindow?.isReleasedWhenClosed = false
		
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
		
//		let menuItem: NSMenuItem = NSMenuItem()
//		menuItem.submenu = menu
//		menuItem.title = label
//		toolbarItem.menuFormRepresentation = menuItem
		
		return toolbarItem
	}
	
	func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		
		var toolbarItem: NSToolbarItem = NSToolbarItem()
	
		if (itemIdentifier == ((ZoomToolbarItemID as NSString) as NSToolbarItem.Identifier)) {
			// 1) Zoom toolbar item.
			toolbarItem = customToolbarItem(itemForItemIdentifier: ZoomToolbarItemID, label: "Zoom", paletteLabel:"Zoom", toolTip: "Change your zoom level", target: self, itemContent: self.zoomControlView, action: nil, menu: nil)!
		} else if (itemIdentifier == ((blurFilterToolbarItemID as NSString) as NSToolbarItem.Identifier)) {
			// 2) Blur filter toolbar item.
			toolbarItem = customToolbarItem(itemForItemIdentifier: blurFilterToolbarItemID, label: "Blur Filter", paletteLabel:"Blur Filter", toolTip: "Apply filter to the image", target: self, itemContent: self.blurFilterView, action: nil, menu: nil)!
		}
		
		return toolbarItem
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		
		return [NSToolbarItem.Identifier(rawValue: ZoomToolbarItemID),
		NSToolbarItem.Identifier(rawValue: blurFilterToolbarItemID)]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		
		return [ NSToolbarItem.Identifier(rawValue: ZoomToolbarItemID),
		         NSToolbarItem.Identifier(rawValue: blurFilterToolbarItemID),
		         NSToolbarItem.Identifier.space,
		         NSToolbarItem.Identifier.flexibleSpace,
				 NSToolbarItem.Identifier.showColors]
	}
	
	func popoverShouldDetach(_ popover: NSPopover) -> Bool {
		return true
	}
	
}
