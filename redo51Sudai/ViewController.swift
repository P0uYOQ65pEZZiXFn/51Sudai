//
//  ViewController.swift
//  redo51Sudai
//
//  Created by ZhongLiangLiang on 17/3/15.
//  Copyright © 2017年 zhongliangliang. All rights reserved.
//

import UIKit

class ViewController: BaseHasNoNavigationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func click_action(_ sender: Any) {
        let path = "http://192.168.1.24:8080/app/index/activities.action"
        let widthHeightString = "\(Z_FRAME_WIDTH)-\(Z_FRAME_HEIGHT)"
        Http.get(url: path, params: ["resolution":"\(widthHeightString)"], completeHandler: { (dic, response, error) in
            print("\(String(describing: dic?["res_code"]))")
            print("\(String(describing: dic?["res_data"]))")
            print("\(String(describing: dic?["res_msg"]))")
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

