//
//  ViewController.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/12/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var imageView: CustomImageView?
    @IBOutlet var scrollView: NSScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
