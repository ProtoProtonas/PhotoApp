//
//  ViewController.swift
//  PhotoApp
//
//  Created by Pixelmator on 6/12/17.
//  Copyright © 2017 Pixelmator. All rights reserved.
//

import Cocoa
import MetalKit

class ViewController: NSViewController, MTKViewDelegate {
    
    var image: CIImage? = nil
    var size: CGSize = .zero
    
    @IBOutlet weak var mtkView: MTKView! {
        didSet {
            mtkView.isPaused = true
            mtkView.preferredFramesPerSecond = 30
            mtkView.clearColor = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    
    @IBOutlet var scrollView: NSScrollView?
    
    let metalDevice: MTLDevice = MTLCreateSystemDefaultDevice()!
    var commandQueue: MTLCommandQueue { return metalDevice.makeCommandQueue() }
    let context = CIContext()
    
    func draw(in view: MTKView) {
        
        view.preferredFramesPerSecond = 30
        view.isPaused = true
        
        
        
        if size == .zero {
            size = image!.extent.size
            view.drawableSize = size
        }
        
        if let drawable = view.currentDrawable {
            let commandBuffer = commandQueue.makeCommandBuffer()
            if let image = image {
                try! context.startTask(toRender: image, to: CIRenderDestination(mtlTexture: drawable.texture, commandBuffer: commandBuffer))
            }
            commandBuffer.present(drawable)
            commandBuffer.commit()
            commandBuffer.waitUntilCompleted()
            view.enableSetNeedsDisplay = true
            view.needsDisplay = true
            view.autoResizeDrawable = true
        }
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        NSLog("drawableSizeWillChange")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mainView = view.subviews.first as? NSScrollView,
            let clipView = mainView.subviews.first as? CenteredClipView,
            let metalView = clipView.subviews.first as? MTKView {
            metalView.delegate = self
            metalView.enableSetNeedsDisplay = true
            metalView.device = metalDevice
            metalView.framebufferOnly = false
        }
    }
    
    override var representedObject: Any? {
        didSet {
            
            // Update the view, if already loaded.
        }
    }
}
