//  WindowController.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/19/17.
//  Copyright © 2017 Pixelmator. All rights reserved.

import Cocoa
import CoreImage

class WindowController: NSWindowController, NSToolbarDelegate, NSPopoverDelegate {
	
	var originalImage: NSImage? = nil
//	var metalDevice = MTLCreateSystemDefaultDevice()
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  toolbar
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	let ZoomToolbarItemID = "Zoom"
	let blurFilterToolbarItemID = "Blur Filter"
	let colorEffectFilterToolbarItemID = "Color Effect Filter"
	let colorAdjustmentFilterToolbarItemID = "Color Adjustment Filter"
	let geometryAdjustToolbarItemID = "Geometry Adjustment"
	
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
	
	func updateBoxBlur(with boxRadius: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
		let filteredImage = ciImage.applyingFilter("CIBoxBlur", withInputParameters: ["inputRadius": boxRadius])
		imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateDiscBlur(with discRadius: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIDiscBlur", withInputParameters: ["inputRadius": discRadius])
			if let filteredImage = ciContext.createCGImage(filteredImage, from: ciImage.extent) {
				imageView.image = NSImage(cgImage: filteredImage, size: image.size)
			} else {
				NSLog("Unable to do disc blur")
			}
		}
	}
	
	func updateGaussianBlur(with sigma: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIGaussianBlur", withInputParameters: ["inputRadius": sigma])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateMaskedVariableBlur(with radius: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIMaskedVariableBlur", withInputParameters: ["inputRadius": radius])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateMedianFilter() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIMedianFilter", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateMotionBlur(with motionRadius: Double, motionAngle: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIMotionBlur", withInputParameters: ["inputRadius": motionRadius, "inputAngle": motionAngle])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateNoiseReduction(with noiseLevel: Double, sharpness: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CINoiseReduction", withInputParameters: ["inputNoiseLevel": noiseLevel, "inputSharpness": sharpness])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateZoomBlur(with amount: Double, center: CIVector) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
//			let ciContext = CIContext.init(mtlDevice: self.metalDevice!, options: ["isLowPower": false])
			let filteredImage = ciImage.applyingFilter("CIZoomBlur", withInputParameters: ["inputAmount": amount, "inputCenter": center])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	@IBAction func showBlurPopoverAction(_ sender: NSButton) {
		if blurFilterPopUpButton.indexOfSelectedItem != 0
		{
			self.createBlurPopover(popoverViewController: self.blurPopoverControllers[blurFilterPopUpButton.indexOfSelectedItem]!, x: blurFilterPopUpButton.indexOfSelectedItem)
			let targetButton: NSButton = sender
			let prefEdge: NSRectEdge = NSRectEdge.maxY
			self.blurPopovers[blurFilterPopUpButton.indexOfSelectedItem]?.show(relativeTo: targetButton.bounds, of: sender as NSView, preferredEdge: prefEdge)
		}
	}
	
	func createBlurPopover(popoverViewController: NSViewController, x: Int) {
		if (self.blurPopovers[x] == nil)
		{
			self.blurPopovers[x] = NSPopover.init()
			self.blurPopovers[x]?.contentViewController = popoverViewController;
			self.blurPopovers[x]?.animates = true
			self.blurPopovers[x]?.appearance = NSAppearance.init(named: NSAppearance.Name.vibrantLight)
			self.blurPopovers[x]?.behavior = NSPopover.Behavior.transient
			self.blurPopovers[x]?.delegate = self
			(self.blurPopovers[x]?.contentViewController as? PopoverViewController)?.windowController = self
		}
	}
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  color adjustment filter toolbar item and popovers
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	@IBOutlet var colorAdjustmentFilterView: NSView!
	@IBOutlet weak var colorAdjustmentFilterPopUpButton: NSPopUpButton!
	
	var colorAdjustmentPopovers: [NSPopover?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
	var colorAdjustmentPopoverControllerNames: [String] = ["", "ColorClampPopoverViewController", "ColorControlsPopoverViewController", "ColorMatrixPopoverViewController", "ColorPolynomialPopoverViewController", "ExposureAdjustPopoverViewController", "GammaAdjustPopoverViewController", "HueAdjustPopoverViewController", "LinearToSRGBToneCurvePopoverViewController", "SRGBToneCurveToLinearPopoverViewController", "TemperatureAndTintPopoverViewController", "ToneCurvePopoverViewController", "VibrancePopoverViewController", "WhitePointAdjustPopoverViewController"]
	var colorAdjustmentPopoverControllers: [NSViewController?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
	
	// labai daug funkciju
	
	func updateColorControls(with saturation: Double, brightness: Double, contrast: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIColorControls", withInputParameters: ["inputSaturation": saturation, "inputBrightness": brightness, "inputContrast": contrast])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateExposureAdjust(with ev: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIExposureAdjust", withInputParameters: ["inputEV": ev])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateGammaAdjust(with power: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIGammaAdjust", withInputParameters: ["inputPower": power])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateHueAdjust(with angle: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIHueAdjust", withInputParameters: ["inputAngle": angle])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateLinearToSRGBFilter() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CILinearToSRGBToneCurve", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateSRGBToLinearFilter() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CISRGBToneCurveToLinear", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateVibranceAdjust(with vibrance: Double) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIVibrance", withInputParameters: ["inputAmount": vibrance])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateWhitePointAdjust(with whitePoint: CIColor) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIWhitePointAdjust", withInputParameters: ["inputColor": whitePoint])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	@IBAction func showColorAdjustmentPopoverAction(_ sender: NSButton) {
		if colorAdjustmentFilterPopUpButton.indexOfSelectedItem != 0
		{
			self.createColorAdjustmentPopover(popoverViewController: self.colorAdjustmentPopoverControllers[colorAdjustmentFilterPopUpButton.indexOfSelectedItem]!, x: colorAdjustmentFilterPopUpButton.indexOfSelectedItem)
			let targetButton: NSButton = sender
			let prefEdge: NSRectEdge = NSRectEdge.maxY
			self.colorAdjustmentPopovers[colorAdjustmentFilterPopUpButton.indexOfSelectedItem]?.show(relativeTo: targetButton.bounds, of: sender as NSView, preferredEdge: prefEdge)
		}
	}
	
	func createColorAdjustmentPopover(popoverViewController: NSViewController, x: Int) {
		if (self.colorAdjustmentPopovers[x] == nil)
		{
			self.colorAdjustmentPopovers[x] = NSPopover.init()
			self.colorAdjustmentPopovers[x]?.contentViewController = popoverViewController;
			self.colorAdjustmentPopovers[x]?.animates = true
			self.colorAdjustmentPopovers[x]?.appearance = NSAppearance.init(named: NSAppearance.Name.vibrantLight)
			self.colorAdjustmentPopovers[x]?.behavior = NSPopover.Behavior.transient
			self.colorAdjustmentPopovers[x]?.delegate = self
			(self.colorAdjustmentPopovers[x]?.contentViewController as? PopoverViewController)?.windowController = self
		}
	}
	
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  geometry adjustment
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	@IBOutlet var geometryAdjustmentView: NSView!
	@IBOutlet weak var cropButton: NSButton!
	@IBAction func crop(_ sender: NSButton) {
		if let view = window?.contentView?.subviews.first as? NSScrollView {
			(view.documentView?.subviews.first as? CustomImageView)?.windowController = self
		}
	}
	
	
	func updateCrop(with rectangle: CGRect) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CICrop", withInputParameters: ["inputRectangle": CIVector(cgRect: rectangle)])
			//}
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	//  color effect filter and toolbar item
	//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	
	@IBOutlet var colorEffectFilterView: NSView!
	@IBOutlet weak var colorEffectFilterPopUpButton: NSPopUpButton!
	var colorEffectPopovers: [NSPopover?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
	var colorEffectPopoverControllerNames: [String] = ["", "ColorCrossPolynomialPopoverViewController", "ColorCubePopoverViewController", "ColorCubeWithColorSpacePopoverViewController", "ColorInvertPopoverViewController", "ColorMapPopoverViewController", "ColorMonochromePopoverViewController", "ColorPosterizePopoverViewController", "FalseColorPopoverViewController", "MaskToAlphaPopoverViewController", "MaximumComponentPopoverViewController", "MinimumComponentPopoverViewController", "PhotoEffectChromePopoverViewController", "PhotoEffectFadePopoverViewController", "PhotoEffectInstantPopoverViewController", "PhotoEffectMonoPopoverViewController", "PhotoEffectNoirPopoverViewController", "PhotoEffectProcessPopoverViewController", "PhotoEffectTonalPopoverViewController", "PhotoEffectTransferPopoverViewController", "SepiaTonePopoverViewController", "VignettePopoverViewController", "VignetteEffectPopoverViewController"]
	var colorEffectPopoverControllers: [NSViewController?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
	
	// labai daug funkciju
	
	func updateInvertColors() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIColorInvert", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateMaskToAlpha() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIMaskToAlpha", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateMaximumComponent() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIMaximumComponent", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updateMinimumComponent() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIMinimumComponent", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updatePhotoEffectChrome() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIPhotoEffectChrome", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updatePhotoEffectFade() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIPhotoEffectFade", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updatePhotoEffectInstant() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIPhotoEffectInstant", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updatePhotoEffectMono() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIPhotoEffectMono", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updatePhotoEffectNoir() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIPhotoEffectNoir", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updatePhotoEffectProcess() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIPhotoEffectProcess", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updatePhotoEffectTonal() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIPhotoEffectTonal", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	func updatePhotoEffectTransfer() {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView,
			let image = originalImage {
			let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
			let ciImage = CIImage(cgImage: cgImage)
			let ciContext = CIContext()
			let filteredImage = ciImage.applyingFilter("CIPhotoEffectTransfer", withInputParameters: [:])
			imageView.image = NSImage(cgImage: ciContext.createCGImage(filteredImage, from: ciImage.extent)!, size: image.size)
		}
	}
	
	
	
	
	
	
	@IBAction func showColorEffectPopoverAction(_ sender: NSButton) {
		if colorEffectFilterPopUpButton.indexOfSelectedItem != 0
		{
			self.createColorEffectPopover(popoverViewController: self.colorEffectPopoverControllers[colorEffectFilterPopUpButton.indexOfSelectedItem]!, x: colorEffectFilterPopUpButton.indexOfSelectedItem)
			let targetButton: NSButton = sender
			let prefEdge: NSRectEdge = NSRectEdge.maxY
			self.colorEffectPopovers[colorEffectFilterPopUpButton.indexOfSelectedItem]?.show(relativeTo: targetButton.bounds, of: sender as NSView, preferredEdge: prefEdge)
		}
	}
	
	func createColorEffectPopover(popoverViewController: NSViewController, x: Int) {
		if (self.colorEffectPopovers[x] == nil)
		{
			self.colorEffectPopovers[x] = NSPopover.init()
			self.colorEffectPopovers[x]?.contentViewController = popoverViewController;
			self.colorEffectPopovers[x]?.animates = true
			self.colorEffectPopovers[x]?.appearance = NSAppearance.init(named: NSAppearance.Name.vibrantLight)
			self.colorEffectPopovers[x]?.behavior = NSPopover.Behavior.transient
			self.colorEffectPopovers[x]?.delegate = self
			(self.colorEffectPopovers[x]?.contentViewController as? PopoverViewController)?.windowController = self
		}
	}
	
	@IBAction func applyFilter(_ sender: Any) {
		if let view = window?.contentView?.subviews.first as? NSScrollView,
			let imageView = view.documentView?.subviews.first as? CustomImageView {
			originalImage = imageView.image
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
		
		for x in 1...13 {
			colorAdjustmentPopoverControllers[x] = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: colorAdjustmentPopoverControllerNames[x] )) as? NSViewController
		}
		
		for x in 1...22 {
			colorEffectPopoverControllers[x] = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: colorEffectPopoverControllerNames[x] )) as? NSViewController
		}
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
		
		let menuItem: NSMenuItem = NSMenuItem()
		menuItem.submenu = menu
		menuItem.title = label
		toolbarItem.menuFormRepresentation = menuItem
		
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
		} else if (itemIdentifier == ((colorAdjustmentFilterToolbarItemID as NSString) as NSToolbarItem.Identifier)) {
			// 4) Color effect filter toolbar item.
			toolbarItem = customToolbarItem(itemForItemIdentifier: colorAdjustmentFilterToolbarItemID, label: "Color Adjustment Filter", paletteLabel:"Color Adjustment Filter", toolTip: "Apply color adjustment filter to the image", target: self, itemContent: self.colorAdjustmentFilterView, action: nil, menu: nil)!
		} else if (itemIdentifier == ((geometryAdjustToolbarItemID as NSString) as NSToolbarItem.Identifier)) {
			// 5) Geometry adjustment toolbar item.
			toolbarItem = customToolbarItem(itemForItemIdentifier: geometryAdjustToolbarItemID, label: "Geometry Adjustment", paletteLabel:"Geometry Adjustment", toolTip: "Adjust the geometry of the image", target: self, itemContent: self.geometryAdjustmentView, action: nil, menu: nil)!
		}
		
		return toolbarItem
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return [NSToolbarItem.Identifier(rawValue: ZoomToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: geometryAdjustToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: blurFilterToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: colorAdjustmentFilterToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: colorEffectFilterToolbarItemID)]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return [NSToolbarItem.Identifier(rawValue: ZoomToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: geometryAdjustToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: blurFilterToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: colorAdjustmentFilterToolbarItemID),
		        NSToolbarItem.Identifier(rawValue: colorEffectFilterToolbarItemID),
		        NSToolbarItem.Identifier.space,
		        NSToolbarItem.Identifier.flexibleSpace,
		        NSToolbarItem.Identifier.showColors]
	}
	
	func popoverShouldDetach(_ popover: NSPopover) -> Bool {
		return true
	}
	
}
