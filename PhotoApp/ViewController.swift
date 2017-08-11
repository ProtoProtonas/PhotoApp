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
    
    var image: CIImage? = nil {
        didSet { mtkView.needsDisplay = true }
    }
    
    weak var windowController: WindowController? = nil
    
    @IBOutlet weak var mtkView: MTKView!
    @IBOutlet var scrollView: NSScrollView?
    
    let metalDevice: MTLDevice = MTLCreateSystemDefaultDevice()!
    var commandQueue: MTLCommandQueue { return metalDevice.makeCommandQueue() }
    let context = CIContext()
    
    
    
    func draw(in view: MTKView) {
        
        if let drawable = view.currentDrawable {
            let commandBuffer = commandQueue.makeCommandBuffer()
            if let image = image {
                
                let scale: CGFloat
                if (CGFloat(drawable.texture.width) / CGFloat(drawable.texture.height)) > (image.extent.size.width / image.extent.size.height) {
                    scale = CGFloat(drawable.texture.height) / image.extent.size.height
                } else {
                    scale = CGFloat(drawable.texture.width) / image.extent.size.width
                }
                let transformScale = CGAffineTransform(scaleX: scale, y: scale)
                var scaledImage = image.applying(transformScale)
                
                
                var translationX: CGFloat = 0.0
                var translationY: CGFloat = 0.0
                if (CGFloat(drawable.texture.width) / CGFloat(drawable.texture.height)) > (image.extent.size.width / image.extent.size.height) {
                    translationX = abs(CGFloat(drawable.texture.width) - scaledImage.extent.size.width) / 2
                } else {
                    translationY = abs(CGFloat(drawable.texture.height) - scaledImage.extent.height) / 2
                }
                let transformTranslation = CGAffineTransform(translationX: translationX, y: translationY)
                scaledImage = scaledImage.applying(transformTranslation)
                    
                    
                try! context.startTask(toRender: scaledImage, to: CIRenderDestination(mtlTexture: drawable.texture, commandBuffer: commandBuffer))
            }
            commandBuffer.present(drawable)
            commandBuffer.commit()
            commandBuffer.waitUntilCompleted()
        }
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
//        NSLog("drawableSizeWillChange")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mainView = view.subviews.first as? NSScrollView,
            let clipView = mainView.subviews.first as? CenteredClipView,
            let metalView = clipView.subviews.first as? MTKView {
            metalView.autoResizeDrawable = true
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
