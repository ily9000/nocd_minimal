//
//  CircleSlider.swift
//  nOCD_minimal
//
//  Created by Ilyas Patanam on 1/10/18.
//  Copyright © 2018 Ilyas Patanam. All rights reserved.
//

import UIKit

protocol CircleSliderDelegate {
    func scrolling(allowed: Bool)
}

class CircleSlider: UIView {
    
    var outerCircle: UIBezierPath!
    var innerCircle: UIBezierPath!
    var drawnCircles = [String: UIBezierPath]()
    //space between frame and the outer circle
    var margin: CGFloat = 5


    //handler properties
    var circleHandle: UIBezierPath!
    var handleColor = UIColor.white
    var handleRadius: CGFloat = 0
    
    //drawing booleans
    var drawCircle: Bool = false
    var touchStarted: Bool = false
    
    var circleCenter: CGPoint!
    var circleRadius = [String: CGFloat]()
    
    var delegate: CircleSliderDelegate!
    
    let minutes_label: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        if drawCircle {
            addGradient()
            UIColor.white.setFill()
            drawnCircles["inner"]?.fill()
            if circleHandle != nil { handleColor.setFill(); circleHandle.stroke(); circleHandle.fill() }
        }
        super.draw(rect)

        //add gradient color fill here
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
    }
    
    func clear(bounds: CGRect){
        drawCircle = false
        let context = UIGraphicsGetCurrentContext();
        context?.clear(bounds)
        self.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel() {
        self.addSubview(minutes_label)
        minutes_label.center = circleCenter
        if let lblHeight = circleRadius["inner"] {
            minutes_label.frame = CGRect(x: circleCenter.x - lblHeight/2,
                                         y: circleCenter.y - lblHeight/2,
                                         width: lblHeight,
                                         height: lblHeight)
        }
        minutes_label.text = "1 \n min"
    }
    
    func makeSlider(frameHeight: CGFloat, margin: CGFloat,
                    linewidth: CGFloat, handlePadding: CGFloat) {
        //linewidth: space between the inner and outer circle

        //No line is drawn for the inner or outer circles, so the linewidth just serves as a margin
        circleRadius["outer"] = frameHeight/2 - margin
        guard let outerCircleRadius = circleRadius["outer"] else {
            return
        }
        circleCenter = CGPoint(x: frameHeight/2,
                               y: frameHeight/2)
        
        drawnCircles["outer"] = UIBezierPath(arcCenter: circleCenter, radius: outerCircleRadius,
                                             startAngle: CGFloat(0), endAngle: CGFloat(Double.pi*2),
                                             clockwise: true)

        circleRadius["inner"] = outerCircleRadius - linewidth
        guard let innerCircleradius = circleRadius["inner"] else {
            return
        }
        drawnCircles["inner"] = UIBezierPath(arcCenter: circleCenter, radius: innerCircleradius,
                                             startAngle: CGFloat(0), endAngle: CGFloat(Double.pi*2),
                                             clockwise: true)

        setTouchToleranceCircles(frameHeight: frameHeight)

        handleRadius = linewidth/2 + handlePadding/2
        drawCircle = true
        self.setNeedsDisplay()
    }
    
    func drawHandler(at centerPoint: CGPoint) {
        circleHandle = UIBezierPath(arcCenter: centerPoint, radius: handleRadius,
                                    startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        self.setNeedsDisplay()
    }
    
    func setTouchToleranceCircles(frameHeight: CGFloat){
        guard let innerCircleradius = circleRadius["inner"] else {
            return
        }
        innerCircle = UIBezierPath(arcCenter: circleCenter, radius: innerCircleradius - margin,
                                   startAngle: CGFloat(0), endAngle:CGFloat(Double.pi*2),
                                   clockwise: true)
        
        outerCircle = UIBezierPath(arcCenter: circleCenter, radius: frameHeight,
                                   startAngle: CGFloat(0), endAngle:CGFloat(Double.pi*2),
                                   clockwise: true)
    }
    
    func moveHandler(using referencePnt: CGPoint){
        // This function will use the angle of the reference point in reference to the horizontal axis
        // to calculate where the handle should move.
        // Then it will redraw the touchHandler at that location
        let rotAngle = atan2(referencePnt.y - circleCenter.y, referencePnt.x-circleCenter.x);
        guard let outerCircleRadius = circleRadius["outer"], let innerCircleradius = circleRadius["inner"] else {
            return
        }
        
        let distToTouchCenter = (outerCircleRadius + innerCircleradius) / 2.0
        let pntOnCircumference = CGPoint(x: distToTouchCenter * cos(rotAngle) + circleCenter.x,
                                         y: distToTouchCenter * sin(rotAngle) + circleCenter.y)
        drawHandler(at: pntOnCircumference)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touchLoc = touches.first!.location(in: self)
        
        if outerCircle.contains(touchLoc) && !innerCircle.contains(touchLoc) {
            touchStarted = true
            moveHandler(using: touchLoc)
            delegate.scrolling(allowed: false)
        }
        else{
            touchStarted = false
        }
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touchLoc = touches.first!.location(in: self)
        if touchStarted {
            moveHandler(using: touchLoc)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let touchLoc = touches.first!.location(in: self)
        if touchStarted {
            moveHandler(using: touchLoc)
            delegate.scrolling(allowed: true)
        }
        self.setNeedsDisplay()
    }
    
    func addGradient(){
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        
        currentContext.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorComponents: CFArray = [ColorsManager.salmon2.cgColor, ColorsManager.salmon2.cgColor,
                                        ColorsManager.salmon.cgColor, ColorsManager.salmon.cgColor] as CFArray

        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colorComponents,
                                        locations: nil) else { return }

        drawnCircles["outer"]?.addClip()
        let startPoint = CGPoint(x: self.bounds.maxX, y: self.frame.midY)
        let endPoint = CGPoint(x: self.bounds.minX, y: self.frame.midY)
        currentContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)
        currentContext.restoreGState()
    }
}
