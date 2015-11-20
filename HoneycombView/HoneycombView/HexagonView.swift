//
//  File.swift
//  HoneycombView
//
//  Created by Abhishek Shinde on 19/11/15.
//  Copyright © 2015 Abhishek Shinde. All rights reserved.
//

import Foundation
import UIKit

class HexagonView: UIView {
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    var hexagonPath: CGPath?
    var isClicked:Bool? = false
    var delegate:handleTap!
    
    var profileImage:UIImageView!
    var bgView: UIView!
    var progressView:UIProgressView!
    var name:UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor=UIColor.clearColor();
        self.addCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView() {
        
        self.profileImage = UIImageView(frame: CGRect(x: 0, y: 0, width:0, height:0))
        profileImage.backgroundColor = UIColor.clearColor()
        self.progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        self.bgView = UIView()
        self.name = UILabel(frame: CGRect(x: 0, y: 0, width:0, height:0))
        name.font = UIFont(name: "HelveticaNeue", size: 12)
        name.textColor = UIColor.whiteColor()
        
        self.profileImage.clipsToBounds = true
        self.progressView.clipsToBounds = true
        self.bgView.clipsToBounds = true
        self.name.clipsToBounds = true
        
        self.addSubview(self.profileImage)
        self.addSubview(self.bgView)
        // self.addSubview(self.progressView)
        self.addSubview(self.name)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isClicked = true
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.isClicked = false
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (true == isClicked){
            
            let touch  : UITouch = touches.first as UITouch!
            let points : CGPoint = touch.locationInView(self)
            
            if CGPathContainsPoint(hexagonPath, nil, points, false){
                let tapid = self.tag
               self.delegate.getTapOnHexagonalView(tapid)
                self.isClicked = false
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isClicked = false
    }
    
    func drawRoundedBorder(borderLayer:CAShapeLayer,width:CGFloat,height:CGFloat, cornerRadius:Float, lineWidth:CGFloat)->CAShapeLayer{
        let crect = CGRect(x: 0, y: 0, width: width, height: height)
        let path = roundedPolygonPathWithRect(crect, lineWidth: 0, sides: 6, cornerRadius: cornerRadius)
        borderLayer.path = path.CGPath
        borderLayer.lineWidth = lineWidth
        let grayBorder = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        borderLayer.strokeColor = grayBorder.CGColor
        borderLayer.fillColor = UIColor.clearColor().CGColor
        borderLayer.borderWidth = 0
        
        return borderLayer
    }
    
    func drawRoundedHex(shapeLayer:CAShapeLayer,width:CGFloat,height:CGFloat, cornerRadius:Float)->CAShapeLayer{
        let crect = CGRect(x: 0, y: 0, width: width, height: height)
        let path = roundedPolygonPathWithRect(crect, lineWidth: 0, sides: 6, cornerRadius: cornerRadius)
        
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor.clearColor().CGColor
        shapeLayer.fillColor = UIColor.whiteColor().CGColor
        shapeLayer.borderWidth = 0
        return shapeLayer
        
        
    }
    func drawTransparentRoundedHex(shapeLayer:CAShapeLayer,width:CGFloat,height:CGFloat)->CAShapeLayer{
        let crect = CGRect(x: 0, y: 0, width: width, height: height)
        let path = roundedPolygonPathWithRect(crect, lineWidth: 0, sides: 6, cornerRadius: 14)
        
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor.clearColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.borderWidth = 0
        return shapeLayer
        
        
    }
    func roundedPolygonPathWithRect(square: CGRect, lineWidth: Float, sides: Int, cornerRadius: Float) -> UIBezierPath {
        let path = UIBezierPath()
        
        let theta = Float(2.0 * M_PI) / Float(sides)
        let offset = cornerRadius * tanf(theta / 2.0)
        let squareWidth = Float(min(square.size.width, square.size.height))
        
        var length = squareWidth - lineWidth
        
        if sides % 4 != 0 {
            length = length * cosf(theta / 2.0) + offset / 2.0
        }
        
        let sideLength = length * tanf(theta / 2.0)
        
        var point = CGPointMake(CGFloat((squareWidth / 2.0) + (sideLength / 2.0) - offset), CGFloat(squareWidth - (squareWidth - length) / 2.0))
        var angle = Float(M_PI)
        path.moveToPoint(point)
        
        for var side = 0; side < sides; side++ {
            
            let x = Float(point.x) + (sideLength - offset * 2.0) * cosf(angle)
            let y = Float(point.y) + (sideLength - offset * 2.0) * sinf(angle)
            
            point = CGPointMake(CGFloat(x), CGFloat(y))
            path.addLineToPoint(point)
            
            let centerX = Float(point.x) + cornerRadius * cosf(angle + Float(M_PI_2))
            let centerY = Float(point.y) + cornerRadius * sinf(angle + Float(M_PI_2))
            
            let center = CGPointMake(CGFloat(centerX), CGFloat(centerY))
            
            let startAngle = CGFloat(angle) - CGFloat(M_PI_2)
            let endAngle = CGFloat(angle) + CGFloat(theta) - CGFloat(M_PI_2)
            
            path.addArcWithCenter(center, radius: CGFloat(cornerRadius), startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            point = path.currentPoint
            angle += theta
        }
        
        path.closePath()
        
        return path
    }
    
    func maskHexagonView(cornerRadius:Float , lineWidth:CGFloat){
        
        let hexLayer = CAShapeLayer()
        let hexborderLayer = CAShapeLayer()
        
        self.layer.mask  = self.drawRoundedHex(hexLayer,width: self.frame.size.width, height: self.frame.size.height, cornerRadius: cornerRadius)
        self.layer.addSublayer(self.drawRoundedBorder(hexborderLayer,width: self.frame.size.width, height: self.frame.size.height, cornerRadius: cornerRadius, lineWidth: lineWidth))
        self.hexagonPath = hexLayer.path
    }
    
}

//protocol to handleTapInCustomView to UITableViewCell
protocol handleTap {
    func getTapOnHexagonalView(tagVal:Int)
}

