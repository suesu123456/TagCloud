//
//  SFPatchView.swift
//  TagCloud
//
//  Created by sue on 15/11/30.
//  Copyright © 2015年 sue. All rights reserved.
//

import UIKit

class SFPatchView: UIView, UIActionSheetDelegate {

    var leftBtton: UIButton!
    var lineImage: UIImageView!
    var btnArray: [UIButton] = []
    var btnWidth: CGFloat = 60
    var beginAngle: CGFloat = 30 // 起始角度
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBtn(_ btn: UIButton, array: [String]) {
        leftBtton = btn
        leftBtton.frame = CGRect(x: 0, y: frame.size.height/2 - 32, width: btnWidth, height: btnWidth)
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(SFPatchView.btnDrag(_:)))
        panGes.maximumNumberOfTouches = 1
        panGes.minimumNumberOfTouches = 1
        leftBtton.addGestureRecognizer(panGes)
        startPoint = CGPoint(x: btnWidth/2, y: leftBtton.frame.origin.y + btnWidth/2)
        addSubview(leftBtton)
        for i in 0 ..< array.count {
            let btn = UIButton(frame: calcCircleFrame(i))
            btn.setImage(UIImage(named: array[i]), for: UIControlState())
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 50, right: 0)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 30
            btnArray.append(btn)
            self.insertSubview(btn, belowSubview: leftBtton)
        }
    }
    // 圆形排版
    func calcCircleFrame(_ i: Int) -> CGRect {
        //起始角度
        let angle = beginAngle * CGFloat(i + 1)
        let r: CGFloat = frame.height / 2.5 //半径
        let a = angle * CGFloat(M_PI) / 180.0 // 角度
        var x: CGFloat = 0
        var y: CGFloat = 0
        x = (sin(a)) * r
        y = (cos(a) * r) + r
        return CGRect(x: x, y: y, width: btnWidth, height: btnWidth)
    }
    //拖拉
    func btnDrag(_ sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.changed {
            endPoint = sender.location(in: self)
        }
        
        if sender.state == UIGestureRecognizerState.ended {
            if isExitInpoint() {
                drawLine()
            }
        }
    
    }
    
    func isExitInpoint() -> Bool {
        for btn in btnArray {
            if btn.frame.contains(endPoint) {
                endPoint = CGPoint(x: btn.frame.origin.x + btnWidth/2, y: btn.frame.origin.y + btnWidth/2)
                return true
            }
        }
        return false
    }
    
    //画线
    func drawLine() {
        UIGraphicsBeginImageContext(self.bounds.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        var image: UIImage!
        if context != nil {
            context?.setShouldAntialias(true)
            context?.setLineWidth(1)
            context?.setStrokeColor(UIColor.red.cgColor)
            //直线
            context?.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
            context?.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
            context?.strokePath()
            //箭头
            context?.setFillColor(UIColor.red.cgColor)
            context?.addEllipse(in: CGRect(x: endPoint.x, y: endPoint.y - 3, width: 5, height: 5))
            context?.fillPath()
            
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lineImage = UIImageView(image: image)
            self.addSubview(lineImage)
        }
       
        
    }

}
