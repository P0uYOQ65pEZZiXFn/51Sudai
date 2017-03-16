//
//  Config.swift
//  redo51Sudai
//
//  Created by ZhongLiangLiang on 17/3/16.
//  Copyright © 2017年 zhongliangliang. All rights reserved.
//

import Foundation

class Config: NSObject {
    public var imageUrl = ""
    public var serverUrl = ""
    override init() {
        super.init()
    }
    func readXml() {
        let path = Bundle.main.path(forResource: "config", ofType: "xml")
        let xmlParser = XmlParser.init()
        if path != nil {
            let xml = xmlParser.parser(path: path!)
            self.imageUrl = xml.imageUrl
            self.serverUrl = xml.serverUrl
        }
    }
}

class XmlParser: NSObject ,XMLParserDelegate {
    public var imageUrl = ""
    public var serverUrl = ""
    func parser(path: String) -> XmlParser {
        let data = NSData.init(contentsOfFile: path)
        let xmlParser = XMLParser.init(data: data as! Data)
        xmlParser.delegate = self
        xmlParser.parse()
        return self
    }
    var currentString = ""
    var getValue = ""
    
    //MARK: 开始解析
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        let release = attributeDict["name"]
        if elementName == "runtime" {
            if attributeDict["name"] == release {
                self.getValue = "get"
            }
            else {
                self.getValue = "no"
            }
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
        if self.getValue == "get" {
            if elementName == "serverUrl" {
                self.serverUrl = self.currentString
            }
            if elementName == "imageUrl" {
                self.imageUrl = self.currentString
            }
        }
    }
}
