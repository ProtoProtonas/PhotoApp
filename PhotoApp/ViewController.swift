//
//  ViewController.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/12/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var imageView: NSImageView?
    @IBOutlet var scrollView: NSScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(imageView)
        imageView?.image = NSImage(named: NSImage.Name(rawValue: "photo"))
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

