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
        self.discBlurValue = sender.doubleValue.roundTo(places: 2)
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
    
    var xValue: CGFloat = 0.0 {
        didSet { windowController?.updateZoomBlur(with: zoomAmountValue, center: CIVector(x: xValue, y: yValue)) }
    }
    var yValue: CGFloat = 0.0 {
        didSet { windowController?.updateZoomBlur(with: zoomAmountValue, center: CIVector(x: xValue, y: yValue)) }
    }
    var zoomAmountValue: Double = 0.0 {
        didSet { windowController?.updateZoomBlur(with: zoomAmountValue, center: CIVector(x: xValue, y: yValue)) }
    }
    
    @IBOutlet weak var centerXSlider: NSSlider!
    @IBOutlet weak var centerYSlider: NSSlider!
    @IBOutlet weak var zoomAmountSlider: NSSlider!
    @IBAction func getXValue(_ sender: NSSlider) {
        xValueTextField.stringValue = String(sender.integerValue)
        self.xValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getYValue(_ sender: NSSlider) {
        yValueTextField.stringValue = String(sender.integerValue)
        self.yValue = CGFloat(sender.doubleValue.roundTo(places: 2))
    }
    @IBAction func getZoomAmount(_ sender: NSSlider) {
        zoomAmountTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.zoomAmountValue = sender.doubleValue.roundTo(places: 2)
    }
    @IBOutlet weak var xValueTextField: NSTextField!
    @IBOutlet weak var yValueTextField: NSTextField!
    @IBOutlet weak var zoomAmountTextField: NSTextField!
    @IBAction func getXValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < centerXSlider.minValue {
                centerXSlider.doubleValue = centerXSlider.minValue
            } else if Double(sender.stringValue)! > centerXSlider.maxValue {
                centerXSlider.doubleValue = centerXSlider.maxValue
            } else {
                centerXSlider.doubleValue = Double(sender.stringValue)!
            }
            self.xValue = CGFloat(Double(sender.stringValue)!)
        }
    }
    @IBAction func getYValueT(_ sender: NSTextField) {
        if Double(sender.stringValue) != nil {
            if Double(sender.stringValue)! < centerYSlider.minValue {
                centerYSlider.doubleValue = centerYSlider.minValue
            } else if Double(sender.stringValue)! > centerYSlider.maxValue {
                centerYSlider.doubleValue = centerYSlider.maxValue
            } else {
                centerYSlider.doubleValue = Double(sender.stringValue)!
            }
            self.yValue = CGFloat(Double(sender.stringValue)!)
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
    // color effect filters
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = windowController?.originalImage {
            if let centerXSlider = centerXSlider,
                let centerYSlider = centerYSlider {
                centerXSlider.maxValue = Double(image.size.width)
                centerYSlider.maxValue = Double(image.size.height)
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
