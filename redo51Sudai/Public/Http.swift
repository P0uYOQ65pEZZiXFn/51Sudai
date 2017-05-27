//
//  Http.swift
//  redo51Sudai
//
//  Created by ZhongLiangLiang on 2017/5/26.
//  Copyright © 2017年 zhongliangliang. All rights reserved.
//

import UIKit

class Http: NSObject {
    static let session = URLSession.shared
    class func get(url: String, params: Dictionary<String, String>? = nil, completeHandler: @escaping (NSDictionary?, URLResponse?,NSError?) -> ()) {
        var handUrl = url
        if let d = params {
            let paramKeys = Array(d.keys)
            if paramKeys.count > 0 {
                handUrl += "?"
                for i in 0...paramKeys.count - 1 {
                    let key = paramKeys[i]
                    if i == paramKeys.count - 1 {
                        handUrl += "\(key)=\(d[key]!)"
                    }
                    else {
                        handUrl += "\(key)=\(d[key]!)&"
                    }
                }
            }
        }
        print("getUrl:\(handUrl)")
        let handStr = handUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let mRequst = NSMutableURLRequest(url: NSURL(string: handStr!)! as URL)
        self.handleRequest(requst: mRequst, com: completeHandler)
    }
    
    class func post(url: String, bodtStr: String, completeHandler: @escaping (NSDictionary?, URLResponse?,NSError?) -> ()) {
        print("postUrl:\(url)")
        let handStr = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let mRequst = NSMutableURLRequest(url: NSURL(string: handStr!)! as URL)
        mRequst.httpMethod = "POST"
        mRequst.httpBody = "\(bodtStr)".data(using: String.Encoding.utf8)
        mRequst.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.handleRequest(requst: mRequst, com: completeHandler)
    }
    
    private class func handleRequest(requst: NSURLRequest,com:@escaping (NSDictionary?, URLResponse?,NSError?) -> ()) {
        let task =  session.dataTask(with: requst as URLRequest, completionHandler: {
            (data, response, error) -> Void in
            let json = ConvertUtil.toDicObject(data: data as NSData?)
            com(json, response, error as NSError?)
        })
        task.resume()
    }
}
