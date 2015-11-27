//
//  ViewController.swift
//  TagCloud
//
//  Created by sue on 15/11/27.
//  Copyright © 2015年 sue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var sphereView: DBSphereView!

    override func viewDidLoad() {
        super.viewDidLoad()
        sphereView = DBSphereView(frame: CGRectMake(0, 100, 320, 320))
        let array = NSMutableArray(capacity: 0)
        for var i = 0; i < 50; i++ {
            let btn: UIButton = UIButton(type: UIButtonType.System)
            btn.setTitle("ww", forState: UIControlState.Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(24)
            btn.frame = CGRectMake(0, 0, 60, 20)
            btn.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
            array.addObject(btn)
            sphereView.addSubview(btn)
        }
        sphereView.setCloudTags(array as [AnyObject])
        sphereView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(sphereView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(btn: UIButton) {
        sphereView.timerStop()
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            btn.transform = CGAffineTransformMakeScale(2, 2)
            }) { (finished) -> Void in
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                 btn.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: { (finished) -> Void in
                        self.sphereView.timerStart()
                })
        }
    }


}

