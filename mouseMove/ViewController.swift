//
//  ViewController.swift
//  mouseMove
//
//  Created by Tom Wilding on 05/07/2015.
//  Copyright (c) 2015 Tom Wilding. All rights reserved.
//

import Cocoa
import CoreGraphics

class ViewController: NSViewController {
    
    // Init acceleration, velocity and distance and time vectors
    var vkx = Double(0)
    var rkx = Double(0)
    var akx = Double(0)
    
    var vky = Double(0)
    var rky = Double(0)
    var aky = Double(0)
    
    var startY = Double(500)
    var startX = Double(500)
    
    var dt = 0.001
    
    // Advertise the service
    let mouseService = MouseServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mouseService.delegate = self
    }
    
    func updateX(akx : Double) {
        // Use absolute acceleration to determine vel and pos
        // Then use sign of the acceleration to determine direction (pair or average)
        
        // Update vel and pos for x
        vkx = vkx + (dt * akx)
        rkx = rkx + (dt * vkx) * abs(akx / 100)
        
//      // Update vel and pos for y
//      aky = ys[i]
//      vky = vky + (dt * aky)
//      rky = rky + (dt * vky) * abs(aky / 100)
//      // Set pos
//      CGWarpMouseCursorPosition(NSMakePoint(CGFloat(startX + rkx), CGFloat(startY + rky)))
        CGWarpMouseCursorPosition(NSMakePoint(CGFloat(startX + rkx), CGFloat(startY)))
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func redTapped(sender : AnyObject) {
        println("RED TAPPED")
        mouseService.sendColor("red")
    }
    
}

extension ViewController : MouseServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: MouseServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
        }
    }
    
    func colorChanged(manager: MouseServiceManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in

        }
    }
    
    func xChanged(manager: MouseServiceManager, xString: String) {
        // Convert x back to double
        var stringX = NSString(string: xString)
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.updateX(stringX.doubleValue)
        }
    }
    
}
