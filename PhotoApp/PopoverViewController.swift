//
//  PopoverViewController.swift
//  PhotoApp
//
//  Created by Pixelmator on 7/19/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController {
    
    weak var windowController: WindowController? = nil
    var image: NSImage?
    
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    // blur filters
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // box blur filter
    
    var boxBlurValue: Double = 0.0 {
        didSet { windowController?.updateBoxBlur(with: boxBlurValue) }
    }
    
    @IBOutlet weak var boxBlurSlider: NSSlider!
    @IBAction func getBoxBlur(_ sender: NSSlider) {
        boxBlurTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.boxBlurValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var boxBlurTextField: NSTextField!
    @IBAction func getBoxBlurT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < boxBlurSlider.minValue {
                boxBlurSlider.doubleValue = boxBlurSlider.minValue
            } else if Double(sender.stringValue)! > boxBlurSlider.maxValue {
                boxBlurSlider.doubleValue = boxBlurSlider.maxValue
            } else {
                boxBlurSlider.doubleValue = Double(sender.stringValue)!
            }
            self.boxBlurValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // disc blur filter
    
    var discBlurValue: Double = 0.0 {
        didSet { windowController?.updateDiscBlur(with: discBlurValue) }
    }
    
    @IBOutlet weak var discBlurSlider: NSSlider!
    @IBAction func getDiscBlur(_ sender: NSSlider) {
        discBlurTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.discBlurValue = Double(sender.floatValue.roundTo(places: 2))
    }
    @IBOutlet weak var discBlurTextField: NSTextField!
    @IBAction func getDiscBlurT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < discBlurSlider.minValue {
                discBlurSlider.doubleValue = discBlurSlider.minValue
            } else if Double(sender.stringValue)! > discBlurSlider.maxValue {
                discBlurSlider.doubleValue = discBlurSlider.maxValue
            } else {
                discBlurSlider.doubleValue = Double(sender.stringValue)!
            }
            self.discBlurValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //gaussian blur filter
    
    var gaussianBlurValue: Double = 0.0 {
        didSet { windowController?.updateGaussianBlur(with: gaussianBlurValue) }
    }
    
    @IBOutlet weak var gaussianBlurSlider: NSSlider!
    @IBAction func getGaussianBlur(_ sender: NSSlider) {
        gaussianBlurTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.gaussianBlurValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var gaussianBlurTextField: NSTextField!
    @IBAction func getGaussianBlurT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < gaussianBlurSlider.minValue {
                gaussianBlurSlider.doubleValue = gaussianBlurSlider.minValue
            } else if Double(sender.stringValue)! > gaussianBlurSlider.maxValue {
                gaussianBlurSlider.doubleValue = gaussianBlurSlider.maxValue
            } else {
                gaussianBlurSlider.doubleValue = Double(sender.stringValue)!
            }
            self.gaussianBlurValue = Double(sender.stringValue)!
        }
    }
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //median filter
    
    @IBAction func showMedianFilter(_ sender: NSButton) {
        windowController?.updateMedianFilter()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // motion blur filter
    
    var motionAmountValue: Double = 0.0 {
        didSet { windowController?.updateMotionBlur(with: motionAmountValue, motionAngle: motionAngleValue) }
    }
    var motionAngleValue: Double = 0.0 {
        didSet { windowController?.updateMotionBlur(with: motionAmountValue, motionAngle: motionAngleValue) }
    }
    
    @IBOutlet weak var motionBlurAngleSlider: NSSlider!
    @IBOutlet weak var motionBlurAmountSlider: NSSlider!
    @IBAction func getMotionBlurAngle(_ sender: NSSlider) {
        motionBlurAngleTextField.stringValue = String((sender.doubleValue * 57.2957795131).roundTo(places: 2))
        self.motionAngleValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getMotionBlurAmount(_ sender: NSSlider) {
        motionBlurAmountTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.motionAmountValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var motionBlurAngleTextField: NSTextField!
    @IBOutlet weak var motionBlurAmountTextField: NSTextField!
    @IBAction func getMotionBlurAngleT(_ sender: NSTextField) {
        motionBlurAngleSlider.doubleValue = (Double(sender.stringValue)! / 57.2957795131)
        self.motionAngleValue = Double(sender.stringValue)!
    }
    @IBAction func getMotionBlurAmountT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < motionBlurAmountSlider.minValue {
                motionBlurAmountSlider.doubleValue = motionBlurAmountSlider.minValue
            } else if Double(sender.stringValue)! > motionBlurAmountSlider.maxValue {
                motionBlurAmountSlider.doubleValue = motionBlurAmountSlider.maxValue
            } else {
                motionBlurAmountSlider.doubleValue = Double(sender.stringValue)!
            }
            self.motionAmountValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // noise reduction filter
    
    var noiseLevelValue: Double = 0.0 {
        didSet { windowController?.updateNoiseReduction(with: noiseLevelValue, sharpness: noiseSharpnessValue) }
    }
    var noiseSharpnessValue: Double = 0.0 {
        didSet { windowController?.updateNoiseReduction(with: noiseLevelValue, sharpness: noiseSharpnessValue) }
    }
    
    @IBOutlet weak var noiseLevelSlider: NSSlider!
    @IBOutlet weak var noiseSharpnessSlider: NSSlider!
    @IBAction func getNoiseLevel(_ sender: NSSlider) {
        noiseLevelTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.noiseLevelValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getNoiseSharpness(_ sender: NSSlider) {
        noiseSharpnessTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.noiseSharpnessValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var noiseLevelTextField: NSTextField!
    @IBOutlet weak var noiseSharpnessTextField: NSTextField!
    @IBAction func getNoiseLevelT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < noiseLevelSlider.minValue {
                noiseLevelSlider.doubleValue = noiseLevelSlider.minValue
            } else if Double(sender.stringValue)! > noiseLevelSlider.maxValue {
                noiseLevelSlider.doubleValue = noiseLevelSlider.maxValue
            } else {
                noiseLevelSlider.doubleValue = Double(sender.stringValue)!
            }
            self.noiseLevelValue = Double(sender.stringValue)!
        }    }
    @IBAction func getNoiseSharpnessT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < noiseSharpnessSlider.minValue {
                noiseSharpnessSlider.doubleValue = noiseSharpnessSlider.minValue
            } else if Double(sender.stringValue)! > noiseSharpnessSlider.maxValue {
                noiseSharpnessSlider.doubleValue = noiseSharpnessSlider.maxValue
            } else {
                noiseSharpnessSlider.doubleValue = Double(sender.stringValue)!
            }
            self.noiseSharpnessValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // zoom blur filter
    
    var xZoomValue: CGFloat = 0.0 {
        didSet { windowController?.updateZoomBlur(with: zoomAmountValue, center: CIVector(x: xZoomValue, y: yZoomValue)) }
    }
    var yZoomValue: CGFloat = 0.0 {
        didSet { windowController?.updateZoomBlur(with: zoomAmountValue, center: CIVector(x: xZoomValue, y: yZoomValue)) }
    }
    var zoomAmountValue: Double = 0.0 {
        didSet { windowController?.updateZoomBlur(with: zoomAmountValue, center: CIVector(x: xZoomValue, y: yZoomValue)) }
    }
    
    @IBOutlet weak var centerXZoomSlider: NSSlider!
    @IBOutlet weak var centerYZoomSlider: NSSlider!
    @IBOutlet weak var zoomAmountSlider: NSSlider!
    @IBAction func getXZoomValue(_ sender: NSSlider) {
        xZoomValueTextField.stringValue = String(sender.integerValue)
        self.xZoomValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYZoomValue(_ sender: NSSlider) {
        yZoomValueTextField.stringValue = String(sender.integerValue)
        self.yZoomValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getZoomAmount(_ sender: NSSlider) {
        zoomAmountTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.zoomAmountValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xZoomValueTextField: NSTextField!
    @IBOutlet weak var yZoomValueTextField: NSTextField!
    @IBOutlet weak var zoomAmountTextField: NSTextField!
    @IBAction func getXZoomValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < centerXZoomSlider.minValue {
                centerXZoomSlider.doubleValue = centerXZoomSlider.minValue
            } else if Double(sender.stringValue)! > centerXZoomSlider.maxValue {
                centerXZoomSlider.doubleValue = centerXZoomSlider.maxValue
            } else {
                centerXZoomSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xZoomValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYZoomValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < centerYZoomSlider.minValue {
                centerYZoomSlider.doubleValue = centerYZoomSlider.minValue
            } else if Double(sender.stringValue)! > centerYZoomSlider.maxValue {
                centerYZoomSlider.doubleValue = centerYZoomSlider.maxValue
            } else {
                centerYZoomSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yZoomValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getZoomAmountT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < zoomAmountSlider.minValue {
                zoomAmountSlider.doubleValue = zoomAmountSlider.minValue
            } else if Double(sender.stringValue)! > zoomAmountSlider.maxValue {
                zoomAmountSlider.doubleValue = zoomAmountSlider.maxValue
            } else {
                zoomAmountSlider.doubleValue = Double(sender.stringValue)!
            }
            self.zoomAmountValue = Double(sender.stringValue)!
        }
    }
    
    
    
    
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    // color adjustment filters
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // color control filter
    
    var saturationValue: Double = 1.0 {
        didSet { windowController?.updateColorControls(with: saturationValue, brightness: brightnessValue, contrast: contrastValue) }
    }
    var brightnessValue: Double = 0.0 {
        didSet { windowController?.updateColorControls(with: saturationValue, brightness: brightnessValue, contrast: contrastValue) }
    }
    var contrastValue: Double = 1.0 {
        didSet { windowController?.updateColorControls(with: saturationValue, brightness: brightnessValue, contrast: contrastValue) }
    }
    
    @IBOutlet weak var saturationSlider: NSSlider!
    @IBOutlet weak var brightnessSlider: NSSlider!
    @IBOutlet weak var contrastSlider: NSSlider!
    @IBAction func getSaturation(_ sender: NSSlider) {
        saturationTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.saturationValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getBrightness(_ sender: NSSlider) {
        brightnessTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.brightnessValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getContrast(_ sender: NSSlider) {
        contrastTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.contrastValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var saturationTextField: NSTextField!
    @IBOutlet weak var brightnessTextField: NSTextField!
    @IBOutlet weak var contrastTextField: NSTextField!
    @IBAction func getSaturationT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < saturationSlider.minValue {
                saturationSlider.doubleValue = saturationSlider.minValue
            } else if Double(sender.stringValue)! > saturationSlider.maxValue {
                saturationSlider.doubleValue = saturationSlider.maxValue
            } else {
                saturationSlider.doubleValue = Double(sender.stringValue)!
            }
            self.saturationValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getBrightnessT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < brightnessSlider.minValue {
                brightnessSlider.doubleValue = brightnessSlider.minValue
            } else if Double(sender.stringValue)! > brightnessSlider.maxValue {
                brightnessSlider.doubleValue = brightnessSlider.maxValue
            } else {
                brightnessSlider.doubleValue = Double(sender.stringValue)!
            }
            self.brightnessValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getContrastT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < contrastSlider.minValue {
                contrastSlider.doubleValue = contrastSlider.minValue
            } else if Double(sender.stringValue)! > contrastSlider.maxValue {
                contrastSlider.doubleValue = contrastSlider.maxValue
            } else {
                contrastSlider.doubleValue = Double(sender.stringValue)!
            }
            self.contrastValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // exposure adjustment
    
    var exposureValue: Double = 0.0 {
        didSet { windowController?.updateExposureAdjust(with: exposureValue) }
    }
    
    @IBOutlet weak var exposureSlider: NSSlider!
    @IBAction func getExposureValue(_ sender: NSSlider) {
        exposureTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.exposureValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var exposureTextField: NSTextField!
    @IBAction func getExposureValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < exposureSlider.minValue {
                exposureSlider.doubleValue = exposureSlider.minValue
            } else if Double(sender.stringValue)! > exposureSlider.maxValue {
                exposureSlider.doubleValue = exposureSlider.maxValue
            } else {
                exposureSlider.doubleValue = Double(sender.stringValue)!
            }
            self.exposureValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // gamma adjustment
    
    var gammaValue: Double = 0.0 {
        didSet { windowController?.updateGammaAdjust(with: gammaValue) }
    }
    
    @IBOutlet weak var gammaSlider: NSSlider!
    @IBAction func getGammaValue(_ sender: NSSlider) {
        gammaTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.gammaValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var gammaTextField: NSTextField!
    @IBAction func getGammaValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < gammaSlider.minValue {
                gammaSlider.doubleValue = gammaSlider.minValue
            } else if Double(sender.stringValue)! > gammaSlider.maxValue {
                gammaSlider.doubleValue = gammaSlider.maxValue
            } else {
                gammaSlider.doubleValue = Double(sender.stringValue)!
            }
            self.gammaValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // hue adjustment
    
    var hueValue: Double = 0.0 {
        didSet { windowController?.updateHueAdjust(with: hueValue) }
    }
    
    @IBOutlet weak var hueSlider: NSSlider!
    @IBAction func getHueValue(_ sender: NSSlider) {
        hueTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.hueValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var hueTextField: NSTextField!
    @IBAction func getHueValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < hueSlider.minValue {
                hueSlider.doubleValue = hueSlider.minValue
            } else if Double(sender.stringValue)! > hueSlider.maxValue {
                hueSlider.doubleValue = hueSlider.maxValue
            } else {
                hueSlider.doubleValue = Double(sender.stringValue)!
            }
            self.hueValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //linear to sRGB tone curve filter
    
    @IBAction func showLinearToSRGBFilter(_ sender: NSButton) {
        windowController?.updateLinearToSRGBFilter()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //sRGB tone curve to linear filter
    
    @IBAction func showSRGBToLinearFilter(_ sender: NSButton) {
        windowController?.updateSRGBToLinearFilter()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //vibrance filter
    
    var vibranceValue: Double = 0.0 {
        didSet { windowController?.updateVibranceAdjust(with: vibranceValue) }
    }
    
    @IBOutlet weak var vibranceSlider: NSSlider!
    @IBAction func getVibranceValue(_ sender: NSSlider) {
        vibranceTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.vibranceValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var vibranceTextField: NSTextField!
    @IBAction func getVibranceValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < vibranceSlider.minValue {
                vibranceSlider.doubleValue = vibranceSlider.minValue
            } else if Double(sender.stringValue)! > vibranceSlider.maxValue {
                vibranceSlider.doubleValue = vibranceSlider.maxValue
            } else {
                vibranceSlider.doubleValue = Double(sender.stringValue)!
            }
            self.vibranceValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //white point adjust
    
    var whitePointRedValue: Float = 255.0 {
        didSet { windowController?.updateWhitePointAdjust(with: CIColor(red: CGFloat(whitePointRedValue), green: CGFloat(whitePointGreenValue), blue: CGFloat(whitePointBlueValue)))
            whitePointColorField.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(whitePointRedValue), green: CGFloat(whitePointGreenValue), blue: CGFloat(whitePointBlueValue))) }
    }
    var whitePointGreenValue: Float = 255.0 {
        didSet { windowController?.updateWhitePointAdjust(with: CIColor(red: CGFloat(whitePointRedValue), green: CGFloat(whitePointGreenValue), blue: CGFloat(whitePointBlueValue)))
            whitePointColorField.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(whitePointRedValue), green: CGFloat(whitePointGreenValue), blue: CGFloat(whitePointBlueValue))) }
    }
    var whitePointBlueValue: Float = 255.0 {
        didSet { windowController?.updateWhitePointAdjust(with: CIColor(red: CGFloat(whitePointRedValue), green: CGFloat(whitePointGreenValue), blue: CGFloat(whitePointBlueValue)))
            whitePointColorField.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(whitePointRedValue), green: CGFloat(whitePointGreenValue), blue: CGFloat(whitePointBlueValue))) }
    }
    
    @IBOutlet weak var whitePointRedSlider: NSSlider!
    @IBOutlet weak var whitePointGreenSlider: NSSlider!
    @IBOutlet weak var whitePointBlueSlider: NSSlider!
    @IBAction func getwhitePointRedValue(_ sender: NSSlider) {
        whitePointRedTextField.stringValue = String(sender.integerValue)
        self.whitePointRedValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getwhitePointGreenValue(_ sender: NSSlider) {
        whitePointGreenTextField.stringValue = String(sender.integerValue)
        self.whitePointGreenValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getwhitePointBlueValue(_ sender: NSSlider) {
        whitePointBlueTextField.stringValue = String(sender.integerValue)
        self.whitePointBlueValue = sender.floatValue.roundTo(places: 2) / 256
    }
    
    @IBOutlet weak var whitePointRedTextField: NSTextField!
    @IBOutlet weak var whitePointGreenTextField: NSTextField!
    @IBOutlet weak var whitePointBlueTextField: NSTextField!
    @IBOutlet weak var whitePointColorField: NSTextField!
    @IBAction func getwhitePointRedValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < whitePointRedSlider.minValue {
                whitePointRedSlider.doubleValue = whitePointRedSlider.minValue
            } else if Double(sender.stringValue)! > whitePointRedSlider.maxValue {
                whitePointRedSlider.doubleValue = whitePointRedSlider.maxValue
            } else {
                whitePointRedSlider.doubleValue = Double(sender.stringValue)!
            }
            self.whitePointRedValue = Float(sender.stringValue)! / 256
        }
    }
    @IBAction func getwhitePointGreenValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < whitePointGreenSlider.minValue {
                whitePointGreenSlider.doubleValue = whitePointGreenSlider.minValue
            } else if Double(sender.stringValue)! > whitePointGreenSlider.maxValue {
                whitePointGreenSlider.doubleValue = whitePointGreenSlider.maxValue
            } else {
                whitePointGreenSlider.doubleValue = Double(sender.stringValue)!
            }
            self.whitePointGreenValue = Float(sender.stringValue)!  / 256
        }
    }
    @IBAction func getwhitePointBlueValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < whitePointBlueSlider.minValue {
                whitePointBlueSlider.doubleValue = whitePointBlueSlider.minValue
            } else if Double(sender.stringValue)! > whitePointBlueSlider.maxValue {
                whitePointBlueSlider.doubleValue = whitePointBlueSlider.maxValue
            } else {
                whitePointBlueSlider.doubleValue = Double(sender.stringValue)!
            }
            self.whitePointBlueValue = Float(sender.stringValue)!  / 256
        }
    }
    
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    // color effect filters
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //color invert
    
    @IBAction func invertColor(_ sender: NSButton) {
        windowController?.updateInvertColors()
    }
    
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //color monochrome
    
    var monochromeRedValue: Float = 255.0 {
        didSet { windowController?.updateMonochromeAdjust(with: CIColor(red: CGFloat(monochromeRedValue), green: CGFloat(monochromeGreenValue), blue: CGFloat(monochromeBlueValue)), intensity: monochromeIntensity)
            monochromeColorField.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(monochromeRedValue), green: CGFloat(monochromeGreenValue), blue: CGFloat(monochromeBlueValue))) }
    }
    var monochromeGreenValue: Float = 255.0 {
        didSet { windowController?.updateMonochromeAdjust(with: CIColor(red: CGFloat(monochromeRedValue), green: CGFloat(monochromeGreenValue), blue: CGFloat(monochromeBlueValue)), intensity: monochromeIntensity)
            monochromeColorField.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(monochromeRedValue), green: CGFloat(monochromeGreenValue), blue: CGFloat(monochromeBlueValue))) }
    }
    var monochromeBlueValue: Float = 255.0 {
        didSet { windowController?.updateMonochromeAdjust(with: CIColor(red: CGFloat(monochromeRedValue), green: CGFloat(monochromeGreenValue), blue: CGFloat(monochromeBlueValue)), intensity: monochromeIntensity)
            monochromeColorField.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(monochromeRedValue), green: CGFloat(monochromeGreenValue), blue: CGFloat(monochromeBlueValue))) }
    }
    var monochromeIntensity: Double = 0.0 {
        didSet { windowController?.updateMonochromeAdjust(with: CIColor(red: CGFloat(monochromeRedValue), green: CGFloat(monochromeGreenValue), blue: CGFloat(monochromeBlueValue)), intensity: monochromeIntensity)
            monochromeColorField.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(monochromeRedValue), green: CGFloat(monochromeGreenValue), blue: CGFloat(monochromeBlueValue)))
        }
    }
    
    @IBOutlet weak var monochromeRedSlider: NSSlider!
    @IBOutlet weak var monochromeGreenSlider: NSSlider!
    @IBOutlet weak var monochromeBlueSlider: NSSlider!
    @IBOutlet weak var monochromeIntensitySlider: NSSlider!
    @IBAction func getMonochromeRedValue(_ sender: NSSlider) {
        monochromeRedTextField.stringValue = String(sender.integerValue)
        self.monochromeRedValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getMonochromeGreenValue(_ sender: NSSlider) {
        monochromeGreenTextField.stringValue = String(sender.integerValue)
        self.monochromeGreenValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getMonochromeBlueValue(_ sender: NSSlider) {
        monochromeBlueTextField.stringValue = String(sender.integerValue)
        self.monochromeBlueValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getMonochromeIntensity(_ sender: NSSlider) {
        monochromeIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.monochromeIntensity = sender.doubleValue
    }
    
    @IBOutlet weak var monochromeRedTextField: NSTextField!
    @IBOutlet weak var monochromeGreenTextField: NSTextField!
    @IBOutlet weak var monochromeBlueTextField: NSTextField!
    @IBOutlet weak var monochromeColorField: NSTextField!
    @IBOutlet weak var monochromeIntensityTextField: NSTextField!
    @IBAction func getMonochromeRedValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < monochromeRedSlider.minValue {
                monochromeRedSlider.doubleValue = monochromeRedSlider.minValue
            } else if Double(sender.stringValue)! > monochromeRedSlider.maxValue {
                monochromeRedSlider.doubleValue = monochromeRedSlider.maxValue
            } else {
                monochromeRedSlider.doubleValue = Double(sender.stringValue)!
            }
            self.monochromeRedValue = Float(sender.stringValue)! / 256
        }
    }
    @IBAction func getMonochromeGreenValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < monochromeGreenSlider.minValue {
                monochromeGreenSlider.doubleValue = monochromeGreenSlider.minValue
            } else if Double(sender.stringValue)! > monochromeGreenSlider.maxValue {
                monochromeGreenSlider.doubleValue = monochromeGreenSlider.maxValue
            } else {
                monochromeGreenSlider.doubleValue = Double(sender.stringValue)!
            }
            self.monochromeGreenValue = Float(sender.stringValue)!  / 256
        }
    }
    @IBAction func getMonochromeBlueValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < monochromeBlueSlider.minValue {
                monochromeBlueSlider.doubleValue = monochromeBlueSlider.minValue
            } else if Double(sender.stringValue)! > monochromeBlueSlider.maxValue {
                monochromeBlueSlider.doubleValue = monochromeBlueSlider.maxValue
            } else {
                monochromeBlueSlider.doubleValue = Double(sender.stringValue)!
            }
            self.monochromeBlueValue = Float(sender.stringValue)!  / 256
        }
    }
    @IBAction func getMonochromeIntensityT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < monochromeIntensitySlider.minValue {
                monochromeIntensitySlider.doubleValue = monochromeIntensitySlider.minValue
            } else if Double(sender.stringValue)! > monochromeIntensitySlider.maxValue {
                monochromeIntensitySlider.doubleValue = monochromeIntensitySlider.maxValue
            } else {
                monochromeIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.monochromeIntensity = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //color posterize
    
    var posterizeLevelValue: Double = 2.0 {
        didSet { windowController?.updatePosterize(with: posterizeLevelValue) }
    }
    
    @IBOutlet weak var posterizeLevelSlider: NSSlider!
    @IBAction func getposterizeLevelValue(_ sender: NSSlider) {
        posterizeLevelTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.posterizeLevelValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var posterizeLevelTextField: NSTextField!
    @IBAction func getPosterizeLevelValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < posterizeLevelSlider.minValue {
                posterizeLevelSlider.doubleValue = posterizeLevelSlider.minValue
            } else if Double(sender.stringValue)! > posterizeLevelSlider.maxValue {
                posterizeLevelSlider.doubleValue = posterizeLevelSlider.maxValue
            } else {
                posterizeLevelSlider.doubleValue = Double(sender.stringValue)!
            }
            self.posterizeLevelValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //mask to alpha
    
    @IBAction func showMaskToAlpha(_ sender: NSButton) {
        windowController?.updateMaskToAlpha()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //maximum component
    
    @IBAction func showMaximumComponent(_ sender: NSButton) {
        windowController?.updateMaximumComponent()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //minimum component
    
    @IBAction func showMinimumComponent(_ sender: NSButton) {
        windowController?.updateMinimumComponent()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //photo effect chrome
    
    @IBAction func showPhotoEffectChrome(_ sender: NSButton) {
        windowController?.updatePhotoEffectChrome()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //photo effect fade
    
    @IBAction func showPhotoEffectFade(_ sender: NSButton) {
        windowController?.updatePhotoEffectFade()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //photo effect instant
    
    @IBAction func showPhotoEffectInstant(_ sender: NSButton) {
        windowController?.updatePhotoEffectInstant()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //photo effect mono
    
    @IBAction func showPhotoEffectMono(_ sender: NSButton) {
        windowController?.updatePhotoEffectMono()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //photo effect noir
    
    @IBAction func showPhotoEffectNoir(_ sender: NSButton) {
        windowController?.updatePhotoEffectNoir()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //photo effect process
    
    @IBAction func showPhotoEffectProcess(_ sender: NSButton) {
        windowController?.updatePhotoEffectProcess()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //photo effect tonal
    
    @IBAction func showPhotoEffectTonal(_ sender: NSButton) {
        windowController?.updatePhotoEffectTonal()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //photo effect transfer
    
    @IBAction func showPhotoEffectTransfer(_ sender: NSButton) {
        windowController?.updatePhotoEffectTransfer()
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //sepia tone intensity
    
    var sepiaToneIntensityValue: Double = 0.0 {
        didSet { windowController?.updateSepiaTone(with: sepiaToneIntensityValue) }
    }
    
    @IBOutlet weak var sepiaToneIntensitySlider: NSSlider!
    @IBAction func getSepiaToneIntensityValue(_ sender: NSSlider) {
        sepiaToneIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.sepiaToneIntensityValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var sepiaToneIntensityTextField: NSTextField!
    @IBAction func getSepiaToneIntensityValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < sepiaToneIntensitySlider.minValue {
                sepiaToneIntensitySlider.doubleValue = sepiaToneIntensitySlider.minValue
            } else if Double(sender.stringValue)! > sepiaToneIntensitySlider.maxValue {
                sepiaToneIntensitySlider.doubleValue = sepiaToneIntensitySlider.maxValue
            } else {
                sepiaToneIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.sepiaToneIntensityValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // vignette filter
    
    var vignetteIntensityValue: Double = 0.0 {
        didSet { windowController?.updateVignette(with: vignetteRadiusValue, intensity: vignetteIntensityValue) }
    }
    var vignetteRadiusValue: Double = 0.0 {
        didSet { windowController?.updateVignette(with: vignetteRadiusValue, intensity: vignetteIntensityValue) }
    }
    
    @IBOutlet weak var vignetteIntensitySlider: NSSlider!
    @IBOutlet weak var vignetteRadiusSlider: NSSlider!
    @IBAction func getVignetteIntensity(_ sender: NSSlider) {
        vignetteIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.vignetteIntensityValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getVignetteRadius(_ sender: NSSlider) {
        vignetteRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.vignetteRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var vignetteIntensityTextField: NSTextField!
    @IBOutlet weak var vignetteRadiusTextField: NSTextField!
    @IBAction func getVignetteIntensityT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < vignetteIntensitySlider.minValue {
                vignetteIntensitySlider.doubleValue = vignetteIntensitySlider.minValue
            } else if Double(sender.stringValue)! > vignetteIntensitySlider.maxValue {
                vignetteIntensitySlider.doubleValue = vignetteIntensitySlider.maxValue
            } else {
                vignetteIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.vignetteIntensityValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getVignetteRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < vignetteRadiusSlider.minValue {
                vignetteRadiusSlider.doubleValue = vignetteRadiusSlider.minValue
            } else if Double(sender.stringValue)! > vignetteRadiusSlider.maxValue {
                vignetteRadiusSlider.doubleValue = vignetteRadiusSlider.maxValue
            } else {
                vignetteRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.vignetteRadiusValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // vignette effect filter
    
    var xVignetteValue: CGFloat = 0.0 {
        didSet { windowController?.updateVignetteEffect(with: vignetteEffectRadiusValue, intensity: vignetteEffectIntensityValue, center: CIVector(x: xVignetteValue, y: yVignetteValue)) }
    }
    var yVignetteValue: CGFloat = 0.0 {
        didSet { windowController?.updateVignetteEffect(with: vignetteEffectRadiusValue, intensity: vignetteEffectIntensityValue, center: CIVector(x: xVignetteValue, y: yVignetteValue)) }
    }
    var vignetteEffectIntensityValue: Double = 0.0 {
        didSet { windowController?.updateVignetteEffect(with: vignetteEffectRadiusValue, intensity: vignetteEffectIntensityValue, center: CIVector(x: xVignetteValue, y: yVignetteValue)) }
    }
    var vignetteEffectRadiusValue: Double = 0.0 {
        didSet { windowController?.updateVignetteEffect(with: vignetteEffectRadiusValue, intensity: vignetteEffectIntensityValue, center: CIVector(x: xVignetteValue, y: yVignetteValue)) }
    }
    
    @IBOutlet weak var xVignetteSlider: NSSlider!
    @IBOutlet weak var yVignetteSlider: NSSlider!
    @IBOutlet weak var vignetteEffectIntensitySlider: NSSlider!
    @IBOutlet weak var vignetteEffectRadiusSlider: NSSlider!
    @IBAction func getXVignetteEffectValue(_ sender: NSSlider) {
        xVignetteValueTextField.stringValue = String(sender.integerValue)
        self.xVignetteValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYVignetteEffectValue(_ sender: NSSlider) {
        yVignetteValueTextField.stringValue = String(sender.integerValue)
        self.yVignetteValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getVignetteEffectIntensity(_ sender: NSSlider) {
        vignetteEffectIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.vignetteEffectIntensityValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getVignetteEffectRadius(_ sender: NSSlider) {
        vignetteEffectRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.vignetteEffectRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xVignetteValueTextField: NSTextField!
    @IBOutlet weak var yVignetteValueTextField: NSTextField!
    @IBOutlet weak var vignetteEffectIntensityTextField: NSTextField!
    @IBOutlet weak var vignetteEffectRadiusTextField: NSTextField!
    @IBAction func getXVignetteEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xVignetteSlider.minValue {
                xVignetteSlider.doubleValue = xVignetteSlider.minValue
            } else if Double(sender.stringValue)! > xVignetteSlider.maxValue {
                xVignetteSlider.doubleValue = xVignetteSlider.maxValue
            } else {
                xVignetteSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xVignetteValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYVignetteEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yVignetteSlider.minValue {
                yVignetteSlider.doubleValue = yVignetteSlider.minValue
            } else if Double(sender.stringValue)! > yVignetteSlider.maxValue {
                yVignetteSlider.doubleValue = yVignetteSlider.maxValue
            } else {
                yVignetteSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yVignetteValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getVignetteEffectIntensityT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < vignetteEffectIntensitySlider.minValue {
                vignetteEffectIntensitySlider.doubleValue = vignetteEffectIntensitySlider.minValue
            } else if Double(sender.stringValue)! > vignetteEffectIntensitySlider.maxValue {
                vignetteEffectIntensitySlider.doubleValue = vignetteEffectIntensitySlider.maxValue
            } else {
                vignetteEffectIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.vignetteEffectIntensityValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getVignetteEffectRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < vignetteEffectRadiusSlider.minValue {
                vignetteEffectRadiusSlider.doubleValue = vignetteEffectRadiusSlider.minValue
            } else if Double(sender.stringValue)! > vignetteEffectRadiusSlider.maxValue {
                vignetteEffectRadiusSlider.doubleValue = vignetteEffectRadiusSlider.maxValue
            } else {
                vignetteEffectRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.vignetteEffectRadiusValue = Double(sender.stringValue)!
        }
    }
    
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    // sharpen filters
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // sharpen luminance
    
    var sharpenLuminanceValue: Double = 0.0 {
        didSet { windowController?.updateSharpenLuminance(with: sharpenLuminanceValue) }
    }
    
    @IBOutlet weak var sharpenLuminanceSlider: NSSlider!
    @IBAction func getSharpenLuminance(_ sender: NSSlider) {
        sharpenLuminanceTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.sharpenLuminanceValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var sharpenLuminanceTextField: NSTextField!
    @IBAction func getSharpenLuminanceT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < sharpenLuminanceSlider.minValue {
                sharpenLuminanceSlider.doubleValue = sharpenLuminanceSlider.minValue
            } else if Double(sender.stringValue)! > sharpenLuminanceSlider.maxValue {
                sharpenLuminanceSlider.doubleValue = sharpenLuminanceSlider.maxValue
            } else {
                sharpenLuminanceSlider.doubleValue = Double(sender.stringValue)!
            }
            self.sharpenLuminanceValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // unsharp mask
    
    var unsharpMaskIntensityValue: Double = 0.0 {
        didSet { windowController?.updateUnsharpMask(with: unsharpMaskRadiusValue, intensity: unsharpMaskIntensityValue) }
    }
    var unsharpMaskRadiusValue: Double = 0.0 {
        didSet { windowController?.updateUnsharpMask(with: unsharpMaskRadiusValue, intensity: unsharpMaskIntensityValue) }
    }
    
    @IBOutlet weak var unsharpMaskIntensitySlider: NSSlider!
    @IBOutlet weak var unsharpMaskRadiusSlider: NSSlider!
    @IBAction func getUnsharpMaskIntensity(_ sender: NSSlider) {
        unsharpMaskIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.unsharpMaskIntensityValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getUnsharpMaskRadius(_ sender: NSSlider) {
        unsharpMaskRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.unsharpMaskRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var unsharpMaskIntensityTextField: NSTextField!
    @IBOutlet weak var unsharpMaskRadiusTextField: NSTextField!
    @IBAction func getUnsharpMaskIntensityT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < unsharpMaskIntensitySlider.minValue {
                unsharpMaskIntensitySlider.doubleValue = unsharpMaskIntensitySlider.minValue
            } else if Double(sender.stringValue)! > unsharpMaskIntensitySlider.maxValue {
                unsharpMaskIntensitySlider.doubleValue = unsharpMaskIntensitySlider.maxValue
            } else {
                unsharpMaskIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.unsharpMaskIntensityValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getUnsharpMaskRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < unsharpMaskRadiusSlider.minValue {
                unsharpMaskRadiusSlider.doubleValue = unsharpMaskRadiusSlider.minValue
            } else if Double(sender.stringValue)! > unsharpMaskRadiusSlider.maxValue {
                unsharpMaskRadiusSlider.doubleValue = unsharpMaskRadiusSlider.maxValue
            } else {
                unsharpMaskRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.unsharpMaskRadiusValue = Double(sender.stringValue)!
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = windowController?.originalCIImage {
            if let centerXSlider = centerXZoomSlider,
                let centerYSlider = centerYZoomSlider {
                centerXSlider.maxValue = Double(image.extent.size.width)
                centerYSlider.maxValue = Double(image.extent.size.height)
            }
            if let xVignetteSlider = xVignetteSlider,
                let yVignetteSlider = yVignetteSlider,
                let vignetteEffectRadiusSlider = vignetteEffectRadiusSlider{
                xVignetteSlider.maxValue = Double(image.extent.size.width)
                yVignetteSlider.maxValue = Double(image.extent.size.height)
                if image.extent.size.width < image.extent.size.height {
                    vignetteEffectRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    vignetteEffectRadiusSlider.maxValue = Double(image.extent.size.width)
                }
            }
        }
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension Float {
    /// Rounds the float to decimal places value
    func roundTo(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
