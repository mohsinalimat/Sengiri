//
//  CaptureView.swift
//  ScreenRecord
//
//  Created by nakajijapan on 2016/02/19.
//  Copyright © 2016 nakajijapan. All rights reserved.
//

import Cocoa

class CaptureView: NSView {

    var trackingArea:NSTrackingArea?
    var phaseCount:CGFloat = 0.0

    override func awakeFromNib() {
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clearColor().CGColor

        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "timerAnimation:", userInfo: nil, repeats: true)

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {

        super.drawRect(dirtyRect)
        self.drawBox()

    }
    
    var lineDashStatus = 0
    
    func drawBox() {
        let frame = self.frame
        let width = CGFloat(SengiriCropViewLineWidth)

        NSColor(deviceRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.8).set()

        let path = NSBezierPath(rect: frame)
        let context = NSGraphicsContext.currentContext()
        context?.saveGraphicsState()
        context?.shouldAntialias = false

        path.lineWidth = width
        
        self.phaseCount += 1.0
        if self.phaseCount >= 6.0 {
            self.phaseCount = 0.0
        }
        
        let pattern:[CGFloat] = [3.0, 3.0]
        path.setLineDash(pattern, count: 2, phase: self.phaseCount)
        path.stroke()
        
        context?.restoreGraphicsState()

    }
    
    func timerAnimation(timer:NSTimer) {

        self.needsDisplay = true

    }
    
    
}