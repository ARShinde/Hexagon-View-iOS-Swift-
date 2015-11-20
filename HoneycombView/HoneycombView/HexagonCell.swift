//
//  HexagonCell.swift
//  HoneycombView
//
//  Created by Abhishek Shinde on 19/11/15.
//  Copyright © 2015 Abhishek Shinde. All rights reserved.
//


import UIKit
import QuartzCore

class HexagonCell: UITableViewCell,handleTap {
    //calculate width of the polygon based on screen length
    
    var polyWidth : CGFloat = 0.0
    var polyHeight : CGFloat = 0.0
    var polyBorderWidth: CGFloat = 14.0
    var sagitta : CGFloat = 0.0
    
    @IBOutlet weak var tableCellView: UIView!
    
    var topHexagon:HexagonView?
    var midBottomHexagon:HexagonView?
    var bottomHexagon: HexagonView?
    var rightTopHexagon: HexagonView?
    var leftTopHexagon: HexagonView?
    
    var hex : UIView!
    var tapgesture:UITapGestureRecognizer?
    var completeUIVIew : UIView!
    
    var delegate:cellhandleTap?
    
    var startingPtX:CGFloat!
    var startingPtY:CGFloat!
    var alphaValue : CGFloat!
    var beta : CGFloat!
    var topPositionX:CGFloat!
    var topPositionY:CGFloat!
    var rightTopPositionX:CGFloat!
    var rightTopPositionY:CGFloat!
    var leftTopPositionX:CGFloat!
    var leftTopPositionY:CGFloat!
    
    
    var midPositionX:CGFloat!
    var midPositionY:CGFloat!
    var bottomPositionX:CGFloat!
    var bottomPositionY:CGFloat!
    
    var profileImage:UIImageView!
    var bgView: UIView!
    var textView:CATextLayer!
    var progressView:UIProgressView!
    
    let topHexLayer = CAShapeLayer()
    let topHexborderLayer = CAShapeLayer()
    let midBottomHexLayer = CAShapeLayer()
    let midBottomHexborderLayer = CAShapeLayer()
    let bottomHexLayer = CAShapeLayer()
    let bottomHexborderLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let getWidthOfScreen = UIScreen.mainScreen().bounds.size.width
        polyWidth =  (getWidthOfScreen / 2.5 )
        polyHeight = (getWidthOfScreen / 2.5 )
        sagitta = (polyWidth/2) - sqrt(pow((polyWidth/2), 2) - pow((polyWidth/4), 2))
        
        self.startingPtX = 0
        self.startingPtY = -sagitta
        
        self.alphaValue = ( polyHeight/2 )
        self.beta =  ( (3 * polyWidth) / 4 )
        
        self.backgroundView?.opaque = true
         self.backgroundView?.opaque = true
        
        //var hexLayer = CAShapeLayer()
        //let hexBorderLayer = CAShapeLayer()
        
        
        /**** left top View ****/
        
        self.leftTopPositionX = startingPtX + beta * 2
        self.leftTopPositionY = startingPtY - alphaValue + sagitta
        self.leftTopHexagon = HexagonView(frame: CGRect(x: self.leftTopPositionX, y: self.leftTopPositionY , width:polyWidth, height:polyHeight))
        self.addSubview(self.leftTopHexagon!)
        
        /**** right top View ****/
        
        self.rightTopPositionX = startingPtX
        self.rightTopPositionY = startingPtY - self.alphaValue + sagitta
        self.rightTopHexagon = HexagonView(frame: CGRect(x: self.rightTopPositionX, y: self.rightTopPositionY , width:polyWidth, height:polyHeight))
        self.addSubview(self.rightTopHexagon!)
        
        
        /**** top View ****/
        
        self.topPositionX = startingPtX  + beta
        self.topPositionY = startingPtY
        self.topHexagon = HexagonView(frame: CGRect(x: self.topPositionX, y: self.topPositionY, width:polyWidth, height:polyHeight))
        //self.topHexagon!.progressView.layer.masksToBounds = false
        //self.topHexagon!.progressView.clipsToBounds=true
        
        self.topHexagon!.profileImage.frame = CGRectMake(0, 0, polyWidth, polyHeight)
        self.topHexagon!.bgView.frame =  CGRect(x: 0, y: polyHeight-polyBorderWidth-18, width: polyWidth, height:20)
        // self.topHexagon!.bgView.backgroundColor=UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
        
        self.topHexagon!.name.frame = CGRect(x: polyWidth/4, y: polyHeight-polyBorderWidth-16, width:polyWidth/2, height: 15)
        self.topHexagon!.name.textAlignment=NSTextAlignment.Center
        
        //        self.topHexagon!.progressView.frame = CGRect(x: polyWidth/4 - 10, y: polyHeight-polyBorderWidth-18 , width:polyWidth/2 + 20, height:6)
        //        self.topHexagon!.progressView.tintColor = UIColor(red: 255/255, green: 170/255, blue: 4/255, alpha: 1.0)
        //        self.topHexagon!.progressView.trackTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        self.addSubview(self.topHexagon!)
        
        /**** middle Bottom View ****/
        
        self.midPositionX = startingPtX
        self.midPositionY = startingPtY + alphaValue - sagitta
        self.midBottomHexagon = HexagonView(frame: CGRect(x: self.midPositionX, y: self.midPositionY , width:polyWidth, height:polyHeight))
        //self.midBottomHexagon!.progressView.layer.masksToBounds=true
        //self.midBottomHexagon!.progressView.clipsToBounds=true
        
        self.midBottomHexagon!.profileImage.frame = CGRectMake(0, 0, polyWidth, polyHeight)
        self.midBottomHexagon!.bgView.frame =  CGRect(x: 0, y: polyHeight-polyBorderWidth-18, width: polyWidth, height:20)
        //  self.midBottomHexagon!.bgView.backgroundColor=UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
        
        self.midBottomHexagon!.name.frame = CGRect(x: polyWidth/4, y: polyHeight-polyBorderWidth-16, width:polyWidth/2, height: 15)
        self.midBottomHexagon!.name.textAlignment=NSTextAlignment.Center
        
        //self.midBottomHexagon!.progressView.frame = CGRect(x: polyWidth/4 - 10, y: polyHeight-polyBorderWidth-18 , width:polyWidth/2 + 20, height:6)
        //self.midBottomHexagon!.progressView.tintColor = UIColor(red: 255/255, green: 170/255, blue: 4/255, alpha: 1.0)
        //self.midBottomHexagon!.progressView.trackTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        self.addSubview(self.midBottomHexagon!)
        
        
        /**** Bottom View ****/
        
        self.bottomPositionX =  startingPtX + beta * 2
        self.bottomPositionY =  startingPtY + alphaValue - sagitta
        self.bottomHexagon = HexagonView(frame: CGRect(x: self.bottomPositionX, y:
            self.bottomPositionY , width:polyWidth, height:polyHeight))
        //self.bottomHexagon!.progressView.layer.masksToBounds=true
        //self.bottomHexagon!.progressView.clipsToBounds=true
        
        self.bottomHexagon!.profileImage.frame = CGRectMake(0, 0, polyWidth, polyHeight)
        self.bottomHexagon!.bgView.frame =  CGRect(x: 0, y: polyHeight-polyBorderWidth-18, width: polyWidth, height:20)
        // self.bottomHexagon!.bgView.backgroundColor=UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
        
        self.bottomHexagon!.name.frame = CGRect(x: polyWidth/4, y: polyHeight-polyBorderWidth-16, width:polyWidth/2, height: 15)
        self.bottomHexagon!.name.textAlignment=NSTextAlignment.Center
        
        //self.bottomHexagon!.progressView.frame = CGRect(x: polyWidth/4 - 10, y: polyHeight-polyBorderWidth-18 , width:polyWidth/2 + 20, height:6)
        //self.bottomHexagon!.progressView.tintColor = UIColor(red: 255/255, green: 170/255, blue: 4/255, alpha: 1.0)
        //self.bottomHexagon!.progressView.trackTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        
        self.addSubview(self.bottomHexagon!)
        self.bringSubviewToFront(self.topHexagon!)
        drawPolygon()
        
    }
    
    func drawPolygon(){
        
        //        if let topHex = self.topHexagon{
        //            let topHexLayer = CAShapeLayer()
        //            let topHexborderLayer = CAShapeLayer()
        //            topHex.layer.mask  = self.topHexagon?.drawRoundedHex(topHexLayer, width: polyWidth, height: polyHeight, cornerRadius: 12)
        //            topHex.layer.masksToBounds = false
        //            topHex.layer.shouldRasterize = true
        //            topHex.opaque = true
        //            topHex.layer.addSublayer(self.topHexagon!.drawRoundedBorder(topHexborderLayer, width: polyWidth, height: polyHeight, cornerRadius: 12, lineWidth: 12))
        //            topHex.hexagonPath = topHexLayer.path
        //        }
        //
        if let midHex = self.rightTopHexagon{
            
            let midTopHexLayer = CAShapeLayer()
            
            midHex.layer.mask  = self.rightTopHexagon?.drawTransparentRoundedHex(midTopHexLayer, width: polyWidth, height: polyHeight)
            midHex.layer.masksToBounds = false
            midHex.layer.shouldRasterize = true
            midHex.opaque = true
            midHex.hexagonPath = midTopHexLayer.path
        }
        
        if let midHex1 = self.leftTopHexagon{
            
            let midTopHexLayer = CAShapeLayer()
            
            midHex1.layer.mask  = self.leftTopHexagon?.drawTransparentRoundedHex(midTopHexLayer, width: polyWidth, height: polyHeight)
            midHex1.layer.masksToBounds = false
            midHex1.layer.shouldRasterize = true
            midHex1.opaque = true
            midHex1.hexagonPath = midTopHexLayer.path
        }
        
        //        if let midBottomHex = self.midBottomHexagon{
        //            let midBottomHexLayer = CAShapeLayer()
        //            let midBottomHexborderLayer = CAShapeLayer()
        //
        //            midBottomHex.layer.mask  =  self.midBottomHexagon?.drawRoundedHex(midBottomHexLayer, width: polyWidth, height: polyHeight, cornerRadius: 12)
        //            midBottomHex.layer.masksToBounds = false
        //            midBottomHex.layer.shouldRasterize = true
        //            midBottomHex.opaque = true
        //            midBottomHex.layer.addSublayer(self.midBottomHexagon!.drawRoundedBorder(midBottomHexborderLayer, width: polyWidth, height: polyHeight, cornerRadius: 12, lineWidth: 12))
        //            midBottomHex.hexagonPath = midBottomHexLayer.path
        //        }
        //
        //        if let bottomHex = self.bottomHexagon{
        //            let bottomHexLayer = CAShapeLayer()
        //            let bottomHexborderLayer = CAShapeLayer()
        //            bottomHex.layer.mask  = self.bottomHexagon?.drawRoundedHex(bottomHexLayer, width: polyWidth, height: polyHeight, cornerRadius: 12)
        //            bottomHex.layer.masksToBounds = false
        //            bottomHex.layer.shouldRasterize = true
        //            bottomHex.opaque = true
        //            bottomHex.layer.addSublayer(self.bottomHexagon!.drawRoundedBorder(bottomHexborderLayer, width: polyWidth, height: polyHeight, cornerRadius: 12, lineWidth: 12))
        //            bottomHex.hexagonPath = bottomHexLayer.path
        //        }
    }
    
    func renderUI(personArray:Array<NSString>, emptyViews:Array<Bool>){
        
        var positionArray = [Constants.Top,Constants.MiddleTop,Constants.Middle,Constants.Bottom,Constants.MiddleTop]
        
        for index in 0..<personArray.count{
            
            
            if positionArray[index] == Constants.Top{
                
                if emptyViews[index] == false{
                    //DRAW BORDER TO HEXAGON LAYER
                    if let topHex = self.topHexagon{
                        
                        
                        topHex.layer.mask  = self.topHexagon?.drawRoundedHex(topHexLayer, width: polyWidth, height: polyHeight, cornerRadius: 12)
                        topHex.layer.masksToBounds = false
                        topHex.layer.shouldRasterize = true
                        topHex.opaque = true
                        topHex.layer.addSublayer(self.topHexagon!.drawRoundedBorder(topHexborderLayer, width: polyWidth, height: polyHeight, cornerRadius: 12, lineWidth: 12))
                       
                        self.topHexagon?.delegate = self
                        self.topHexagon = makePolygonWithPosition(self.topPositionX, positionY: self.topPositionY, newView: self.topHexagon!)
                        topHex.hexagonPath = topHexLayer.path
                        self.topHexagon!.bgView.backgroundColor=UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
                        
                    }
                }else{
                    self.topHexagon!.layer.mask  = self.topHexagon?.drawTransparentRoundedHex(topHexLayer, width: polyWidth, height: polyHeight)
                    topHexagon?.delegate = self
                    self.topHexagon! = makeBlankPolygonWithPosition(self.topPositionX, positionY: self.topPositionY, newView: self.topHexagon!)
                }
                
                
            }
            else if positionArray[index] == Constants.MiddleTop{
                rightTopHexagon?.delegate = self
                self.rightTopHexagon! = makeBlankPolygonWithPosition(self.rightTopPositionX, positionY: self.rightTopPositionY, newView: self.rightTopHexagon!)
                leftTopHexagon?.delegate = self
                self.leftTopHexagon! = makeBlankPolygonWithPosition(self.leftTopPositionX, positionY: self.leftTopPositionY, newView: self.leftTopHexagon!)
                
            }
                
            else if positionArray[index] == Constants.Middle{
                if emptyViews[index] == false{
                    
                    if let midBottomHex = self.midBottomHexagon{
                        
                        
                        midBottomHex.layer.mask  =  self.midBottomHexagon?.drawRoundedHex(midBottomHexLayer, width: polyWidth, height: polyHeight, cornerRadius: 12)
                        midBottomHex.layer.masksToBounds = false
                        midBottomHex.layer.shouldRasterize = true
                        midBottomHex.opaque = true
                        midBottomHex.layer.addSublayer(self.midBottomHexagon!.drawRoundedBorder(midBottomHexborderLayer, width: polyWidth, height: polyHeight, cornerRadius: 12, lineWidth: 12))
                        
                        self.midBottomHexagon!.bgView.backgroundColor=UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
                        midBottomHexagon?.progressView.hidden=true
                        midBottomHex.hexagonPath = midBottomHexLayer.path
                        self.midBottomHexagon?.delegate = self
                        self.midBottomHexagon! = makePolygonWithPosition(self.midPositionX, positionY: self.midPositionY, newView: self.midBottomHexagon!)
                        
                    }
                    
                }else{
                    //do nothing
                    //                    midBottomHexagon?.layer.mask  =  self.midBottomHexagon?.drawRoundedHex(midBottomHexLayer, width: polyWidth, height: polyHeight, cornerRadius: 12)
                    self.midBottomHexagon!.layer.mask  = self.midBottomHexagon?.drawTransparentRoundedHex(midBottomHexLayer, width: polyWidth, height: polyHeight)
                    //  midBottomHexagon?.delegate = self
                    self.midBottomHexagon! = makeBlankPolygonWithPosition(self.midPositionX, positionY: self.midPositionY, newView: self.midBottomHexagon!)
                    
                }
                
                
            }
            else if positionArray[index] == Constants.Bottom{
                if emptyViews[index] == false{
                    if let bottomHex = self.bottomHexagon{
                        
                        bottomHexagon?.layer.mask  = self.bottomHexagon?.drawRoundedHex(bottomHexLayer, width: polyWidth, height: polyHeight, cornerRadius: 12)
                        
                        bottomHex.layer.masksToBounds = false
                        bottomHex.layer.shouldRasterize = true
                        bottomHex.opaque = true
                        bottomHex.hexagonPath = bottomHexLayer.path
                        bottomHex.layer.addSublayer(self.bottomHexagon!.drawRoundedBorder(bottomHexborderLayer, width: polyWidth, height: polyHeight, cornerRadius: 12, lineWidth: 12))
                        self.bottomHexagon?.delegate = self
                        self.bottomHexagon = makePolygonWithPosition(self.bottomPositionX,positionY: self.bottomPositionY,newView: self.bottomHexagon!)
                        self.bottomHexagon!.bgView.backgroundColor=UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
                        
                    }
                }else{
                    //do nothing
                    self.bottomHexagon!.layer.mask  = self.bottomHexagon?.drawTransparentRoundedHex(bottomHexLayer, width: polyWidth, height: polyHeight)
                    
                    //  bottomHexagon?.delegate = self
                    self.bottomHexagon! = makeBlankPolygonWithPosition(self.bottomPositionX, positionY: self.bottomPositionY, newView: self.bottomHexagon!)
                    
                }
                
            }
            
        }
    }
    
    func assingTagValue(indexpath:NSIndexPath) {
        let row =  indexpath.row
        self.topHexagon?.tag = row * 3
        self.rightTopHexagon?.tag = row*3 - 2
        self.leftTopHexagon?.tag =  row*3 - 1
        self.midBottomHexagon?.tag = row*3 + 1
        self.bottomHexagon?.tag = row*3 + 2
        
    }

    func makeBlankPolygonWithPosition(positionX:CGFloat,positionY:CGFloat,newView:HexagonView)->HexagonView
    {
        newView.profileImage.hidden = true
        newView.bgView.hidden = true
        newView.name.hidden = true
        newView.progressView.hidden = true
        newView.hidden = false
        return newView
    }
    
    func makePolygonWithPosition(positionX:CGFloat,positionY:CGFloat,newView:HexagonView)-> HexagonView
    {
        newView.hidden = false
        newView.profileImage.hidden = false
        newView.bgView.hidden = false
        newView.name.hidden = false
        newView.progressView.hidden = false // make false to make it functional
        newView.name.text = "Chuck Norrice"
        

        let diceRoll = String(format: "%@%i", "photo" , Int(arc4random_uniform(UInt32(6))))

        
        newView.profileImage.image = UIImage(named: diceRoll )
        
        newView.profileImage.contentMode = UIViewContentMode.ScaleAspectFill        
        return newView
    }
    
    func getTapOnHexagonalView(tagVal: Int) {
        self.delegate?.cellTapOnSpecificView(tagVal)
    }
    
    
}
protocol cellhandleTap{
    func cellTapOnSpecificView(tagVal:Int)
}

