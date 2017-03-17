//
//  Config.swift
//  redo51Sudai
//
//  Created by ZhongLiangLiang on 17/3/16.
//  Copyright © 2017年 zhongliangliang. All rights reserved.
//

import Foundation

class Config: NSObject, XMLParserDelegate {
    public var imageUrl = ""
    public var serverUrl = ""
    //每个xml对象
    var server :ServerMode = ServerMode()
    // xml 数组
    var servers :NSMutableArray = NSMutableArray()
    //选择的runtime名字
    var selectString = ""
    // 当前值
    var currentString = ""
    // 服务器名字
    var name = ""
    //创建单例
    internal static let shareInstance = Config()
    private override init(){
        super.init()
        let arr = self.readXml()
        
        for i in 1...arr.count {
            let jjj = i - 1
            let server:ServerMode = arr[jjj] as! ServerMode
            if self.selectString == server.name {
                self.imageUrl = server.imageUrl
                self.serverUrl = server.serverUrl
            }
        }
    }
    //读取xml文件
    func readXml() -> NSMutableArray {
        var arr = NSMutableArray()
        let path = Bundle.main.path(forResource: "config", ofType: "xml")
        if path != nil {
            arr = self.parser(path: path!)
        }
        return arr
    }
    
    // 解析xml
    func parser(path: String) -> NSMutableArray {
        let data = NSData.init(contentsOfFile: path)
        let xmlParser = XMLParser.init(data: data as! Data)
        xmlParser.delegate = self
        xmlParser.parse()
        return self.servers
    }
    
    //MARK: 开始解析
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "App" {
            self.selectString = attributeDict["runtime"]!
        }
        if elementName == "runtime" {
            self.name = attributeDict["name"]!
            let server = ServerMode.init()
            self.server = server
            self.server.name = self.name
        }
    }
    
    //MARK: 找到值
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString = string
    }
    
    //MARK: 发生错误
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        
    }
    
    //MARK: 解析结束
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "runtime" {
            self.servers.add(server)
        }
        if elementName == "serverUrl" {
            let  serverUrl = self.currentString
            self.server.serverUrl = serverUrl
        }
        else if elementName == "imageUrl" {
            let  imageUrl = self.currentString
            self.server.imageUrl = imageUrl
        }
    }
}

// 服务器对象
struct ServerMode {
    var     serverUrl        = ""
    var     imageUrl         = ""
    var     name             = ""
}

