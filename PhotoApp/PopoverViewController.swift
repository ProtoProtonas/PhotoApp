//
//  PopoverViewController.swift
//  PhotoApp
//
//  Created by Pixelmator on 7/19/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController {

    @IBOutlet weak var boxBlurSlider: NSSlider?
    var boxSliderValue: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxSliderValue = boxBlurSlider?.doubleValue
        NSLog("\(String(describing: boxSliderValue))")
        // Do view setup here.
    }
    
}
