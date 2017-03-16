//
//  ViewController.swift
//  redo51Sudai
//
//  Created by ZhongLiangLiang on 17/3/15.
//  Copyright © 2017年 zhongliangliang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let xml = Config.init()
        xml.readXml()
        print("\(xml.imageUrl),\(xml.serverUrl)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

