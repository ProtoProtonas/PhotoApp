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
    var image: CIImage?
    
    
    
    
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    // blur filters
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // box blur filter
    
    var boxBlurValue: Double = 10.0 {
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
    
    var discBlurValue: Double = 10.0 {
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
    
    var gaussianBlurValue: Double = 10.0 {
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
        motionBlurAngleTextField.stringValue = String((sender.doubleValue).roundTo(places: 2))
        self.motionAngleValue = sender.doubleValue.roundTo(places: 2) / 57.2957795131
    }
    @IBAction func getMotionBlurAmount(_ sender: NSSlider) {
        motionBlurAmountTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.motionAmountValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var motionBlurAngleTextField: NSTextField!
    @IBOutlet weak var motionBlurAmountTextField: NSTextField!
    @IBAction func getMotionBlurAngleT(_ sender: NSTextField) {
        motionBlurAngleSlider.doubleValue = Double(sender.stringValue)!
        self.motionAngleValue = Double(sender.stringValue)! / 57.2957795131
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
    var zoomAmountValue: Double = 10.0 {
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
    
    var saturationValue: Double = 2.0 {
        didSet { windowController?.updateColorControls(with: saturationValue, brightness: brightnessValue, contrast: contrastValue) }
    }
    var brightnessValue: Double = 0.25 {
        didSet { windowController?.updateColorControls(with: saturationValue, brightness: brightnessValue, contrast: contrastValue) }
    }
    var contrastValue: Double = 1.5 {
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
    
    var exposureValue: Double = 1.0 {
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
    
    var gammaValue: Double = 0.5 {
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
    
    var hueValue: Double = 1.57079633 {
        didSet { windowController?.updateHueAdjust(with: hueValue) }
    }
    
    @IBOutlet weak var hueSlider: NSSlider!
    @IBAction func getHueValue(_ sender: NSSlider) {
        hueTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.hueValue = sender.doubleValue.roundTo(places: 2) / 57.2957795131
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
            self.hueValue = Double(sender.stringValue)! / 57.2957795131
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // temperature and tint
    
    var TnTTemperatureValue: CGFloat = 0.0 {
        didSet { windowController?.updateTemperatureAndTint(with: TnTTemperatureValue, tint: TnTTintValue) }
    }
    var TnTTintValue: CGFloat = 0.0 {
        didSet { windowController?.updateTemperatureAndTint(with: TnTTemperatureValue, tint: TnTTintValue) }
    }
    
    @IBOutlet weak var TnTTemperatureSlider: NSSlider!
    @IBOutlet weak var TnTTintSlider: NSSlider!
    @IBAction func getTnTTemperature(_ sender: NSSlider) {
        TnTTemperatureTextField.stringValue = String(sender.integerValue)
        self.TnTTemperatureValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getTnTTint(_ sender: NSSlider) {
        TnTTintTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.TnTTintValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBOutlet weak var TnTTemperatureTextField: NSTextField!
    @IBOutlet weak var TnTTintTextField: NSTextField!
    @IBAction func getTnTTemperatureT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < TnTTemperatureSlider.minValue {
                TnTTemperatureSlider.doubleValue = TnTTemperatureSlider.minValue
            } else if Double(sender.stringValue)! > TnTTemperatureSlider.maxValue {
                TnTTemperatureSlider.doubleValue = TnTTemperatureSlider.maxValue
            } else {
                TnTTemperatureSlider.doubleValue = Double(sender.stringValue)!
            }
            self.TnTTemperatureValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getTnTTintT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < TnTTintSlider.minValue {
                TnTTintSlider.doubleValue = TnTTintSlider.minValue
            } else if Double(sender.stringValue)! > TnTTintSlider.maxValue {
                TnTTintSlider.doubleValue = TnTTintSlider.maxValue
            } else {
                TnTTintSlider.doubleValue = Double(sender.stringValue)!
            }
            self.TnTTintValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    //vibrance filter
    
    var vibranceValue: Double = 0.5 {
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
    var whitePointBlueValue: Float = 200.0 {
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
    
    var monochromeRedValue: Float = 200.0 {
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
    var monochromeIntensity: Double = 1.0 {
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
    //false color
    
    var falseColor0RedValue: Float = 0.0 / 256 {
        didSet { windowController?.updateFalseColor(with: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)), color1: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
            falseColor0Field.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)))
        }
    }
    var falseColor0GreenValue: Float = 0.0 / 256 {
        didSet { windowController?.updateFalseColor(with: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)), color1: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
            falseColor0Field.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)))
        }
    }
    var falseColor0BlueValue: Float = 100.0 / 256 {
        didSet { windowController?.updateFalseColor(with: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)), color1: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
            falseColor0Field.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)))
        }
    }
    var falseColor1RedValue: Float = 255.0 / 256 {
        didSet { windowController?.updateFalseColor(with: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)), color1: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
            falseColor1Field.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
        }
    }
    var falseColor1GreenValue: Float = 200.0 / 256 {
        didSet { windowController?.updateFalseColor(with: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)), color1: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
            falseColor1Field.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
        }
    }
    var falseColor1BlueValue: Float = 255.0 / 256 {
        didSet { windowController?.updateFalseColor(with: CIColor(red: CGFloat(falseColor0RedValue), green: CGFloat(falseColor0GreenValue), blue: CGFloat(falseColor0BlueValue)), color1: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
            falseColor1Field.backgroundColor = NSColor(ciColor: CIColor(red: CGFloat(falseColor1RedValue), green: CGFloat(falseColor1GreenValue), blue: CGFloat(falseColor1BlueValue)))
        }
    }
    
    
    @IBOutlet weak var falseColor0RedSlider: NSSlider!
    @IBOutlet weak var falseColor0GreenSlider: NSSlider!
    @IBOutlet weak var falseColor0BlueSlider: NSSlider!
    @IBOutlet weak var falseColor1RedSlider: NSSlider!
    @IBOutlet weak var falseColor1GreenSlider: NSSlider!
    @IBOutlet weak var falseColor1BlueSlider: NSSlider!
    @IBAction func getFalseColor0Red(_ sender: NSSlider) {
        falseColor0RedTextField.stringValue = String(sender.integerValue)
        self.falseColor0RedValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getFalseColor0Green(_ sender: NSSlider) {
        falseColor0GreenTextField.stringValue = String(sender.integerValue)
        self.falseColor0GreenValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getFalseColor0Blue(_ sender: NSSlider) {
        falseColor0BlueTextField.stringValue = String(sender.integerValue)
        self.falseColor0BlueValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getFalseColor1Red(_ sender: NSSlider) {
        falseColor1RedTextField.stringValue = String(sender.integerValue)
        self.falseColor1RedValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getFalseColor1Green(_ sender: NSSlider) {
        falseColor1GreenTextField.stringValue = String(sender.integerValue)
        self.falseColor1GreenValue = sender.floatValue.roundTo(places: 2) / 256
    }
    @IBAction func getFalseColor1Blue(_ sender: NSSlider) {
        falseColor1BlueTextField.stringValue = String(sender.integerValue)
        self.falseColor1BlueValue = sender.floatValue.roundTo(places: 2) / 256
    }
    
    @IBOutlet weak var falseColor0RedTextField: NSTextField!
    @IBOutlet weak var falseColor0GreenTextField: NSTextField!
    @IBOutlet weak var falseColor0BlueTextField: NSTextField!
    @IBOutlet weak var falseColor0Field: NSTextField!
    @IBOutlet weak var falseColor1RedTextField: NSTextField!
    @IBOutlet weak var falseColor1GreenTextField: NSTextField!
    @IBOutlet weak var falseColor1BlueTextField: NSTextField!
    @IBOutlet weak var falseColor1Field: NSTextField!
    @IBAction func getFalseColor0RedT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < falseColor0RedSlider.minValue {
                falseColor0RedSlider.doubleValue = falseColor0RedSlider.minValue
            } else if Double(sender.stringValue)! > falseColor0RedSlider.maxValue {
                falseColor0RedSlider.doubleValue = falseColor0RedSlider.maxValue
            } else {
                falseColor0RedSlider.doubleValue = Double(sender.stringValue)!
            }
            self.falseColor0RedValue = Float(sender.stringValue)! / 256
        }
    }
    @IBAction func getFalseColor0GreenT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < falseColor0GreenSlider.minValue {
                falseColor0GreenSlider.doubleValue = falseColor0GreenSlider.minValue
            } else if Double(sender.stringValue)! > falseColor0GreenSlider.maxValue {
                falseColor0GreenSlider.doubleValue = falseColor0GreenSlider.maxValue
            } else {
                falseColor0GreenSlider.doubleValue = Double(sender.stringValue)!
            }
            self.falseColor0GreenValue = Float(sender.stringValue)! / 256
        }
    }
    @IBAction func getFalseColor0BlueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < falseColor0BlueSlider.minValue {
                falseColor0BlueSlider.doubleValue = falseColor0BlueSlider.minValue
            } else if Double(sender.stringValue)! > falseColor0BlueSlider.maxValue {
                falseColor0BlueSlider.doubleValue = falseColor0BlueSlider.maxValue
            } else {
                falseColor0BlueSlider.doubleValue = Double(sender.stringValue)!
            }
            self.falseColor0BlueValue = Float(sender.stringValue)! / 256
        }
    }
    @IBAction func getFalseColor1RedT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < falseColor1RedSlider.minValue {
                falseColor1RedSlider.doubleValue = falseColor1RedSlider.minValue
            } else if Double(sender.stringValue)! > falseColor1RedSlider.maxValue {
                falseColor1RedSlider.doubleValue = falseColor1RedSlider.maxValue
            } else {
                falseColor1RedSlider.doubleValue = Double(sender.stringValue)!
            }
            self.falseColor1RedValue = Float(sender.stringValue)! / 256
        }
    }
    @IBAction func getFalseColor1GreenT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < falseColor1GreenSlider.minValue {
                falseColor1GreenSlider.doubleValue = falseColor1GreenSlider.minValue
            } else if Double(sender.stringValue)! > falseColor1GreenSlider.maxValue {
                falseColor1GreenSlider.doubleValue = falseColor1GreenSlider.maxValue
            } else {
                falseColor1GreenSlider.doubleValue = Double(sender.stringValue)!
            }
            self.falseColor1GreenValue = Float(sender.stringValue)! / 256
        }
    }
    @IBAction func getFalseColor1BlueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < falseColor1BlueSlider.minValue {
                falseColor1BlueSlider.doubleValue = falseColor1BlueSlider.minValue
            } else if Double(sender.stringValue)! > falseColor1BlueSlider.maxValue {
                falseColor1BlueSlider.doubleValue = falseColor1BlueSlider.maxValue
            } else {
                falseColor1BlueSlider.doubleValue = Double(sender.stringValue)!
            }
            self.falseColor1BlueValue = Float(sender.stringValue)! / 256
        }
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
    var vignetteEffectIntensityValue: Double = 0.7 {
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
        vignetteEffectRadiusTextField.stringValue = String(sender.integerValue)
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
    
    var sharpenLuminanceValue: Double = 0.5 {
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
    
    var unsharpMaskIntensityValue: Double = 0.5 {
        didSet { windowController?.updateUnsharpMask(with: unsharpMaskRadiusValue, intensity: unsharpMaskIntensityValue) }
    }
    var unsharpMaskRadiusValue: Double = 0.5 {
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
    
    
    
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    // distortion filters
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // bump distortion
    
    var xBumpDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateBumpDistortion(with: xBumpDistortionValue, y: yBumpDistortionValue, radius: bumpDistortionRadiusValue, scale: bumpDistortionScaleValue) }
    }
    var yBumpDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateBumpDistortion(with: xBumpDistortionValue, y: yBumpDistortionValue, radius: bumpDistortionRadiusValue, scale: bumpDistortionScaleValue) }
    }
    var bumpDistortionRadiusValue: Double = 0.0 {
        didSet { windowController?.updateBumpDistortion(with: xBumpDistortionValue, y: yBumpDistortionValue, radius: bumpDistortionRadiusValue, scale: bumpDistortionScaleValue) }
    }
    var bumpDistortionScaleValue: Double = 2.0 {
        didSet { windowController?.updateBumpDistortion(with: xBumpDistortionValue, y: yBumpDistortionValue, radius: bumpDistortionRadiusValue, scale: bumpDistortionScaleValue) }
    }
    
    @IBOutlet weak var xBumpDistortionSlider: NSSlider!
    @IBOutlet weak var yBumpDistortionSlider: NSSlider!
    @IBOutlet weak var bumpDistortionRadiusSlider: NSSlider!
    @IBOutlet weak var bumpDistortionScaleSlider: NSSlider!
    @IBAction func getXBumpDistortionEffectValue(_ sender: NSSlider) {
        xBumpDistortionValueTextField.stringValue = String(sender.integerValue)
        self.xBumpDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYBumpDistortionEffectValue(_ sender: NSSlider) {
        yBumpDistortionValueTextField.stringValue = String(sender.integerValue)
        self.yBumpDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getBumpDistortionRadiusValue(_ sender: NSSlider) {
        bumpDistortionRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.bumpDistortionRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getBumpDistortionScaleValue(_ sender: NSSlider) {
        bumpDistortionScaleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.bumpDistortionScaleValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xBumpDistortionValueTextField: NSTextField!
    @IBOutlet weak var yBumpDistortionValueTextField: NSTextField!
    @IBOutlet weak var bumpDistortionRadiusTextField: NSTextField!
    @IBOutlet weak var bumpDistortionScaleTextField: NSTextField!
    @IBAction func getXbumpDistortionEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xBumpDistortionSlider.minValue {
                    xBumpDistortionSlider.doubleValue = xBumpDistortionSlider.minValue
            } else if Double(sender.stringValue)! > xBumpDistortionSlider.maxValue {
                xBumpDistortionSlider.doubleValue = xBumpDistortionSlider.maxValue
            } else {
                xBumpDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xBumpDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYbumpDistortionEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yBumpDistortionSlider.minValue {
                yBumpDistortionSlider.doubleValue = yBumpDistortionSlider.minValue
            } else if Double(sender.stringValue)! > yBumpDistortionSlider.maxValue {
                yBumpDistortionSlider.doubleValue = yBumpDistortionSlider.maxValue
            } else {
                yBumpDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yBumpDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getBumpDistortionRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < bumpDistortionRadiusSlider.minValue {
                bumpDistortionRadiusSlider.doubleValue = bumpDistortionRadiusSlider.minValue
            } else if Double(sender.stringValue)! > bumpDistortionRadiusSlider.maxValue {
                bumpDistortionRadiusSlider.doubleValue = bumpDistortionRadiusSlider.maxValue
            } else {
                bumpDistortionRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.bumpDistortionRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getBumpDistortionScaleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < bumpDistortionScaleSlider.minValue {
                bumpDistortionScaleSlider.doubleValue = bumpDistortionScaleSlider.minValue
            } else if Double(sender.stringValue)! > bumpDistortionScaleSlider.maxValue {
                bumpDistortionScaleSlider.doubleValue = bumpDistortionScaleSlider.maxValue
            } else {
                bumpDistortionScaleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.bumpDistortionScaleValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // bump distortion linear
    
    var xBumpDistortionLinearValue: CGFloat = 0.0 {
        didSet { windowController?.updateBumpDistortionLinear(with: xBumpDistortionLinearValue, y: yBumpDistortionLinearValue, radius: bumpDistortionLinearRadiusValue, angle: bumpDistortionLinearAngleValue, scale: bumpDistortionLinearScaleValue) }
    }
    var yBumpDistortionLinearValue: CGFloat = 0.0 {
        didSet { windowController?.updateBumpDistortionLinear(with: xBumpDistortionLinearValue, y: yBumpDistortionLinearValue, radius: bumpDistortionLinearRadiusValue, angle: bumpDistortionLinearAngleValue, scale: bumpDistortionLinearScaleValue) }
    }
    var bumpDistortionLinearRadiusValue: Double = 0.0 {
        didSet { windowController?.updateBumpDistortionLinear(with: xBumpDistortionLinearValue, y: yBumpDistortionLinearValue, radius: bumpDistortionLinearRadiusValue, angle: bumpDistortionLinearAngleValue, scale: bumpDistortionLinearScaleValue) }
    }
    var bumpDistortionLinearScaleValue: Double = 2.0 {
        didSet { windowController?.updateBumpDistortionLinear(with: xBumpDistortionLinearValue, y: yBumpDistortionLinearValue, radius: bumpDistortionLinearRadiusValue, angle: bumpDistortionLinearAngleValue, scale: bumpDistortionLinearScaleValue) }
    }
    var bumpDistortionLinearAngleValue = 0.0 {
        didSet { windowController?.updateBumpDistortionLinear(with: xBumpDistortionLinearValue, y: yBumpDistortionLinearValue, radius: bumpDistortionLinearRadiusValue, angle: bumpDistortionLinearAngleValue, scale: bumpDistortionLinearScaleValue) }
    }
    
    @IBOutlet weak var xBumpDistortionLinearSlider: NSSlider!
    @IBOutlet weak var yBumpDistortionLinearSlider: NSSlider!
    @IBOutlet weak var bumpDistortionLinearRadiusSlider: NSSlider!
    @IBOutlet weak var bumpDistortionLinearScaleSlider: NSSlider!
    @IBOutlet weak var bumpDistortionLinearAngleSlider: NSSlider!
    @IBAction func getXBumpDistortionLinearEffectValue(_ sender: NSSlider) {
        xBumpDistortionLinearValueTextField.stringValue = String(sender.integerValue)
        self.xBumpDistortionLinearValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYBumpDistortionLinearEffectValue(_ sender: NSSlider) {
        yBumpDistortionLinearValueTextField.stringValue = String(sender.integerValue)
        self.yBumpDistortionLinearValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getBumpDistortionLinearRadiusValue(_ sender: NSSlider) {
        bumpDistortionLinearRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.bumpDistortionLinearRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getBumpDistortionLinearScaleValue(_ sender: NSSlider) {
        bumpDistortionLinearScaleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.bumpDistortionLinearScaleValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getBumpDistortionLinearAngleValue(_ sender: NSSlider) {
        bumpDistortionLinearAngleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.bumpDistortionLinearAngleValue = sender.doubleValue.roundTo(places: 2) / 57.2957795131
    }
    @IBOutlet weak var xBumpDistortionLinearValueTextField: NSTextField!
    @IBOutlet weak var yBumpDistortionLinearValueTextField: NSTextField!
    @IBOutlet weak var bumpDistortionLinearRadiusTextField: NSTextField!
    @IBOutlet weak var bumpDistortionLinearScaleTextField: NSTextField!
    @IBOutlet weak var bumpDistortionLinearAngleTextField: NSTextField!
    @IBAction func getXbumpDistortionLinearEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xBumpDistortionLinearSlider.minValue {
                xBumpDistortionLinearSlider.doubleValue = xBumpDistortionLinearSlider.minValue
            } else if Double(sender.stringValue)! > xBumpDistortionLinearSlider.maxValue {
                xBumpDistortionLinearSlider.doubleValue = xBumpDistortionLinearSlider.maxValue
            } else {
                xBumpDistortionLinearSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xBumpDistortionLinearValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYbumpDistortionLinearEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yBumpDistortionLinearSlider.minValue {
                yBumpDistortionLinearSlider.doubleValue = yBumpDistortionLinearSlider.minValue
            } else if Double(sender.stringValue)! > yBumpDistortionLinearSlider.maxValue {
                yBumpDistortionLinearSlider.doubleValue = yBumpDistortionLinearSlider.maxValue
            } else {
                yBumpDistortionLinearSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yBumpDistortionLinearValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getBumpDistortionLinearRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < bumpDistortionLinearRadiusSlider.minValue {
                bumpDistortionLinearRadiusSlider.doubleValue = bumpDistortionLinearRadiusSlider.minValue
            } else if Double(sender.stringValue)! > bumpDistortionLinearRadiusSlider.maxValue {
                bumpDistortionLinearRadiusSlider.doubleValue = bumpDistortionLinearRadiusSlider.maxValue
            } else {
                bumpDistortionLinearRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.bumpDistortionLinearRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getBumpDistortionLinearScaleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < bumpDistortionLinearScaleSlider.minValue {
                bumpDistortionLinearScaleSlider.doubleValue = bumpDistortionLinearScaleSlider.minValue
            } else if Double(sender.stringValue)! > bumpDistortionLinearScaleSlider.maxValue {
                bumpDistortionLinearScaleSlider.doubleValue = bumpDistortionLinearScaleSlider.maxValue
            } else {
                bumpDistortionLinearScaleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.bumpDistortionLinearScaleValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getBumpDistortionLinearAngleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < bumpDistortionLinearAngleSlider.minValue {
                bumpDistortionLinearAngleSlider.doubleValue = bumpDistortionLinearAngleSlider.minValue
            } else if Double(sender.stringValue)! > bumpDistortionLinearAngleSlider.maxValue {
                bumpDistortionLinearAngleSlider.doubleValue = bumpDistortionLinearAngleSlider.maxValue
            } else {
                bumpDistortionLinearAngleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.bumpDistortionLinearAngleValue = Double(sender.stringValue)! / 57.2957795131
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // circle splash distortion
    
    var xCircleSplashDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateCircleSplashDistortion(with: xCircleSplashDistortionValue, y: yCircleSplashDistortionValue, radius: circleSplashDistortionRadiusValue) }
    }
    var yCircleSplashDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateCircleSplashDistortion(with: xCircleSplashDistortionValue, y: yCircleSplashDistortionValue, radius: circleSplashDistortionRadiusValue) }
    }
    var circleSplashDistortionRadiusValue: Double = 0.0 {
        didSet { windowController?.updateCircleSplashDistortion(with: xCircleSplashDistortionValue, y: yCircleSplashDistortionValue, radius: circleSplashDistortionRadiusValue) }
    }
    
    @IBOutlet weak var xCircleSplashDistortionSlider: NSSlider!
    @IBOutlet weak var yCircleSplashDistortionSlider: NSSlider!
    @IBOutlet weak var circleSplashDistortionRadiusSlider: NSSlider!
    @IBAction func getXCircleSplashDistortionEffectValue(_ sender: NSSlider) {
        xCircleSplashDistortionValueTextField.stringValue = String(sender.integerValue)
        self.xCircleSplashDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYCircleSplashDistortionEffectValue(_ sender: NSSlider) {
        yCircleSplashDistortionValueTextField.stringValue = String(sender.integerValue)
        self.yCircleSplashDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getCircleSplashDistortionRadiusValue(_ sender: NSSlider) {
        circleSplashDistortionRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.circleSplashDistortionRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xCircleSplashDistortionValueTextField: NSTextField!
    @IBOutlet weak var yCircleSplashDistortionValueTextField: NSTextField!
    @IBOutlet weak var circleSplashDistortionRadiusTextField: NSTextField!
    @IBAction func getXCircleSplashDistortionEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xCircleSplashDistortionSlider.minValue {
                xCircleSplashDistortionSlider.doubleValue = xCircleSplashDistortionSlider.minValue
            } else if Double(sender.stringValue)! > xCircleSplashDistortionSlider.maxValue {
                xCircleSplashDistortionSlider.doubleValue = xCircleSplashDistortionSlider.maxValue
            } else {
                xCircleSplashDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xCircleSplashDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYCircleSplashDistortionEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yCircleSplashDistortionSlider.minValue {
                yCircleSplashDistortionSlider.doubleValue = yCircleSplashDistortionSlider.minValue
            } else if Double(sender.stringValue)! > yCircleSplashDistortionSlider.maxValue {
                yCircleSplashDistortionSlider.doubleValue = yCircleSplashDistortionSlider.maxValue
            } else {
                yCircleSplashDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yCircleSplashDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getCircleSplashDistortionRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < circleSplashDistortionRadiusSlider.minValue {
                circleSplashDistortionRadiusSlider.doubleValue = circleSplashDistortionRadiusSlider.minValue
            } else if Double(sender.stringValue)! > circleSplashDistortionRadiusSlider.maxValue {
                circleSplashDistortionRadiusSlider.doubleValue = circleSplashDistortionRadiusSlider.maxValue
            } else {
                circleSplashDistortionRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.circleSplashDistortionRadiusValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // circular wrap
    
    var xCircularWrapValue: CGFloat = 0.0 {
        didSet { windowController?.updateCircularWrap(with: xCircularWrapValue, y: yCircularWrapValue, radius: circularWrapRadiusValue, angle: circularWrapAngleValue) }
    }
    var yCircularWrapValue: CGFloat = 0.0 {
        didSet { windowController?.updateCircularWrap(with: xCircularWrapValue, y: yCircularWrapValue, radius: circularWrapRadiusValue, angle: circularWrapAngleValue) }
    }
    var circularWrapRadiusValue: Double = 0.0 {
        didSet { windowController?.updateCircularWrap(with: xCircularWrapValue, y: yCircularWrapValue, radius: circularWrapRadiusValue, angle: circularWrapAngleValue) }
    }
    var circularWrapAngleValue: Double = 0.0 {
        didSet { windowController?.updateCircularWrap(with: xCircularWrapValue, y: yCircularWrapValue, radius: circularWrapRadiusValue, angle: circularWrapAngleValue) }
    }
    
    @IBOutlet weak var xCircularWrapSlider: NSSlider!
    @IBOutlet weak var yCircularWrapSlider: NSSlider!
    @IBOutlet weak var circularWrapRadiusSlider: NSSlider!
    @IBOutlet weak var circularWrapAngleSlider: NSSlider!
    @IBAction func getXCircularWrapValue(_ sender: NSSlider) {
        xCircularWrapValueTextField.stringValue = String(sender.integerValue)
        self.xCircularWrapValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYCircularWrapValue(_ sender: NSSlider) {
        yCircularWrapValueTextField.stringValue = String(sender.integerValue)
        self.yCircularWrapValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getCircularWrapRadiusValue(_ sender: NSSlider) {
        circularWrapRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.circularWrapRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getCircularWrapAngleValue(_ sender: NSSlider) {
        circularWrapAngleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.circularWrapAngleValue = sender.doubleValue.roundTo(places: 2) / 57.2957795131
    }
    @IBOutlet weak var xCircularWrapValueTextField: NSTextField!
    @IBOutlet weak var yCircularWrapValueTextField: NSTextField!
    @IBOutlet weak var circularWrapRadiusTextField: NSTextField!
    @IBOutlet weak var circularWrapAngleTextField: NSTextField!
    @IBAction func getXCircularWrapValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xCircularWrapSlider.minValue {
                xCircularWrapSlider.doubleValue = xCircularWrapSlider.minValue
            } else if Double(sender.stringValue)! > xCircularWrapSlider.maxValue {
                xCircularWrapSlider.doubleValue = xCircularWrapSlider.maxValue
            } else {
                xCircularWrapSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xCircularWrapValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYCircularWrapValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yCircularWrapSlider.minValue {
                yCircularWrapSlider.doubleValue = yCircularWrapSlider.minValue
            } else if Double(sender.stringValue)! > yCircularWrapSlider.maxValue {
                yCircularWrapSlider.doubleValue = yCircularWrapSlider.maxValue
            } else {
                yCircularWrapSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yCircularWrapValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getCircularWrapRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < circularWrapRadiusSlider.minValue {
                circularWrapRadiusSlider.doubleValue = circularWrapRadiusSlider.minValue
            } else if Double(sender.stringValue)! > circularWrapRadiusSlider.maxValue {
                circularWrapRadiusSlider.doubleValue = circularWrapRadiusSlider.maxValue
            } else {
                circularWrapRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.circularWrapRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getCircularWrapAngleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < circularWrapAngleSlider.minValue {
                circularWrapAngleSlider.doubleValue = circularWrapAngleSlider.minValue
            } else if Double(sender.stringValue)! > circularWrapAngleSlider.maxValue {
                circularWrapAngleSlider.doubleValue = circularWrapAngleSlider.maxValue
            } else {
                circularWrapAngleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.circularWrapAngleValue = Double(sender.stringValue)! / 57.2957795131
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // circle splash distortion
    
    var xGlassDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateGlassDistortion(with: xGlassDistortionValue, y: yGlassDistortionValue, scale: glassDistortionScaleValue) }
    }
    var yGlassDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateGlassDistortion(with: xGlassDistortionValue, y: yGlassDistortionValue, scale: glassDistortionScaleValue) }
    }
    var glassDistortionScaleValue: Double = 75.0 {
        didSet { windowController?.updateGlassDistortion(with: xGlassDistortionValue, y: yGlassDistortionValue, scale: glassDistortionScaleValue) }
    }
    
    @IBOutlet weak var xGlassDistortionSlider: NSSlider!
    @IBOutlet weak var yGlassDistortionSlider: NSSlider!
    @IBOutlet weak var glassDistortionScaleSlider: NSSlider!
    @IBAction func getXGlassDistortionEffectValue(_ sender: NSSlider) {
        xGlassDistortionValueTextField.stringValue = String(sender.integerValue)
        self.xGlassDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYGlassDistortionEffectValue(_ sender: NSSlider) {
        yGlassDistortionValueTextField.stringValue = String(sender.integerValue)
        self.yGlassDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getGlassDistortionScaleValue(_ sender: NSSlider) {
        glassDistortionScaleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.glassDistortionScaleValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xGlassDistortionValueTextField: NSTextField!
    @IBOutlet weak var yGlassDistortionValueTextField: NSTextField!
    @IBOutlet weak var glassDistortionScaleTextField: NSTextField!
    @IBAction func getXGlassDistortionEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xGlassDistortionSlider.minValue {
                xGlassDistortionSlider.doubleValue = xGlassDistortionSlider.minValue
            } else if Double(sender.stringValue)! > xGlassDistortionSlider.maxValue {
                xGlassDistortionSlider.doubleValue = xGlassDistortionSlider.maxValue
            } else {
                xGlassDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xGlassDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYGlassDistortionEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yGlassDistortionSlider.minValue {
                yGlassDistortionSlider.doubleValue = yGlassDistortionSlider.minValue
            } else if Double(sender.stringValue)! > yGlassDistortionSlider.maxValue {
                yGlassDistortionSlider.doubleValue = yGlassDistortionSlider.maxValue
            } else {
                yGlassDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yGlassDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getGlassDistortionScaleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < glassDistortionScaleSlider.minValue {
                glassDistortionScaleSlider.doubleValue = glassDistortionScaleSlider.minValue
            } else if Double(sender.stringValue)! > glassDistortionScaleSlider.maxValue {
                glassDistortionScaleSlider.doubleValue = glassDistortionScaleSlider.maxValue
            } else {
                glassDistortionScaleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.glassDistortionScaleValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // hole distortion
    
    var xHoleDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateHoleDistortion(with: xHoleDistortionValue, y: yHoleDistortionValue, radius: holeDistortionRadiusValue) }
    }
    var yHoleDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateHoleDistortion(with: xHoleDistortionValue, y: yHoleDistortionValue, radius: holeDistortionRadiusValue) }
    }
    var holeDistortionRadiusValue: Double = 0.0 {
        didSet { windowController?.updateHoleDistortion(with: xHoleDistortionValue, y: yHoleDistortionValue, radius: holeDistortionRadiusValue) }
    }
    
    @IBOutlet weak var xHoleDistortionSlider: NSSlider!
    @IBOutlet weak var yHoleDistortionSlider: NSSlider!
    @IBOutlet weak var holeDistortionRadiusSlider: NSSlider!
    @IBAction func getXHoleDistortionValue(_ sender: NSSlider) {
        xHoleDistortionValueTextField.stringValue = String(sender.integerValue)
        self.xHoleDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYHoleDistortionValue(_ sender: NSSlider) {
        yHoleDistortionValueTextField.stringValue = String(sender.integerValue)
        self.yHoleDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getHoleDistortionRadiusValue(_ sender: NSSlider) {
        holeDistortionRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.holeDistortionRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xHoleDistortionValueTextField: NSTextField!
    @IBOutlet weak var yHoleDistortionValueTextField: NSTextField!
    @IBOutlet weak var holeDistortionRadiusTextField: NSTextField!
    @IBAction func getXHoleDistortionValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xHoleDistortionSlider.minValue {
                xHoleDistortionSlider.doubleValue = xHoleDistortionSlider.minValue
            } else if Double(sender.stringValue)! > xHoleDistortionSlider.maxValue {
                xHoleDistortionSlider.doubleValue = xHoleDistortionSlider.maxValue
            } else {
                xHoleDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xHoleDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYHoleDistortionValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yHoleDistortionSlider.minValue {
                yHoleDistortionSlider.doubleValue = yHoleDistortionSlider.minValue
            } else if Double(sender.stringValue)! > yHoleDistortionSlider.maxValue {
                yHoleDistortionSlider.doubleValue = yHoleDistortionSlider.maxValue
            } else {
                yHoleDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yHoleDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getHoleDistortionRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < holeDistortionRadiusSlider.minValue {
                holeDistortionRadiusSlider.doubleValue = holeDistortionRadiusSlider.minValue
            } else if Double(sender.stringValue)! > holeDistortionRadiusSlider.maxValue {
                holeDistortionRadiusSlider.doubleValue = holeDistortionRadiusSlider.maxValue
            } else {
                holeDistortionRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.holeDistortionRadiusValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // light tunnel distortion
    
    var xLightTunnelValue: CGFloat = 0.0 {
        didSet { windowController?.updateLightTunnel(with: xLightTunnelValue, y: yLightTunnelValue, radius: lightTunnelRadiusValue, rotation: lightTunnelRotationValue) }
    }
    var yLightTunnelValue: CGFloat = 0.0 {
        didSet { windowController?.updateLightTunnel(with: xLightTunnelValue, y: yLightTunnelValue, radius: lightTunnelRadiusValue, rotation: lightTunnelRotationValue) }
    }
    var lightTunnelRadiusValue: Double = 1.0 {
        didSet { windowController?.updateLightTunnel(with: xLightTunnelValue, y: yLightTunnelValue, radius: lightTunnelRadiusValue, rotation: lightTunnelRotationValue) }
    }
    var lightTunnelRotationValue: Double = 10.0 {
        didSet { windowController?.updateLightTunnel(with: xLightTunnelValue, y: yLightTunnelValue, radius: lightTunnelRadiusValue, rotation: lightTunnelRotationValue) }
    }
    
    @IBOutlet weak var xLightTunnelSlider: NSSlider!
    @IBOutlet weak var yLightTunnelSlider: NSSlider!
    @IBOutlet weak var lightTunnelRadiusSlider: NSSlider!
    @IBOutlet weak var lightTunnelRotationSlider: NSSlider!
    @IBAction func getXLightTunnelEffectValue(_ sender: NSSlider) {
        xLightTunnelValueTextField.stringValue = String(sender.integerValue)
        self.xLightTunnelValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYLightTunnelEffectValue(_ sender: NSSlider) {
        yLightTunnelValueTextField.stringValue = String(sender.integerValue)
        self.yLightTunnelValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getLightTunnelRadiusValue(_ sender: NSSlider) {
        lightTunnelRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.lightTunnelRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getLightTunnelRotationValue(_ sender: NSSlider) {
        lightTunnelRotationTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.lightTunnelRotationValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xLightTunnelValueTextField: NSTextField!
    @IBOutlet weak var yLightTunnelValueTextField: NSTextField!
    @IBOutlet weak var lightTunnelRadiusTextField: NSTextField!
    @IBOutlet weak var lightTunnelRotationTextField: NSTextField!
    @IBAction func getXLightTunnelEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xLightTunnelSlider.minValue {
                xLightTunnelSlider.doubleValue = xLightTunnelSlider.minValue
            } else if Double(sender.stringValue)! > xLightTunnelSlider.maxValue {
                xLightTunnelSlider.doubleValue = xLightTunnelSlider.maxValue
            } else {
                xLightTunnelSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xLightTunnelValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYLightTunnelEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yLightTunnelSlider.minValue {
                yLightTunnelSlider.doubleValue = yLightTunnelSlider.minValue
            } else if Double(sender.stringValue)! > yLightTunnelSlider.maxValue {
                yLightTunnelSlider.doubleValue = yLightTunnelSlider.maxValue
            } else {
                yLightTunnelSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yLightTunnelValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getLightTunnelRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < lightTunnelRadiusSlider.minValue {
                lightTunnelRadiusSlider.doubleValue = lightTunnelRadiusSlider.minValue
            } else if Double(sender.stringValue)! > lightTunnelRadiusSlider.maxValue {
                lightTunnelRadiusSlider.doubleValue = lightTunnelRadiusSlider.maxValue
            } else {
                lightTunnelRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.lightTunnelRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getlightTunnelRotationT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < lightTunnelRotationSlider.minValue {
                lightTunnelRotationSlider.doubleValue = lightTunnelRotationSlider.minValue
            } else if Double(sender.stringValue)! > lightTunnelRotationSlider.maxValue {
                lightTunnelRotationSlider.doubleValue = lightTunnelRotationSlider.maxValue
            } else {
                lightTunnelRotationSlider.doubleValue = Double(sender.stringValue)!
            }
            self.lightTunnelRotationValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // pinch distortion
    
    var xPinchDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updatePinchDistortion(with: xPinchDistortionValue, y: yPinchDistortionValue, radius: pinchDistortionRadiusValue, scale: pinchDistortionScaleValue) }
    }
    var yPinchDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updatePinchDistortion(with: xPinchDistortionValue, y: yPinchDistortionValue, radius: pinchDistortionRadiusValue, scale: pinchDistortionScaleValue) }
    }
    var pinchDistortionRadiusValue: Double = 0.0 {
        didSet { windowController?.updatePinchDistortion(with: xPinchDistortionValue, y: yPinchDistortionValue, radius: pinchDistortionRadiusValue, scale: pinchDistortionScaleValue) }
    }
    var pinchDistortionScaleValue: Double = 0.8 {
        didSet { windowController?.updatePinchDistortion(with: xPinchDistortionValue, y: yPinchDistortionValue, radius: pinchDistortionRadiusValue, scale: pinchDistortionScaleValue) }
    }
    
    @IBOutlet weak var xPinchDistortionSlider: NSSlider!
    @IBOutlet weak var yPinchDistortionSlider: NSSlider!
    @IBOutlet weak var pinchDistortionRadiusSlider: NSSlider!
    @IBOutlet weak var pinchDistortionScaleSlider: NSSlider!
    @IBAction func getXPinchDistortionValue(_ sender: NSSlider) {
        xPinchDistortionValueTextField.stringValue = String(sender.integerValue)
        self.xPinchDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYPinchDistortionValue(_ sender: NSSlider) {
        yPinchDistortionValueTextField.stringValue = String(sender.integerValue)
        self.yPinchDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getPinchDistortionRadiusValue(_ sender: NSSlider) {
        pinchDistortionRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.pinchDistortionRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getPinchDistortionScaleValue(_ sender: NSSlider) {
        pinchDistortionScaleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.pinchDistortionScaleValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xPinchDistortionValueTextField: NSTextField!
    @IBOutlet weak var yPinchDistortionValueTextField: NSTextField!
    @IBOutlet weak var pinchDistortionRadiusTextField: NSTextField!
    @IBOutlet weak var pinchDistortionScaleTextField: NSTextField!
    @IBAction func getXPinchDistortionValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xPinchDistortionSlider.minValue {
                xPinchDistortionSlider.doubleValue = xPinchDistortionSlider.minValue
            } else if Double(sender.stringValue)! > xPinchDistortionSlider.maxValue {
                xPinchDistortionSlider.doubleValue = xPinchDistortionSlider.maxValue
            } else {
                xPinchDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xPinchDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYPinchDistortionValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yPinchDistortionSlider.minValue {
                yPinchDistortionSlider.doubleValue = yPinchDistortionSlider.minValue
            } else if Double(sender.stringValue)! > yPinchDistortionSlider.maxValue {
                yPinchDistortionSlider.doubleValue = yPinchDistortionSlider.maxValue
            } else {
                yPinchDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yPinchDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getPinchDistortionRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < pinchDistortionRadiusSlider.minValue {
                pinchDistortionRadiusSlider.doubleValue = pinchDistortionRadiusSlider.minValue
            } else if Double(sender.stringValue)! > pinchDistortionRadiusSlider.maxValue {
                pinchDistortionRadiusSlider.doubleValue = pinchDistortionRadiusSlider.maxValue
            } else {
                pinchDistortionRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.pinchDistortionRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getPinchDistortionScaleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < pinchDistortionScaleSlider.minValue {
                pinchDistortionScaleSlider.doubleValue = pinchDistortionScaleSlider.minValue
            } else if Double(sender.stringValue)! > pinchDistortionScaleSlider.maxValue {
                pinchDistortionScaleSlider.doubleValue = pinchDistortionScaleSlider.maxValue
                pinchDistortionScaleTextField.stringValue = "2.0"
            } else {
                pinchDistortionScaleSlider.doubleValue = Double(sender.stringValue)!
            }
            if Double(sender.stringValue)! > 2.0 {
                self.pinchDistortionScaleValue = 2.0
            } else {
                self.pinchDistortionScaleValue = Double(sender.stringValue)!
            }
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // stretch crop
    
    var stretchCropWidthValue: CGFloat = 0.0 {
        didSet { windowController?.updateStretchCrop(with: stretchCropWidthValue, height: stretchCropHeightValue, cropAmount: stretchCropCropAmountValue, centerStretchAmount: stretchCropCenterStretchAmountValue) }
    }
    var stretchCropHeightValue: CGFloat = 0.0 {
        didSet { windowController?.updateStretchCrop(with: stretchCropWidthValue, height: stretchCropHeightValue, cropAmount: stretchCropCropAmountValue, centerStretchAmount: stretchCropCenterStretchAmountValue) }
    }
    var stretchCropCropAmountValue: Double = 0.4 {
        didSet { windowController?.updateStretchCrop(with: stretchCropWidthValue, height: stretchCropHeightValue, cropAmount: stretchCropCropAmountValue, centerStretchAmount: stretchCropCenterStretchAmountValue) }
    }
    var stretchCropCenterStretchAmountValue: Double = 0.0 {
        didSet { windowController?.updateStretchCrop(with: stretchCropWidthValue, height: stretchCropHeightValue, cropAmount: stretchCropCropAmountValue, centerStretchAmount: stretchCropCenterStretchAmountValue) }
    }
    
    @IBOutlet weak var stretchCropWidthSlider: NSSlider!
    @IBOutlet weak var stretchCropHeightSlider: NSSlider!
    @IBOutlet weak var stretchCropCropAmountSlider: NSSlider!
    @IBOutlet weak var stretchCropCenterStretchAmountSlider: NSSlider!
    @IBAction func getStretchCropWidthValue(_ sender: NSSlider) {
        stretchCropWidthTextField.stringValue = String(sender.integerValue)
        self.stretchCropWidthValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getStretchCropHeightValue(_ sender: NSSlider) {
        stretchCropHeightTextField.stringValue = String(sender.integerValue)
        self.stretchCropHeightValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getStretchCropCropAmountValue(_ sender: NSSlider) {
        stretchCropCropAmountTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.stretchCropCropAmountValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getStretchCropCenterStretchAmountValue(_ sender: NSSlider) {
        stretchCropCenterStretchAmountTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.stretchCropCenterStretchAmountValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var stretchCropWidthTextField: NSTextField!
    @IBOutlet weak var stretchCropHeightTextField: NSTextField!
    @IBOutlet weak var stretchCropCropAmountTextField: NSTextField!
    @IBOutlet weak var stretchCropCenterStretchAmountTextField: NSTextField!
    @IBAction func getStretchCropWidthValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < stretchCropWidthSlider.minValue {
                stretchCropWidthSlider.doubleValue = stretchCropWidthSlider.minValue
            } else if Double(sender.stringValue)! > stretchCropWidthSlider.maxValue {
                stretchCropWidthSlider.doubleValue = stretchCropWidthSlider.maxValue
            } else {
                stretchCropWidthSlider.doubleValue = Double(sender.stringValue)!
            }
            self.stretchCropWidthValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getStretchCropHeightValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < stretchCropHeightSlider.minValue {
                stretchCropHeightSlider.doubleValue = stretchCropHeightSlider.minValue
            } else if Double(sender.stringValue)! > stretchCropHeightSlider.maxValue {
                stretchCropHeightSlider.doubleValue = stretchCropHeightSlider.maxValue
            } else {
                stretchCropHeightSlider.doubleValue = Double(sender.stringValue)!
            }
            self.stretchCropHeightValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getStretchCropCropAmountValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < stretchCropCropAmountSlider.minValue {
                stretchCropCropAmountSlider.doubleValue = stretchCropCropAmountSlider.minValue
            } else if Double(sender.stringValue)! > stretchCropCropAmountSlider.maxValue {
                stretchCropCropAmountSlider.doubleValue = stretchCropCropAmountSlider.maxValue
            } else {
                stretchCropCropAmountSlider.doubleValue = Double(sender.stringValue)!
            }
            self.stretchCropCropAmountValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getStretchCropCenterStretchAmountValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < stretchCropCenterStretchAmountSlider.minValue {
                stretchCropCenterStretchAmountSlider.doubleValue = stretchCropCenterStretchAmountSlider.minValue
            } else if Double(sender.stringValue)! > stretchCropCenterStretchAmountSlider.maxValue {
                stretchCropCenterStretchAmountSlider.doubleValue = stretchCropCenterStretchAmountSlider.maxValue
            } else {
                stretchCropCenterStretchAmountSlider.doubleValue = Double(sender.stringValue)!
            }
            self.stretchCropCenterStretchAmountValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // torus lens distortion
    
    var xTorusLensDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateTorusLensDistortion(with: xTorusLensDistortionValue, y: yTorusLensDistortionValue, radius: torusLensDistortionRadiusValue, width: torusLensDistortionWidthValue, refraction: torusLensDistortionRefractionValue) }
    }
    var yTorusLensDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateTorusLensDistortion(with: xTorusLensDistortionValue, y: yTorusLensDistortionValue, radius: torusLensDistortionRadiusValue, width: torusLensDistortionWidthValue, refraction: torusLensDistortionRefractionValue) }
    }
    var torusLensDistortionRadiusValue: Double = 0.0 {
        didSet { windowController?.updateTorusLensDistortion(with: xTorusLensDistortionValue, y: yTorusLensDistortionValue, radius: torusLensDistortionRadiusValue, width: torusLensDistortionWidthValue, refraction: torusLensDistortionRefractionValue) }
    }
    var torusLensDistortionWidthValue: Double = 0.0 {
        didSet { windowController?.updateTorusLensDistortion(with: xTorusLensDistortionValue, y: yTorusLensDistortionValue, radius: torusLensDistortionRadiusValue, width: torusLensDistortionWidthValue, refraction: torusLensDistortionRefractionValue) }
    }
    var torusLensDistortionRefractionValue = 2.0 {
        didSet { windowController?.updateTorusLensDistortion(with: xTorusLensDistortionValue, y: yTorusLensDistortionValue, radius: torusLensDistortionRadiusValue, width: torusLensDistortionWidthValue, refraction: torusLensDistortionRefractionValue) }
    }
    
    @IBOutlet weak var xTorusLensDistortionSlider: NSSlider!
    @IBOutlet weak var yTorusLensDistortionSlider: NSSlider!
    @IBOutlet weak var torusLensDistortionRadiusSlider: NSSlider!
    @IBOutlet weak var torusLensDistortionWidthSlider: NSSlider!
    @IBOutlet weak var torusLensDistortionRefractionSlider: NSSlider!
    @IBAction func getXTorusLensDistortionEffectValue(_ sender: NSSlider) {
        xTorusLensDistortionValueTextField.stringValue = String(sender.integerValue)
        self.xTorusLensDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYTorusLensDistortionEffectValue(_ sender: NSSlider) {
        yTorusLensDistortionValueTextField.stringValue = String(sender.integerValue)
        self.yTorusLensDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getTorusLensDistortionRadiusValue(_ sender: NSSlider) {
        torusLensDistortionRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.torusLensDistortionRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getTorusLensDistortionWidthValue(_ sender: NSSlider) {
        torusLensDistortionWidthTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.torusLensDistortionWidthValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getTorusLensDistortionRefractionValue(_ sender: NSSlider) {
        torusLensDistortionRefractionTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.torusLensDistortionRefractionValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xTorusLensDistortionValueTextField: NSTextField!
    @IBOutlet weak var yTorusLensDistortionValueTextField: NSTextField!
    @IBOutlet weak var torusLensDistortionRadiusTextField: NSTextField!
    @IBOutlet weak var torusLensDistortionWidthTextField: NSTextField!
    @IBOutlet weak var torusLensDistortionRefractionTextField: NSTextField!
    @IBAction func getXTorusLensDistortionEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xTorusLensDistortionSlider.minValue {
                xTorusLensDistortionSlider.doubleValue = xTorusLensDistortionSlider.minValue
            } else if Double(sender.stringValue)! > xTorusLensDistortionSlider.maxValue {
                xTorusLensDistortionSlider.doubleValue = xTorusLensDistortionSlider.maxValue
            } else {
                xTorusLensDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xTorusLensDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYTorusLensDistortionEffectValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yTorusLensDistortionSlider.minValue {
                yTorusLensDistortionSlider.doubleValue = yTorusLensDistortionSlider.minValue
            } else if Double(sender.stringValue)! > yTorusLensDistortionSlider.maxValue {
                yTorusLensDistortionSlider.doubleValue = yTorusLensDistortionSlider.maxValue
            } else {
                yTorusLensDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yTorusLensDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getTorusLensDistortionRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < torusLensDistortionRadiusSlider.minValue {
                torusLensDistortionRadiusSlider.doubleValue = torusLensDistortionRadiusSlider.minValue
            } else if Double(sender.stringValue)! > torusLensDistortionRadiusSlider.maxValue {
                torusLensDistortionRadiusSlider.doubleValue = torusLensDistortionRadiusSlider.maxValue
            } else {
                torusLensDistortionRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.torusLensDistortionRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getTorusLensDistortionWidthT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < torusLensDistortionWidthSlider.minValue {
                torusLensDistortionWidthSlider.doubleValue = torusLensDistortionWidthSlider.minValue
            } else if Double(sender.stringValue)! > torusLensDistortionWidthSlider.maxValue {
                torusLensDistortionWidthSlider.doubleValue = torusLensDistortionWidthSlider.maxValue
            } else {
                torusLensDistortionWidthSlider.doubleValue = Double(sender.stringValue)!
            }
            self.torusLensDistortionWidthValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getTorusLensDistortionRefractionT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < torusLensDistortionRefractionSlider.minValue {
                torusLensDistortionRefractionSlider.doubleValue = torusLensDistortionRefractionSlider.minValue
            } else if Double(sender.stringValue)! > torusLensDistortionRefractionSlider.maxValue {
                torusLensDistortionRefractionSlider.doubleValue = torusLensDistortionRefractionSlider.maxValue
            } else {
                torusLensDistortionRefractionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.torusLensDistortionRefractionValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // twirl distortion
    
    var xTwirlDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateTwirlDistortion(with: xTwirlDistortionValue, y: yTwirlDistortionValue, radius: twirlDistortionRadiusValue, angle: twirlDistortionAngleValue) }
    }
    var yTwirlDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateTwirlDistortion(with: xTwirlDistortionValue, y: yTwirlDistortionValue, radius: twirlDistortionRadiusValue, angle: twirlDistortionAngleValue) }
    }
    var twirlDistortionRadiusValue: Double = 0.0 {
        didSet { windowController?.updateTwirlDistortion(with: xTwirlDistortionValue, y: yTwirlDistortionValue, radius: twirlDistortionRadiusValue, angle: twirlDistortionAngleValue) }
    }
    var twirlDistortionAngleValue: Double = 3.14159265 {
        didSet { windowController?.updateTwirlDistortion(with: xTwirlDistortionValue, y: yTwirlDistortionValue, radius: twirlDistortionRadiusValue, angle: twirlDistortionAngleValue) }
    }
    
    @IBOutlet weak var xTwirlDistortionSlider: NSSlider!
    @IBOutlet weak var yTwirlDistortionSlider: NSSlider!
    @IBOutlet weak var twirlDistortionRadiusSlider: NSSlider!
    @IBOutlet weak var twirlDistortionAngleSlider: NSSlider!
    @IBAction func getXTwirlDistortionValue(_ sender: NSSlider) {
        xTwirlDistortionValueTextField.stringValue = String(sender.integerValue)
        self.xTwirlDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYTwirlDistortionValue(_ sender: NSSlider) {
        yTwirlDistortionValueTextField.stringValue = String(sender.integerValue)
        self.yTwirlDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getTwirlDistortionRadiusValue(_ sender: NSSlider) {
        twirlDistortionRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.twirlDistortionRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getTwirlDistortionAngleValue(_ sender: NSSlider) {
        twirlDistortionAngleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.twirlDistortionAngleValue = sender.doubleValue.roundTo(places: 2) / 57.2957795131
    }
    @IBOutlet weak var xTwirlDistortionValueTextField: NSTextField!
    @IBOutlet weak var yTwirlDistortionValueTextField: NSTextField!
    @IBOutlet weak var twirlDistortionRadiusTextField: NSTextField!
    @IBOutlet weak var twirlDistortionAngleTextField: NSTextField!
    @IBAction func getXTwirlDistortionValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xTwirlDistortionSlider.minValue {
                xTwirlDistortionSlider.doubleValue = xTwirlDistortionSlider.minValue
            } else if Double(sender.stringValue)! > xTwirlDistortionSlider.maxValue {
                xTwirlDistortionSlider.doubleValue = xTwirlDistortionSlider.maxValue
            } else {
                xTwirlDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xTwirlDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYTwirlDistortionValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yTwirlDistortionSlider.minValue {
                yTwirlDistortionSlider.doubleValue = yTwirlDistortionSlider.minValue
            } else if Double(sender.stringValue)! > yTwirlDistortionSlider.maxValue {
                yTwirlDistortionSlider.doubleValue = yTwirlDistortionSlider.maxValue
            } else {
                yTwirlDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yTwirlDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getTwirlDistortionRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < twirlDistortionRadiusSlider.minValue {
                twirlDistortionRadiusSlider.doubleValue = twirlDistortionRadiusSlider.minValue
            } else if Double(sender.stringValue)! > twirlDistortionRadiusSlider.maxValue {
                twirlDistortionRadiusSlider.doubleValue = twirlDistortionRadiusSlider.maxValue
            } else {
                twirlDistortionRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.twirlDistortionRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getTwirlDistortionAngleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < twirlDistortionAngleSlider.minValue {
                twirlDistortionAngleSlider.doubleValue = twirlDistortionAngleSlider.minValue
            } else if Double(sender.stringValue)! > twirlDistortionAngleSlider.maxValue {
                twirlDistortionAngleSlider.doubleValue = twirlDistortionAngleSlider.maxValue
            } else {
                twirlDistortionAngleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.twirlDistortionAngleValue = Double(sender.stringValue)! / 57.2957795131
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // vortex distortion
    
    var xVortexDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateVortexDistortion(with: xVortexDistortionValue, y: yVortexDistortionValue, radius: vortexDistortionRadiusValue, angle: vortexDistortionAngleValue) }
    }
    var yVortexDistortionValue: CGFloat = 0.0 {
        didSet { windowController?.updateVortexDistortion(with: xVortexDistortionValue, y: yVortexDistortionValue, radius: vortexDistortionRadiusValue, angle: vortexDistortionAngleValue) }
    }
    var vortexDistortionRadiusValue: Double = 0.0 {
        didSet { windowController?.updateVortexDistortion(with: xVortexDistortionValue, y: yVortexDistortionValue, radius: vortexDistortionRadiusValue, angle: vortexDistortionAngleValue) }
    }
    var vortexDistortionAngleValue: Double = 31.4159265 * 2 {
        didSet { windowController?.updateVortexDistortion(with: xVortexDistortionValue, y: yVortexDistortionValue, radius: vortexDistortionRadiusValue, angle: vortexDistortionAngleValue) }
    }
    
    @IBOutlet weak var xVortexDistortionSlider: NSSlider!
    @IBOutlet weak var yVortexDistortionSlider: NSSlider!
    @IBOutlet weak var vortexDistortionRadiusSlider: NSSlider!
    @IBOutlet weak var vortexDistortionAngleSlider: NSSlider!
    @IBAction func getXVortexDistortionValue(_ sender: NSSlider) {
        xVortexDistortionValueTextField.stringValue = String(sender.integerValue)
        self.xVortexDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYVortexDistortionValue(_ sender: NSSlider) {
        yVortexDistortionValueTextField.stringValue = String(sender.integerValue)
        self.yVortexDistortionValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getVortexDistortionRadiusValue(_ sender: NSSlider) {
        vortexDistortionRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.vortexDistortionRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getVortexDistortionAngleValue(_ sender: NSSlider) {
        vortexDistortionAngleTextField.stringValue = String(sender.integerValue)
        self.vortexDistortionAngleValue = sender.doubleValue.roundTo(places: 2) / 57.2957795131
    }
    @IBOutlet weak var xVortexDistortionValueTextField: NSTextField!
    @IBOutlet weak var yVortexDistortionValueTextField: NSTextField!
    @IBOutlet weak var vortexDistortionRadiusTextField: NSTextField!
    @IBOutlet weak var vortexDistortionAngleTextField: NSTextField!
    @IBAction func getXVortexDistortionValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xVortexDistortionSlider.minValue {
                xVortexDistortionSlider.doubleValue = xVortexDistortionSlider.minValue
            } else if Double(sender.stringValue)! > xVortexDistortionSlider.maxValue {
                xVortexDistortionSlider.doubleValue = xVortexDistortionSlider.maxValue
            } else {
                xVortexDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xVortexDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYVortexDistortionValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yVortexDistortionSlider.minValue {
                yVortexDistortionSlider.doubleValue = yVortexDistortionSlider.minValue
            } else if Double(sender.stringValue)! > yVortexDistortionSlider.maxValue {
                yVortexDistortionSlider.doubleValue = yVortexDistortionSlider.maxValue
            } else {
                yVortexDistortionSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yVortexDistortionValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getVortexDistortionRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < vortexDistortionRadiusSlider.minValue {
                vortexDistortionRadiusSlider.doubleValue = vortexDistortionRadiusSlider.minValue
            } else if Double(sender.stringValue)! > vortexDistortionRadiusSlider.maxValue {
                vortexDistortionRadiusSlider.doubleValue = vortexDistortionRadiusSlider.maxValue
            } else {
                vortexDistortionRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.vortexDistortionRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getVortexDistortionAngleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < vortexDistortionAngleSlider.minValue {
                vortexDistortionAngleSlider.doubleValue = vortexDistortionAngleSlider.minValue
            } else if Double(sender.stringValue)! > vortexDistortionAngleSlider.maxValue {
                vortexDistortionAngleSlider.doubleValue = vortexDistortionAngleSlider.maxValue
            } else {
                vortexDistortionAngleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.vortexDistortionAngleValue = Double(sender.stringValue)! / 57.2957795131
        }
    }
    
    
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    // stylize filters
    //-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"-_-"
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // bloom
    
    var bloomRadiusValue: Double = 20.0 {
        didSet { windowController?.updateBloom(with: bloomRadiusValue, intensity: bloomIntensityValue) }
    }
    var bloomIntensityValue: Double = 0.5 {
        didSet { windowController?.updateBloom(with: bloomRadiusValue, intensity: bloomIntensityValue) }
    }
    
    @IBOutlet weak var bloomRadiusSlider: NSSlider!
    @IBOutlet weak var bloomIntensitySlider: NSSlider!
    @IBAction func getBloomRadius(_ sender: NSSlider) {
        bloomRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.bloomRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getBloomIntensity(_ sender: NSSlider) {
        bloomIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.bloomIntensityValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var bloomRadiusTextField: NSTextField!
    @IBOutlet weak var bloomIntensityTextField: NSTextField!
    @IBAction func getBloomRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < bloomRadiusSlider.minValue {
                bloomRadiusSlider.doubleValue = bloomRadiusSlider.minValue
            } else if Double(sender.stringValue)! > bloomRadiusSlider.maxValue {
                bloomRadiusSlider.doubleValue = bloomRadiusSlider.maxValue
            } else {
                bloomRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.bloomRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getBloomIntensityT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < bloomIntensitySlider.minValue {
                bloomIntensitySlider.doubleValue = bloomIntensitySlider.minValue
            } else if Double(sender.stringValue)! > bloomIntensitySlider.maxValue {
                bloomIntensitySlider.doubleValue = bloomIntensitySlider.maxValue
            } else {
                bloomIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.bloomIntensityValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // crystallize
    
    var xCrystallizeValue: CGFloat = 0.0 {
        didSet { windowController?.updateCrystallize(with: xCrystallizeValue, y: yCrystallizeValue, radius: crystallizeRadiusValue) }
    }
    var yCrystallizeValue: CGFloat = 0.0 {
        didSet { windowController?.updateCrystallize(with: xCrystallizeValue, y: yCrystallizeValue, radius: crystallizeRadiusValue) }
    }
    var crystallizeRadiusValue: Double = 0.0 {
        didSet { windowController?.updateCrystallize(with: xCrystallizeValue, y: yCrystallizeValue, radius: crystallizeRadiusValue) }
    }
    
    @IBOutlet weak var xCrystallizeSlider: NSSlider!
    @IBOutlet weak var yCrystallizeSlider: NSSlider!
    @IBOutlet weak var crystallizeRadiusSlider: NSSlider!
    @IBAction func getXCrystallizeValue(_ sender: NSSlider) {
        xCrystallizeValueTextField.stringValue = String(sender.integerValue)
        self.xCrystallizeValue = CGFloat(sender.doubleValue)
    }
    @IBAction func getYCrystallizeValue(_ sender: NSSlider) {
        yCrystallizeValueTextField.stringValue = String(sender.integerValue)
        self.yCrystallizeValue = CGFloat(sender.doubleValue)
    }
    @IBAction func getCrystallizeRadiusValue(_ sender: NSSlider) {
        crystallizeRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.crystallizeRadiusValue = sender.doubleValue
    }
    @IBOutlet weak var xCrystallizeValueTextField: NSTextField!
    @IBOutlet weak var yCrystallizeValueTextField: NSTextField!
    @IBOutlet weak var crystallizeRadiusTextField: NSTextField!
    @IBAction func getXCrystallizeValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xCrystallizeSlider.minValue {
                xCrystallizeSlider.doubleValue = xCrystallizeSlider.minValue
            } else if Double(sender.stringValue)! > xCrystallizeSlider.maxValue {
                xCrystallizeSlider.doubleValue = xCrystallizeSlider.maxValue
            } else {
                xCrystallizeSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xCrystallizeValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYCrystallizeValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yCrystallizeSlider.minValue {
                yCrystallizeSlider.doubleValue = yCrystallizeSlider.minValue
            } else if Double(sender.stringValue)! > yCrystallizeSlider.maxValue {
                yCrystallizeSlider.doubleValue = yCrystallizeSlider.maxValue
            } else {
                yCrystallizeSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yCrystallizeValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getCrystallizeRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < crystallizeRadiusSlider.minValue {
                crystallizeRadiusSlider.doubleValue = crystallizeRadiusSlider.minValue
            } else if Double(sender.stringValue)! > crystallizeRadiusSlider.maxValue {
                crystallizeRadiusSlider.doubleValue = crystallizeRadiusSlider.maxValue
            } else {
                crystallizeRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.crystallizeRadiusValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // edges
    
    var edgesIntensityValue: Double = 10.0 {
        didSet { windowController?.updateEdges(with: edgesIntensityValue) }
    }
    
    @IBOutlet weak var edgesIntensitySlider: NSSlider!
    @IBAction func getEdgesIntensityValue(_ sender: NSSlider) {
        edgesIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.edgesIntensityValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var edgesIntensityTextField: NSTextField!
    @IBAction func getEdgesIntensityValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < edgesIntensitySlider.minValue {
                edgesIntensitySlider.doubleValue = edgesIntensitySlider.minValue
            } else if Double(sender.stringValue)! > edgesIntensitySlider.maxValue {
                edgesIntensitySlider.doubleValue = edgesIntensitySlider.maxValue
            } else {
                edgesIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.edgesIntensityValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // edge work
    
    var edgeWorkRadiusValue: Double = 2.0 {
        didSet { windowController?.updateEdgeWork(with: edgeWorkRadiusValue) }
    }
    
    @IBOutlet weak var edgeWorkRadiusSlider: NSSlider!
    @IBAction func getEdgeWorkRadiusValue(_ sender: NSSlider) {
        edgeWorkRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.edgeWorkRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var edgeWorkRadiusTextField: NSTextField!
    @IBAction func getEdgeWorkRadiusValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < edgeWorkRadiusSlider.minValue {
                edgeWorkRadiusSlider.doubleValue = edgeWorkRadiusSlider.minValue
            } else if Double(sender.stringValue)! > edgeWorkRadiusSlider.maxValue {
                edgeWorkRadiusSlider.doubleValue = edgeWorkRadiusSlider.maxValue
            } else {
                edgeWorkRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.edgeWorkRadiusValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // gloom
    
    var gloomRadiusValue: Double = 25.0 {
        didSet { windowController?.updateGloom(with: gloomRadiusValue, intensity: gloomIntensityValue) }
    }
    var gloomIntensityValue: Double = 0.5 {
        didSet { windowController?.updateGloom(with: gloomRadiusValue, intensity: gloomIntensityValue) }
    }
    
    @IBOutlet weak var gloomRadiusSlider: NSSlider!
    @IBOutlet weak var gloomIntensitySlider: NSSlider!
    @IBAction func getGloomRadius(_ sender: NSSlider) {
        gloomRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.gloomRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getGloomIntensity(_ sender: NSSlider) {
        gloomIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.gloomIntensityValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var gloomRadiusTextField: NSTextField!
    @IBOutlet weak var gloomIntensityTextField: NSTextField!
    @IBAction func getGloomRadiusT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < gloomRadiusSlider.minValue {
                gloomRadiusSlider.doubleValue = gloomRadiusSlider.minValue
            } else if Double(sender.stringValue)! > gloomRadiusSlider.maxValue {
                gloomRadiusSlider.doubleValue = gloomRadiusSlider.maxValue
            } else {
                gloomRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.gloomRadiusValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getGloomIntensityT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < gloomIntensitySlider.minValue {
                gloomIntensitySlider.doubleValue = gloomIntensitySlider.minValue
            } else if Double(sender.stringValue)! > gloomIntensitySlider.maxValue {
                gloomIntensitySlider.doubleValue = gloomIntensitySlider.maxValue
            } else {
                gloomIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.gloomIntensityValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // height field from mask
    
    var heightFieldFromMaskRadiusValue: Double = 25.0 {
        didSet { windowController?.updateHeightFieldFromMask(with: heightFieldFromMaskRadiusValue) }
    }
    
    @IBOutlet weak var heightFieldFromMaskRadiusSlider: NSSlider!
    @IBAction func getHeightFieldFromMaskRadiusValue(_ sender: NSSlider) {
        heightFieldFromMaskRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.heightFieldFromMaskRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var heightFieldFromMaskRadiusTextField: NSTextField!
    @IBAction func getHeightFieldFromMaskRadiusValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < heightFieldFromMaskRadiusSlider.minValue {
                heightFieldFromMaskRadiusSlider.doubleValue = heightFieldFromMaskRadiusSlider.minValue
            } else if Double(sender.stringValue)! > heightFieldFromMaskRadiusSlider.maxValue {
                heightFieldFromMaskRadiusSlider.doubleValue = heightFieldFromMaskRadiusSlider.maxValue
            } else {
                heightFieldFromMaskRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.heightFieldFromMaskRadiusValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // hexagonal pixellate
    
    var xHexagonalPixellateValue: CGFloat = 0.0 {
        didSet { windowController?.updateHexagonalPixellate(with: xHexagonalPixellateValue, y: yHexagonalPixellateValue, scale: hexagonalPixellateScaleValue) }
    }
    var yHexagonalPixellateValue: CGFloat = 0.0 {
        didSet { windowController?.updateHexagonalPixellate(with: xHexagonalPixellateValue, y: yHexagonalPixellateValue, scale: hexagonalPixellateScaleValue) }
    }
    var hexagonalPixellateScaleValue: Double = 20.0 {
        didSet { windowController?.updateHexagonalPixellate(with: xHexagonalPixellateValue, y: yHexagonalPixellateValue, scale: hexagonalPixellateScaleValue) }
    }
    
    @IBOutlet weak var xHexagonalPixellateSlider: NSSlider!
    @IBOutlet weak var yHexagonalPixellateSlider: NSSlider!
    @IBOutlet weak var hexagonalPixellateScaleSlider: NSSlider!
    @IBAction func getXHexagonalPixellateValue(_ sender: NSSlider) {
        xHexagonalPixellateValueTextField.stringValue = String(sender.integerValue)
        self.xHexagonalPixellateValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYHexagonalPixellateValue(_ sender: NSSlider) {
        yHexagonalPixellateValueTextField.stringValue = String(sender.integerValue)
        self.yHexagonalPixellateValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getHexagonalPixellateScaleValue(_ sender: NSSlider) {
        hexagonalPixellateScaleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.hexagonalPixellateScaleValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xHexagonalPixellateValueTextField: NSTextField!
    @IBOutlet weak var yHexagonalPixellateValueTextField: NSTextField!
    @IBOutlet weak var hexagonalPixellateScaleTextField: NSTextField!
    @IBAction func getXHexagonalPixellateValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xHexagonalPixellateSlider.minValue {
                xHexagonalPixellateSlider.doubleValue = xHexagonalPixellateSlider.minValue
            } else if Double(sender.stringValue)! > xHexagonalPixellateSlider.maxValue {
                xHexagonalPixellateSlider.doubleValue = xHexagonalPixellateSlider.maxValue
            } else {
                xHexagonalPixellateSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xHexagonalPixellateValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYHexagonalPixellateValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yHexagonalPixellateSlider.minValue {
                yHexagonalPixellateSlider.doubleValue = yHexagonalPixellateSlider.minValue
            } else if Double(sender.stringValue)! > yHexagonalPixellateSlider.maxValue {
                yHexagonalPixellateSlider.doubleValue = yHexagonalPixellateSlider.maxValue
            } else {
                yHexagonalPixellateSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yHexagonalPixellateValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getHexagonalPixellateScaleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < hexagonalPixellateScaleSlider.minValue {
                hexagonalPixellateScaleSlider.doubleValue = hexagonalPixellateScaleSlider.minValue
            } else if Double(sender.stringValue)! > hexagonalPixellateScaleSlider.maxValue {
                hexagonalPixellateScaleSlider.doubleValue = hexagonalPixellateScaleSlider.maxValue
            } else {
                hexagonalPixellateScaleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.hexagonalPixellateScaleValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // highlight/shadow adjust
    
    var highlightValue: Double = 0.5 {
        didSet { windowController?.updateHighlightShadow(with: highlightValue, shadow: shadowValue) }
    }
    var shadowValue: Double = -0.3 {
        didSet { windowController?.updateHighlightShadow(with: highlightValue, shadow: shadowValue) }
    }
    
    @IBOutlet weak var highlightSlider: NSSlider!
    @IBOutlet weak var shadowSlider: NSSlider!
    @IBAction func getHighlight(_ sender: NSSlider) {
        highlightTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.highlightValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getShadow(_ sender: NSSlider) {
        shadowTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.shadowValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var highlightTextField: NSTextField!
    @IBOutlet weak var shadowTextField: NSTextField!
    @IBAction func getHighlightT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < highlightSlider.minValue {
                highlightSlider.doubleValue = highlightSlider.minValue
            } else if Double(sender.stringValue)! > highlightSlider.maxValue {
                highlightSlider.doubleValue = highlightSlider.maxValue
            } else {
                highlightSlider.doubleValue = Double(sender.stringValue)!
            }
            self.highlightValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getShadowT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < shadowSlider.minValue {
                shadowSlider.doubleValue = shadowSlider.minValue
            } else if Double(sender.stringValue)! > shadowSlider.maxValue {
                shadowSlider.doubleValue = shadowSlider.maxValue
            } else {
                shadowSlider.doubleValue = Double(sender.stringValue)!
            }
            self.shadowValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // line overlay
    
    var lineOverlayNRNoiseLevelValue: Double = 0.01 {
        didSet { windowController?.updateLineOverlay(with: lineOverlayNRNoiseLevelValue, NRSharpness: lineOverlayNRSharpnessValue, edgeIntensity: lineOverlayEdgeIntensityValue, threshold: lineOverlayThresholdValue, contrast: lineOverlayContrastValue) }
    }
    var lineOverlayNRSharpnessValue: Double = 3.0 {
        didSet { windowController?.updateLineOverlay(with: lineOverlayNRNoiseLevelValue, NRSharpness: lineOverlayNRSharpnessValue, edgeIntensity: lineOverlayEdgeIntensityValue, threshold: lineOverlayThresholdValue, contrast: lineOverlayContrastValue) }
    }
    var lineOverlayEdgeIntensityValue: Double = 2.0 {
        didSet { windowController?.updateLineOverlay(with: lineOverlayNRNoiseLevelValue, NRSharpness: lineOverlayNRSharpnessValue, edgeIntensity: lineOverlayEdgeIntensityValue, threshold: lineOverlayThresholdValue, contrast: lineOverlayContrastValue) }
    }
    var lineOverlayThresholdValue: Double = 1.5 {
        didSet { windowController?.updateLineOverlay(with: lineOverlayNRNoiseLevelValue, NRSharpness: lineOverlayNRSharpnessValue, edgeIntensity: lineOverlayEdgeIntensityValue, threshold: lineOverlayThresholdValue, contrast: lineOverlayContrastValue) }
    }
    var lineOverlayContrastValue = 0.25 {
        didSet { windowController?.updateLineOverlay(with: lineOverlayNRNoiseLevelValue, NRSharpness: lineOverlayNRSharpnessValue, edgeIntensity: lineOverlayEdgeIntensityValue, threshold: lineOverlayThresholdValue, contrast: lineOverlayContrastValue) }
    }
    
    @IBOutlet weak var lineOverlayNRNoiseSlider: NSSlider!
    @IBOutlet weak var lineOverlayNRSharpnessSlider: NSSlider!
    @IBOutlet weak var lineOverlayEdgeIntensitySlider: NSSlider!
    @IBOutlet weak var lineOverlayThresholdSlider: NSSlider!
    @IBOutlet weak var lineOverlayContrastSlider: NSSlider!
    @IBAction func getLineOverlayNRNoise(_ sender: NSSlider) {
        lineOverlayNRNoiseLevelValueTextField.stringValue = String(sender.doubleValue)
        self.lineOverlayNRNoiseLevelValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getLineOverlayNRSharpness(_ sender: NSSlider) {
        lineOverlayNRSharpnessValueTextField.stringValue = String(sender.doubleValue)
        self.lineOverlayNRSharpnessValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getLineOverlayEdgeIntensity(_ sender: NSSlider) {
        lineOverlayEdgeIntensityTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.lineOverlayEdgeIntensityValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getLineOverlayThreshold(_ sender: NSSlider) {
        lineOverlayThresholdTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.lineOverlayThresholdValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBAction func getlineOverlayContrast(_ sender: NSSlider) {
        lineOverlayContrastTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.lineOverlayContrastValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var lineOverlayNRNoiseLevelValueTextField: NSTextField!
    @IBOutlet weak var lineOverlayNRSharpnessValueTextField: NSTextField!
    @IBOutlet weak var lineOverlayEdgeIntensityTextField: NSTextField!
    @IBOutlet weak var lineOverlayThresholdTextField: NSTextField!
    @IBOutlet weak var lineOverlayContrastTextField: NSTextField!
    @IBAction func getLineOverlayNRNoiseT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < lineOverlayNRNoiseSlider.minValue {
                lineOverlayNRNoiseSlider.doubleValue = lineOverlayNRNoiseSlider.minValue
            } else if Double(sender.stringValue)! > lineOverlayNRNoiseSlider.maxValue {
                lineOverlayNRNoiseSlider.doubleValue = lineOverlayNRNoiseSlider.maxValue
            } else {
                lineOverlayNRNoiseSlider.doubleValue = Double(sender.stringValue)!
            }
            self.lineOverlayNRNoiseLevelValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getLineOverlayNRSharpnessT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < lineOverlayNRSharpnessSlider.minValue {
                lineOverlayNRSharpnessSlider.doubleValue = lineOverlayNRSharpnessSlider.minValue
            } else if Double(sender.stringValue)! > lineOverlayNRSharpnessSlider.maxValue {
                lineOverlayNRSharpnessSlider.doubleValue = lineOverlayNRSharpnessSlider.maxValue
            } else {
                lineOverlayNRSharpnessSlider.doubleValue = Double(sender.stringValue)!
            }
            self.lineOverlayNRSharpnessValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getLineOverlayEdgeIntensityT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < lineOverlayEdgeIntensitySlider.minValue {
                lineOverlayEdgeIntensitySlider.doubleValue = lineOverlayEdgeIntensitySlider.minValue
            } else if Double(sender.stringValue)! > lineOverlayEdgeIntensitySlider.maxValue {
                lineOverlayEdgeIntensitySlider.doubleValue = lineOverlayEdgeIntensitySlider.maxValue
            } else {
                lineOverlayEdgeIntensitySlider.doubleValue = Double(sender.stringValue)!
            }
            self.lineOverlayEdgeIntensityValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getLineOverlayThresholdT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < lineOverlayThresholdSlider.minValue {
                lineOverlayThresholdSlider.doubleValue = lineOverlayThresholdSlider.minValue
            } else if Double(sender.stringValue)! > lineOverlayThresholdSlider.maxValue {
                lineOverlayThresholdSlider.doubleValue = lineOverlayThresholdSlider.maxValue
            } else {
                lineOverlayThresholdSlider.doubleValue = Double(sender.stringValue)!
            }
            self.lineOverlayThresholdValue = Double(sender.stringValue)!
        }
    }
    @IBAction func getlineOverlayContrastT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < lineOverlayContrastSlider.minValue {
                lineOverlayContrastSlider.doubleValue = lineOverlayContrastSlider.minValue
            } else if Double(sender.stringValue)! > lineOverlayContrastSlider.maxValue {
                lineOverlayContrastSlider.doubleValue = lineOverlayContrastSlider.maxValue
            } else {
                lineOverlayContrastSlider.doubleValue = Double(sender.stringValue)!
            }
            self.lineOverlayContrastValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // pixellate
    
    var xPixellateValue: CGFloat = 0.0 {
        didSet { windowController?.updatePixellate(with: xPixellateValue, y: yPixellateValue, scale: pixellateScaleValue) }
    }
    var yPixellateValue: CGFloat = 0.0 {
        didSet { windowController?.updatePixellate(with: xPixellateValue, y: yPixellateValue, scale: pixellateScaleValue) }
    }
    var pixellateScaleValue: Double = 20.0 {
        didSet { windowController?.updatePixellate(with: xPixellateValue, y: yPixellateValue, scale: pixellateScaleValue) }
    }
    
    @IBOutlet weak var xPixellateSlider: NSSlider!
    @IBOutlet weak var yPixellateSlider: NSSlider!
    @IBOutlet weak var pixellateScaleSlider: NSSlider!
    @IBAction func getXPixellateValue(_ sender: NSSlider) {
        xPixellateValueTextField.stringValue = String(sender.integerValue)
        self.xPixellateValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYPixellateValue(_ sender: NSSlider) {
        yPixellateValueTextField.stringValue = String(sender.integerValue)
        self.yPixellateValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getPixellateScaleValue(_ sender: NSSlider) {
        pixellateScaleTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.pixellateScaleValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xPixellateValueTextField: NSTextField!
    @IBOutlet weak var yPixellateValueTextField: NSTextField!
    @IBOutlet weak var pixellateScaleTextField: NSTextField!
    @IBAction func getXPixellateValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xPixellateSlider.minValue {
                xPixellateSlider.doubleValue = xPixellateSlider.minValue
            } else if Double(sender.stringValue)! > xPixellateSlider.maxValue {
                xPixellateSlider.doubleValue = xPixellateSlider.maxValue
            } else {
                xPixellateSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xPixellateValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYPixellateValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yPixellateSlider.minValue {
                yPixellateSlider.doubleValue = yPixellateSlider.minValue
            } else if Double(sender.stringValue)! > yPixellateSlider.maxValue {
                yPixellateSlider.doubleValue = yPixellateSlider.maxValue
            } else {
                yPixellateSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yPixellateValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getPixellateScaleT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < pixellateScaleSlider.minValue {
                pixellateScaleSlider.doubleValue = pixellateScaleSlider.minValue
            } else if Double(sender.stringValue)! > pixellateScaleSlider.maxValue {
                pixellateScaleSlider.doubleValue = pixellateScaleSlider.maxValue
            } else {
                pixellateScaleSlider.doubleValue = Double(sender.stringValue)!
            }
            self.pixellateScaleValue = Double(sender.stringValue)!
        }
    }
    
    //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
    // pointillize
    
    var xPointillizeValue: CGFloat = 0.0 {
        didSet { windowController?.updatePointillize(with: xPointillizeValue, y: yPointillizeValue, radius: pointillizeRadiusValue) }
    }
    var yPointillizeValue: CGFloat = 0.0 {
        didSet { windowController?.updatePointillize(with: xPointillizeValue, y: yPointillizeValue, radius: pointillizeRadiusValue) }
    }
    var pointillizeRadiusValue: Double = 20.0 {
        didSet { windowController?.updatePointillize(with: xPointillizeValue, y: yPointillizeValue, radius: pointillizeRadiusValue) }
    }
    
    @IBOutlet weak var xPointillizeSlider: NSSlider!
    @IBOutlet weak var yPointillizeSlider: NSSlider!
    @IBOutlet weak var pointillizeRadiusSlider: NSSlider!
    @IBAction func getXPointillizeValue(_ sender: NSSlider) {
        xPointillizeValueTextField.stringValue = String(sender.integerValue)
        self.xPointillizeValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYPointillizeValue(_ sender: NSSlider) {
        yPointillizeValueTextField.stringValue = String(sender.integerValue)
        self.yPointillizeValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getPointillizeRadiusValue(_ sender: NSSlider) {
        pointillizeRadiusTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.pointillizeRadiusValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xPointillizeValueTextField: NSTextField!
    @IBOutlet weak var yPointillizeValueTextField: NSTextField!
    @IBOutlet weak var pointillizeRadiusTextField: NSTextField!
    @IBAction func getXPointillizeValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < xPointillizeSlider.minValue {
                xPointillizeSlider.doubleValue = xPointillizeSlider.minValue
            } else if Double(sender.stringValue)! > xPointillizeSlider.maxValue {
                xPointillizeSlider.doubleValue = xPointillizeSlider.maxValue
            } else {
                xPointillizeSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xPointillizeValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYPointillizeValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < yPointillizeSlider.minValue {
                yPointillizeSlider.doubleValue = yPointillizeSlider.minValue
            } else if Double(sender.stringValue)! > yPointillizeSlider.maxValue {
                yPointillizeSlider.doubleValue = yPointillizeSlider.maxValue
            } else {
                yPointillizeSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yPointillizeValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getPointillizeRadiusValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < pointillizeRadiusSlider.minValue {
                pointillizeRadiusSlider.doubleValue = pointillizeRadiusSlider.minValue
            } else if Double(sender.stringValue)! > pointillizeRadiusSlider.maxValue {
                pointillizeRadiusSlider.doubleValue = pointillizeRadiusSlider.maxValue
            } else {
                pointillizeRadiusSlider.doubleValue = Double(sender.stringValue)!
            }
            self.pointillizeRadiusValue = Double(sender.stringValue)!
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = windowController?.originalCIImage {
            
            self.image = image
            
            if let centerXSlider = centerXZoomSlider,
                let centerYSlider = centerYZoomSlider,
                let xZoomValueTextField = xZoomValueTextField,
                let yZoomValueTextField = yZoomValueTextField {
                centerXSlider.maxValue = Double(image.extent.size.width)
                centerYSlider.maxValue = Double(image.extent.size.height)
                centerXSlider.doubleValue = Double(image.extent.size.width / 2)
                centerYSlider.doubleValue = Double(image.extent.size.height / 2)
                xZoomValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                yZoomValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                xZoomValue = image.extent.size.width / 2
                yZoomValue = image.extent.size.height / 2
            }
            
            if let falseColor0Field = falseColor0Field,
                let falseColor1Field = falseColor1Field {
                falseColor0Field.backgroundColor = NSColor(ciColor: CIColor(red: 0.0, green: 0.0, blue: 100 / 256))
                falseColor1Field.backgroundColor = NSColor(ciColor: CIColor(red: 255 / 256, green: 200 / 256, blue: 255 / 256))
            }
            
            if let xVignetteSlider = xVignetteSlider,
                let yVignetteSlider = yVignetteSlider,
                let xVignetteValueTextField = xVignetteValueTextField,
                let yVignetteValueTextField = yVignetteValueTextField,
                let vignetteEffectRadiusSlider = vignetteEffectRadiusSlider {
                xVignetteSlider.maxValue = Double(image.extent.size.width)
                xVignetteSlider.doubleValue = Double(image.extent.size.width) / 2
                xVignetteValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                yVignetteSlider.maxValue = Double(image.extent.size.height)
                yVignetteSlider.doubleValue = Double(image.extent.size.height) / 2
                yVignetteValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                if image.extent.size.width < image.extent.size.height {
                    vignetteEffectRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    vignetteEffectRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                xVignetteValue = image.extent.size.width / 2
                yVignetteValue = image.extent.size.height / 2
                vignetteEffectRadiusValue = Double(image.extent.size.width / 8).roundTo(places: 0)
                vignetteEffectRadiusSlider.doubleValue = Double(image.extent.size.width) / 8
                vignetteEffectRadiusTextField.stringValue = String(Double(image.extent.size.width) / 8)
            }
            
            if let xBumpDistortionSlider = xBumpDistortionSlider,
                let yBumpDistortionSlider = yBumpDistortionSlider,
                let bumpDistortionRadiusSlider = bumpDistortionRadiusSlider,
                let xBumpDistortionValueTextField = xBumpDistortionValueTextField,
                let yBumpDistortionValueTextField = yBumpDistortionValueTextField,
                let bumpDistortionRadiusTextField = bumpDistortionRadiusTextField {
                xBumpDistortionSlider.maxValue = Double(image.extent.size.width)
                xBumpDistortionSlider.doubleValue = Double(image.extent.size.width / 2)
                xBumpDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xBumpDistortionValue = image.extent.size.width / 2
                yBumpDistortionSlider.maxValue = Double(image.extent.size.height)
                yBumpDistortionSlider.doubleValue = Double(image.extent.size.height) / 2
                yBumpDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yBumpDistortionValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    bumpDistortionRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    bumpDistortionRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                bumpDistortionRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                bumpDistortionRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                bumpDistortionRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let xBumpDistortionLinearSlider = xBumpDistortionLinearSlider,
                let yBumpDistortionLinearSlider = yBumpDistortionLinearSlider,
                let bumpDistortionLinearRadiusSlider = bumpDistortionLinearRadiusSlider,
                let xBumpDistortionLinearValueTextField = xBumpDistortionLinearValueTextField,
                let yBumpDistortionLinearValueTextField = yBumpDistortionLinearValueTextField,
                let bumpDistortionLinearRadiusTextField = bumpDistortionLinearRadiusTextField {
                xBumpDistortionLinearSlider.maxValue = Double(image.extent.size.width)
                xBumpDistortionLinearSlider.doubleValue = Double(image.extent.size.width / 2)
                xBumpDistortionLinearValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xBumpDistortionLinearValue = image.extent.size.width / 2
                yBumpDistortionLinearSlider.maxValue = Double(image.extent.size.height)
                yBumpDistortionLinearSlider.doubleValue = Double(image.extent.size.height) / 2
                yBumpDistortionLinearValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yBumpDistortionLinearValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    bumpDistortionLinearRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    bumpDistortionLinearRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                bumpDistortionLinearRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                bumpDistortionLinearRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                bumpDistortionLinearRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let xCircleSplashDistortionSlider = xCircleSplashDistortionSlider,
                let yCircleSplashDistortionSlider = yCircleSplashDistortionSlider,
                let xCircleSplashDistortionValueTextField = xCircleSplashDistortionValueTextField,
                let yCircleSplashDistortionValueTextField = yCircleSplashDistortionValueTextField,
                let circleSplashDistortionRadiusSlider = circleSplashDistortionRadiusSlider,
                let circleSplashDistortionRadiusTextField = circleSplashDistortionRadiusTextField {
                xCircleSplashDistortionSlider.maxValue = Double(image.extent.size.width)
                xCircleSplashDistortionSlider.doubleValue = Double(image.extent.size.width / 2)
                xCircleSplashDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xCircleSplashDistortionValue = image.extent.size.width / 2
                yCircleSplashDistortionSlider.maxValue = Double(image.extent.size.height)
                yCircleSplashDistortionSlider.doubleValue = Double(image.extent.size.height / 2)
                yCircleSplashDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yCircleSplashDistortionValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    circleSplashDistortionRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    circleSplashDistortionRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                circleSplashDistortionRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                circleSplashDistortionRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                circleSplashDistortionRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let xCircularWrapSlider = xCircularWrapSlider,
                let yCircularWrapSlider = yCircularWrapSlider,
                let xCircularWrapValueTextField = xCircularWrapValueTextField,
                let yCircularWrapValueTextField = yCircularWrapValueTextField,
                let circularWrapRadiusSlider = circularWrapRadiusSlider,
                let circularWrapRadiusTextField = circularWrapRadiusTextField {
                xCircularWrapSlider.maxValue = Double(image.extent.size.width)
                xCircularWrapSlider.doubleValue = Double(image.extent.size.width / 2)
                xCircularWrapValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xCircularWrapValue = image.extent.size.width / 2
                yCircularWrapSlider.maxValue = Double(image.extent.size.height)
                yCircularWrapSlider.doubleValue = Double(image.extent.size.height / 2)
                yCircularWrapValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yCircularWrapValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    circularWrapRadiusSlider.maxValue = 0.5 * Double(image.extent.size.height)
                } else {
                    circularWrapRadiusSlider.maxValue = 0.5 * Double(image.extent.size.width)
                }
                circularWrapRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                circularWrapRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                circularWrapRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let xGlassDistortionSlider = xGlassDistortionSlider,
                let yGlassDistortionSlider = yGlassDistortionSlider {
                xGlassDistortionSlider.maxValue = Double(image.extent.size.width / 10)
                yGlassDistortionSlider.maxValue = Double(image.extent.size.height / 10)
            }
            
            if let xHoleDistortionSlider = xHoleDistortionSlider,
                let yHoleDistortionSlider = yHoleDistortionSlider,
                let holeDistortionRadiusSlider = holeDistortionRadiusSlider,
                let xHoleDistortionValueTextField = xHoleDistortionValueTextField,
                let yHoleDistortionValueTextField = yHoleDistortionValueTextField,
                let holeDistortionRadiusTextField = holeDistortionRadiusTextField {
                xHoleDistortionSlider.maxValue = Double(image.extent.size.width)
                xHoleDistortionSlider.doubleValue = Double(image.extent.size.width / 2)
                xHoleDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xHoleDistortionValue = image.extent.size.width / 2
                yHoleDistortionSlider.maxValue = Double(image.extent.size.height)
                yHoleDistortionSlider.doubleValue = Double(image.extent.size.height / 2)
                yHoleDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yHoleDistortionValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    holeDistortionRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    holeDistortionRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                holeDistortionRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                holeDistortionRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                holeDistortionRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let xLightTunnelSlider = xLightTunnelSlider,
                let yLightTunnelSlider = yLightTunnelSlider,
                let lightTunnelRadiusSlider = lightTunnelRadiusSlider,
                let xLightTunnelValueTextField = xLightTunnelValueTextField,
                let yLightTunnelValueTextField = yLightTunnelValueTextField,
                let lightTunnelRadiusTextField = lightTunnelRadiusTextField {
                xLightTunnelSlider.maxValue = Double(image.extent.size.width)
                xLightTunnelSlider.doubleValue = Double(image.extent.size.width / 2)
                xLightTunnelValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xLightTunnelValue = image.extent.size.width / 2
                yLightTunnelSlider.maxValue = Double(image.extent.size.height)
                yLightTunnelSlider.doubleValue = Double(image.extent.size.height / 2)
                yLightTunnelValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yLightTunnelValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    lightTunnelRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    lightTunnelRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                lightTunnelRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                lightTunnelRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                lightTunnelRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let xPinchDistortionSlider = xPinchDistortionSlider,
                let yPinchDistortionSlider = yPinchDistortionSlider,
                let pinchDistortionRadiusSlider = pinchDistortionRadiusSlider,
                let xPinchDistortionValueTextField = xPinchDistortionValueTextField,
                let yPinchDistortionValueTextField = yPinchDistortionValueTextField,
                let pinchDistortionRadiusTextField = pinchDistortionRadiusTextField {
                xPinchDistortionSlider.maxValue = Double(image.extent.size.width)
                xPinchDistortionSlider.doubleValue = Double(image.extent.size.width / 2)
                xPinchDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xPinchDistortionValue = image.extent.size.width / 2
                yPinchDistortionSlider.maxValue = Double(image.extent.size.height)
                yPinchDistortionSlider.doubleValue = Double(image.extent.size.height / 2)
                yPinchDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yPinchDistortionValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    pinchDistortionRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    pinchDistortionRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                pinchDistortionRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                pinchDistortionRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                pinchDistortionRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let stretchCropWidthSlider = stretchCropWidthSlider,
                let stretchCropHeightSlider = stretchCropHeightSlider,
                let stretchCropWidthTextField = stretchCropWidthTextField,
                let stretchCropHeightTextField = stretchCropHeightTextField {
                stretchCropWidthSlider.maxValue = Double(image.extent.size.width * 2)
                stretchCropWidthSlider.doubleValue = Double(image.extent.size.width * 1.5)
                stretchCropWidthTextField.stringValue = String(describing: Int(image.extent.size.width * 1.5))
                stretchCropWidthValue = image.extent.size.width * 1.5
                stretchCropHeightSlider.maxValue = Double(image.extent.size.height * 2)
                stretchCropHeightSlider.doubleValue = Double(image.extent.size.height)
                stretchCropHeightTextField.stringValue = String(describing: Int(image.extent.size.height))
                stretchCropHeightValue = image.extent.size.height
            }
            
            if let xTorusLensDistortionSlider = xTorusLensDistortionSlider,
                let xTorusLensDistortionValueTextField = xTorusLensDistortionValueTextField,
                let yTorusLensDistortionSlider = yTorusLensDistortionSlider,
                let yTorusLensDistortionValueTextField = yTorusLensDistortionValueTextField,
                let torusLensDistortionRadiusSlider = torusLensDistortionRadiusSlider,
                let torusLensDistortionRadiusTextField = torusLensDistortionRadiusTextField,
                let torusLensDistortionWidthSlider = torusLensDistortionWidthSlider,
                let torusLensDistortionWidthTextField = torusLensDistortionWidthTextField {
                xTorusLensDistortionSlider.maxValue = Double(image.extent.size.width)
                xTorusLensDistortionSlider.doubleValue = Double(image.extent.size.width / 2)
                xTorusLensDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xTorusLensDistortionValue = image.extent.size.width / 2
                yTorusLensDistortionSlider.maxValue = Double(image.extent.size.height)
                yTorusLensDistortionSlider.doubleValue = Double(image.extent.size.height / 2)
                yTorusLensDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yTorusLensDistortionValue = image.extent.size.height / 2
                
                if image.extent.size.width < image.extent.size.height {
                    torusLensDistortionRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    torusLensDistortionRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                torusLensDistortionRadiusSlider.doubleValue = Double(image.extent.size.width / 4)
                torusLensDistortionRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 4))
                torusLensDistortionRadiusValue = Double(image.extent.size.width / 4)
                torusLensDistortionWidthSlider.maxValue = torusLensDistortionRadiusSlider.maxValue
                torusLensDistortionWidthSlider.doubleValue = Double(image.extent.size.width / 8)
                torusLensDistortionWidthTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                torusLensDistortionWidthValue = Double(image.extent.size.width / 8)
            }
            
            if let xTwirlDistortionSlider = xTwirlDistortionSlider,
                let xTwirlDistortionValueTextField = xTwirlDistortionValueTextField,
                let yTwirlDistortionSlider = yTwirlDistortionSlider,
                let yTwirlDistortionValueTextField = yTwirlDistortionValueTextField,
                let twirlDistortionRadiusSlider = twirlDistortionRadiusSlider,
                let twirlDistortionRadiusTextField = twirlDistortionRadiusTextField {
                xTwirlDistortionSlider.maxValue = Double(image.extent.size.width)
                xTwirlDistortionSlider.doubleValue = Double(image.extent.size.width / 2)
                xTwirlDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xTwirlDistortionValue = image.extent.size.width / 2
                yTwirlDistortionSlider.maxValue = Double(image.extent.size.height)
                yTwirlDistortionSlider.doubleValue = Double(image.extent.size.height / 2)
                yTwirlDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yTwirlDistortionValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    twirlDistortionRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    twirlDistortionRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                twirlDistortionRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                twirlDistortionRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                twirlDistortionRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let xVortexDistortionSlider = xVortexDistortionSlider,
                let xVortexDistortionValueTextField = xVortexDistortionValueTextField,
                let yVortexDistortionSlider = yVortexDistortionSlider,
                let yVortexDistortionValueTextField = yVortexDistortionValueTextField,
                let vortexDistortionRadiusSlider = vortexDistortionRadiusSlider,
                let vortexDistortionRadiusTextField = vortexDistortionRadiusTextField {
                xVortexDistortionSlider.maxValue = Double(image.extent.size.width)
                xVortexDistortionSlider.doubleValue = Double(image.extent.size.width / 2)
                xVortexDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.width / 2))
                xVortexDistortionValue = image.extent.size.width / 2
                yVortexDistortionSlider.maxValue = Double(image.extent.size.height)
                yVortexDistortionSlider.doubleValue = Double(image.extent.size.height / 2)
                yVortexDistortionValueTextField.stringValue = String(describing: Int(image.extent.size.height / 2))
                yVortexDistortionValue = image.extent.size.height / 2
                if image.extent.size.width < image.extent.size.height {
                    vortexDistortionRadiusSlider.maxValue = Double(image.extent.size.height)
                } else {
                    vortexDistortionRadiusSlider.maxValue = Double(image.extent.size.width)
                }
                vortexDistortionRadiusSlider.doubleValue = Double(image.extent.size.width / 8)
                vortexDistortionRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 8))
                vortexDistortionRadiusValue = Double(image.extent.size.width / 8)
            }
            
            if let xCrystallizeSlider = xCrystallizeSlider,
                let xCrystallizeValueTextField = xCrystallizeValueTextField,
                let yCrystallizeSlider = yCrystallizeSlider,
                let yCrystallizeValueTextField = yCrystallizeValueTextField,
                let crystallizeRadiusSlider = crystallizeRadiusSlider,
                let crystallizeRadiusTextField = crystallizeRadiusTextField {
                xCrystallizeSlider.maxValue = Double(image.extent.size.width) / 100
                xCrystallizeSlider.doubleValue = Double(image.extent.size.width / 200)
                xCrystallizeValueTextField.stringValue = String(describing: Int(image.extent.size.width / 200))
                xCrystallizeValue = image.extent.size.width / 200
                yCrystallizeSlider.maxValue = Double(image.extent.size.height) / 100
                yCrystallizeSlider.doubleValue = Double(image.extent.size.height / 200)
                yCrystallizeValueTextField.stringValue = String(describing: Int(image.extent.size.height / 200))
                yCrystallizeValue = image.extent.size.height / 200
                if image.extent.size.width < image.extent.size.height {
                    crystallizeRadiusSlider.maxValue = Double(image.extent.size.height) / 10
                } else {
                    crystallizeRadiusSlider.maxValue = Double(image.extent.size.width) / 10
                }
                crystallizeRadiusSlider.doubleValue = Double(image.extent.size.width / 80)
                crystallizeRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 80))
                crystallizeRadiusValue = Double(image.extent.size.width / 80)
            }
            
            if let xHexagonalPixellateSlider = xHexagonalPixellateSlider,
                let xHexagonalPixellateValueTextField = xHexagonalPixellateValueTextField,
                let yHexagonalPixellateSlider = yHexagonalPixellateSlider,
                let yHexagonalPixellateValueTextField = yHexagonalPixellateValueTextField,
                let hexagonalPixellateScaleSlider = hexagonalPixellateScaleSlider,
                let hexagonalPixellateScaleTextField = hexagonalPixellateScaleTextField {
                xHexagonalPixellateSlider.maxValue = Double(image.extent.size.width) / 100
                xHexagonalPixellateSlider.doubleValue = Double(image.extent.size.width / 200)
                xHexagonalPixellateValueTextField.stringValue = String(describing: Int(image.extent.size.width / 200))
                xHexagonalPixellateValue = image.extent.size.width / 200
                yHexagonalPixellateSlider.maxValue = Double(image.extent.size.height) / 100
                yHexagonalPixellateSlider.doubleValue = Double(image.extent.size.height / 200)
                yHexagonalPixellateValueTextField.stringValue = String(describing: Int(image.extent.size.height / 200))
                yHexagonalPixellateValue = image.extent.size.height / 200
                if image.extent.size.width < image.extent.size.height {
                    hexagonalPixellateScaleSlider.maxValue = Double(image.extent.size.height) / 10
                } else {
                    hexagonalPixellateScaleSlider.maxValue = Double(image.extent.size.width) / 10
                }
                hexagonalPixellateScaleSlider.doubleValue = Double(image.extent.size.width / 80)
                hexagonalPixellateScaleTextField.stringValue = String(describing: Int(image.extent.size.width / 80))
                hexagonalPixellateScaleValue = Double(image.extent.size.width / 80)
            }
            
            if let xPixellateSlider = xPixellateSlider,
                let xPixellateValueTextField = xPixellateValueTextField,
                let yPixellateSlider = yPixellateSlider,
                let yPixellateValueTextField = yPixellateValueTextField,
                let pixellateScaleSlider = pixellateScaleSlider,
                let pixellateScaleTextField = pixellateScaleTextField {
                xPixellateSlider.maxValue = Double(image.extent.size.width) / 100
                xPixellateSlider.doubleValue = Double(image.extent.size.width / 200)
                xPixellateValueTextField.stringValue = String(describing: Int(image.extent.size.width / 200))
                xPixellateValue = image.extent.size.width / 200
                yPixellateSlider.maxValue = Double(image.extent.size.height) / 100
                yPixellateSlider.doubleValue = Double(image.extent.size.height / 200)
                yPixellateValueTextField.stringValue = String(describing: Int(image.extent.size.height / 200))
                yPixellateValue = image.extent.size.height / 200
                if image.extent.size.width < image.extent.size.height {
                    pixellateScaleSlider.maxValue = Double(image.extent.size.height) / 10
                } else {
                    pixellateScaleSlider.maxValue = Double(image.extent.size.width) / 10
                }
                pixellateScaleSlider.doubleValue = Double(image.extent.size.width / 80)
                pixellateScaleTextField.stringValue = String(describing: Int(image.extent.size.width / 80))
                pixellateScaleValue = Double(image.extent.size.width / 80)
            }
            
            if let xPointillizeSlider = xPointillizeSlider,
                let xPointillizeValueTextField = xPointillizeValueTextField,
                let yPointillizeSlider = yPointillizeSlider,
                let yPointillizeValueTextField = yPointillizeValueTextField,
                let pointillizeRadiusSlider = pointillizeRadiusSlider,
                let pointillizeRadiusTextField = pointillizeRadiusTextField {
                xPointillizeSlider.maxValue = Double(image.extent.size.width) / 100
                xPointillizeSlider.doubleValue = Double(image.extent.size.width / 200)
                xPointillizeValueTextField.stringValue = String(describing: Int(image.extent.size.width / 200))
                xPointillizeValue = image.extent.size.width / 200
                yPointillizeSlider.maxValue = Double(image.extent.size.height) / 100
                yPointillizeSlider.doubleValue = Double(image.extent.size.height / 200)
                yPointillizeValueTextField.stringValue = String(describing: Int(image.extent.size.height / 200))
                yPointillizeValue = image.extent.size.height / 200
                if image.extent.size.width < image.extent.size.height {
                    pointillizeRadiusSlider.maxValue = Double(image.extent.size.height) / 10
                } else {
                    pointillizeRadiusSlider.maxValue = Double(image.extent.size.width) / 10
                }
                pointillizeRadiusSlider.doubleValue = Double(image.extent.size.width / 80)
                pointillizeRadiusTextField.stringValue = String(describing: Int(image.extent.size.width / 80))
                pointillizeRadiusValue = Double(image.extent.size.width / 80)
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
