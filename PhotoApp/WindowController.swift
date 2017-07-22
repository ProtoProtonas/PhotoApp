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
	let colorEffectFilterToolbarItemID = "Color Effect Filter"
	
	@IBOutlet var toolbar: NSToolbar!
	
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  zoom toolbar item
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	@IBOutlet var zoomControlView: NSView!
	@IBAction func changeZoom(_ sender: NSSegmentedControl) {
		let whichButton = sender.selectedSegment
		self.zoom(index: whichButton)
	}
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  blur filter toolbar item and popovers
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	@IBOutlet var blurFilterView: NSView!
	@IBOutlet weak var blurFilterPopUpButton: NSPopUpButton!
	
	var blurPopovers: [NSPopover?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil, ]
	var blurPopoverControllerNames: [String] = ["", "BoxBlurPopoverViewController", "DiscBlurPopoverViewController", "GaussianBlurPopoverViewController", "MaskedVariableBlurPopoverViewController", "MedianBlurPopoverViewController", "MotionBlurPopoverViewController", "NoiseBlurPopoverViewController", "ZoomBlurPopoverViewController"]
	var blurPopoverControllers: [NSViewController?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
	
	
	
	
	@IBAction func blurFilter(_ sender: Any) {
		//FILTRO KODAS
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = imageView.image {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			
			switch(blurFilterPopUpButton.indexOfSelectedItem) {
			case 1:
				//let vari: Double? = Double(PopoverViewController().boxBlurTextField.stringValue)
				let filteredImage = ciImage.applyingFilter("CIBoxBlur", withInputParameters: ["inputRadius":PopoverViewController().boxBlurValue])
				NSLog("\(PopoverViewController().boxBlurValue)")
				//CustomImageView().image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
				imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			case 2:
				let filteredImage = ciImage.applyingFilter("CIDiscBlur", withInputParameters: ["inputRadius":10.0])
				imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			case 3:
				let filteredImage = ciImage.applyingFilter("CIGaussianBlur", withInputParameters: [:])
				imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			case 4:
				let filteredImage = ciImage.applyingFilter("CIMaskedVariableBlur", withInputParameters: [:])
				imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			case 5:
				let filteredImage = ciImage.applyingFilter("CIMedianFilter", withInputParameters: [:])
				imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			case 6:
				let filteredImage = ciImage.applyingFilter("CIMotionBlur", withInputParameters: [:])
				imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			case 7:
				let filteredImage = ciImage.applyingFilter("CINoiseReduction", withInputParameters: [:])
				imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			case 8:
				let filteredImage = ciImage.applyingFilter("CIZoomBlur", withInputParameters: [:])
				imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			default:
				NSLog("blurFilter function default case")
			}
		}
		blurPopovers[blurFilterPopUpButton.indexOfSelectedItem] = nil
	}
	
	//color effect filtru valdymas
	@IBOutlet var colorEffectFilterView: NSView!
	@IBOutlet weak var colorEffectPopUpButton: NSPopUpButton!
	let colorEffectFilterNames = ["", "CIColorCrossPolynomial", "CIColorCube", "CIColorCubeWithColorSpace", "CIColorInvert", "CIColorMap", "CIColorMonochrome", "CIColorPosterize", "CIFalseColor", "CIMaskToAlpha", "CIMaximumComponent", "CIMinimumComponent", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone", "CIVignette", "CIVignetteEffect"]
	
	@IBAction func colorEffectFilter(_ sender: Any) {
		//FILTRO KODAS
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = imageView.image {
			let colorEffectFilterName = colorEffectFilterNames[colorEffectPopUpButton.indexOfSelectedItem]
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter(colorEffectFilterName, withInputParameters: [:])
			
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
			
		}
	}
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  popover
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	@IBAction func showPopoverAction(_ sender: NSButton) {
		if blurFilterPopUpButton.indexOfSelectedItem != 0
		{
			self.createPopover(popoverViewController: self.blurPopoverControllers[blurFilterPopUpButton.indexOfSelectedItem]!, x: blurFilterPopUpButton.indexOfSelectedItem)
			let targetButton: NSButton = sender
			let prefEdge: NSRectEdge = NSRectEdge.maxY
			self.blurPopovers[blurFilterPopUpButton.indexOfSelectedItem]?.show(relativeTo: targetButton.bounds, of: sender as NSView, preferredEdge: prefEdge)
		}
		
		
	}
	
	func createPopover(popoverViewController: NSViewController, x: Int) {
		if (self.blurPopovers[x] == nil)
		{
			self.blurPopovers[x] = NSPopover.init()
			self.blurPopovers[x]?.contentViewController = popoverViewController;
			self.blurPopovers[x]?.animates = true
			self.blurPopovers[x]?.appearance = NSAppearance.init(named: NSAppearance.Name.vibrantLight)
			self.blurPopovers[x]?.behavior = NSPopover.Behavior.transient
			self.blurPopovers[x]?.delegate = self //as? NSPopoverDelegate
		}
	}
	
	override func windowDidLoad() {
		super.windowDidLoad()
		
		// toolbar
		
		self.toolbar.allowsUserCustomization = true
		self.toolbar.autosavesConfiguration = true
		self.toolbar.displayMode = .iconOnly
		
		// popover
		
		for x in 1...8 {
			blurPopoverControllers[x] = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: blurPopoverControllerNames[x] )) as? NSViewController
		}
		
		//		let frame: NSRect = self.blurPopoverViewController!.view.bounds
		//		let styleMask: NSWindow.StyleMask =  [.closable, .titled]
		//		let rect: NSRect = NSWindow.contentRect(forFrameRect: frame, styleMask: styleMask)
		//		detachedWindow = NSWindow.init(contentRect: rect, styleMask: styleMask, backing: NSWindow.BackingStoreType.buffered, defer: true)
		//		self.detachedWindow?.contentViewController = self.blurPopoverViewController
		//		self.detachedWindow?.isReleasedWhenClosed = false
		
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
			assertionFailure("Invalid selection")
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
			toolbarItem = customToolbarItem(itemForItemIdentifier: blurFilterToolbarItemID, label: "Blur Filter", paletteLabel:"Blur Filter", toolTip: "Apply blur filter to the image", target: self, itemContent: self.blurFilterView, action: nil, menu: nil)!
		} else if (itemIdentifier == ((colorEffectFilterToolbarItemID as NSString) as NSToolbarItem.Identifier)) {
			// 3) Color effect filter toolbar item.
			toolbarItem = customToolbarItem(itemForItemIdentifier: colorEffectFilterToolbarItemID, label: "Color Effect Filter", paletteLabel:"Color Effect Filter", toolTip: "Apply color effect filter to the image", target: self, itemContent: self.colorEffectFilterView, action: nil, menu: nil)!
		}
		
		return toolbarItem
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		
		return [NSToolbarItem.Identifier(rawValue: ZoomToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: blurFilterToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: colorEffectFilterToolbarItemID)]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		
		return [ NSToolbarItem.Identifier(rawValue: ZoomToolbarItemID),
		         NSToolbarItem.Identifier(rawValue: blurFilterToolbarItemID),
		         NSToolbarItem.Identifier(rawValue: colorEffectFilterToolbarItemID),
		         NSToolbarItem.Identifier.space,
		         NSToolbarItem.Identifier.flexibleSpace,
		         NSToolbarItem.Identifier.showColors]
	}
	
	func popoverShouldDetach(_ popover: NSPopover) -> Bool {
		return true
	}
	
}
