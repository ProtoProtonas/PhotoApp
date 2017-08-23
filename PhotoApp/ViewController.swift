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
    
    //FIXME: kai updeitini paveiksliuka reikia kviesti drawableSizeWillChange / mtkView funkcija
    var image: CIImage? = nil {
        didSet { mtkView.needsDisplay = true }
    }
    
    weak var windowController: WindowController? = nil
    
    @IBOutlet weak var mtkView: MTKView!
    @IBOutlet var scrollView: NSScrollView?
    
    let metalDevice: MTLDevice = MTLCreateSystemDefaultDevice()!
    var commandQueue: MTLCommandQueue { return metalDevice.makeCommandQueue()! }
    let context = CIContext()
    
    
    
    func draw(in view: MTKView) {
        
        if let drawable = view.currentDrawable {
            let commandBuffer = commandQueue.makeCommandBuffer()
            if var image = image {
                
                let translateImageX = -image.extent.origin.x
                let translateImageY = -image.extent.origin.y
                let imageTransformTranslation = CGAffineTransform(translationX: translateImageX, y: translateImageY)
                image = image.transformed(by: imageTransformTranslation)
                
                let scale: CGFloat
                if (CGFloat(drawable.texture.width) / CGFloat(drawable.texture.height)) > (image.extent.size.width / image.extent.size.height) {
                    scale = CGFloat(drawable.texture.height) / image.extent.size.height
                } else {
                    scale = CGFloat(drawable.texture.width) / image.extent.size.width
                }
                let transformScale = CGAffineTransform(scaleX: scale, y: scale)
                var viewingImage = image.transformed(by: transformScale)
                
                
                var translationX: CGFloat
                var translationY: CGFloat
                if (CGFloat(drawable.texture.width) / CGFloat(drawable.texture.height)) > (image.extent.size.width / image.extent.size.height) {
                    translationX = (abs(CGFloat(drawable.texture.width) - viewingImage.extent.size.width) / 2) - viewingImage.extent.origin.x
                    translationY = -viewingImage.extent.origin.y
                } else {
                    translationY = (abs(CGFloat(drawable.texture.height) - viewingImage.extent.height) / 2) - viewingImage.extent.origin.y
                    translationX = -viewingImage.extent.origin.x
                }
                let transformTranslation = CGAffineTransform(translationX: translationX, y: translationY)
                viewingImage = viewingImage.transformed(by: transformTranslation)
                
                do {
                    let renderDestination = CIRenderDestination(mtlTexture: drawable.texture, commandBuffer: commandBuffer)
                    try context.startTask(toClear: renderDestination)
                    try context.startTask(toRender: viewingImage, to: renderDestination)
                } catch {
                    NSLog("failed to render")
                }
                
                
            }
            commandBuffer!.present(drawable)
            commandBuffer!.commit()
            commandBuffer!.waitUntilCompleted()
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
            metalView.layer?.isOpaque = false
        }
        
        if let mainView = view.subviews.first as? NSScrollView,
            let clipView = mainView.subviews.first as? CenteredClipView,
            let metalView = clipView.subviews.first as? MTKView {
            (metalView.subviews.first as? CustomImageView)?.layer?.isHidden = true
        }
    }
    
    override var representedObject: Any? {
        didSet {
            
            // Update the view, if already loaded.
        }
    }
}
