//
//  ViewController2.swift
//  TagCloud
//
//  Created by sue on 15/11/27.
//  Copyright © 2015年 sue. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, CloudViewDelegate {
    var person: [[AnyObject]] = [["Bili" as AnyObject, UIImage(named: "1")!],
                                ["peach" as AnyObject, UIImage(named: "2")!],
                                ["Elina" as AnyObject, UIImage(named: "3")!],
                                ["Caroline" as AnyObject, UIImage(named: "4")!],
                                ["Xiuna" as AnyObject, UIImage(named: "5")!],
                                ["Caroline" as AnyObject, UIImage(named: "6")!],
                                ["Big" as AnyObject, UIImage(named: "7")!],
                                ["Lucy" as AnyObject, UIImage(named: "8")!]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        let cloud = CloudView(frame: self.view.bounds, andNodeCount:  3, andPersonArray:  person)
        cloud?.delegate = self
        self.view.addSubview(cloud!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectedNodeButton(_ button: CloudButton!) {
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
