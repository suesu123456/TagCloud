//
//  ViewController2.swift
//  TagCloud
//
//  Created by sue on 15/11/27.
//  Copyright © 2015年 sue. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, CloudViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        let cloud = CloudView(frame: self.view.bounds, andNodeCount:  50)
        cloud.delegate = self
        self.view.addSubview(cloud)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectedNodeButton(button: CloudButton!) {
        print(button.tag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
