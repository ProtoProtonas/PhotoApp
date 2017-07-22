//
//  PopoverViewController.swift
//  PhotoApp
//
//  Created by Pixelmator on 7/19/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController {
    
    var boxBlurValue: Double = 50.0
    
    @IBOutlet weak var boxBlurSlider: NSSlider!
    @IBAction func getBoxBlur(_ sender: NSSlider) {
        boxBlurTextField.stringValue = String(sender.doubleValue.roundTo(places: 2))
        self.boxBlurValue = sender.doubleValue
//        NSLog("\(sender.doubleValue) ibaction")
//        NSLog("\(self.boxBlurValue) ibaction as well")
//        NSLog("\(String(describing: boxBlurSlider?.doubleValue)) ibaction too")
    }
    
    @IBOutlet weak var boxBlurTextField: NSTextField!
    @IBAction func getBoxBlurT(_ sender: NSTextField) {
        boxBlurSlider.doubleValue = Double(sender.stringValue)!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        boxBlurValue = boxBlurSlider?.doubleValue
//        NSLog("\(String(describing: boxBlurValue)) view did load")
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        // do nothing
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
