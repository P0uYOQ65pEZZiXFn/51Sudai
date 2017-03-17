//
//  DoMain.swift
//  base_swift
//
//  Created by ZhongLiangLiang on 17/2/10.
//  Copyright © 2017年 zll. All rights reserved.
//

import UIKit

class DoMain: NSObject {
    
    // MARK: 计算文字所占位置打大小
    public class func wordSize(string : String , font : UIFont) -> CGSize {
        let paragStyle = NSMutableParagraphStyle.init()
        paragStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        let size: CGSize = CGSize.init(width: Z_FRAME_WIDTH - 20, height: 200.0)
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = string.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size
    }
    
    // MARK: 把格式化的JSON格式的字符串转换成字典 有错误 没用 解析不在这
    public class func dictionaryWith(jsonString: String) -> NSDictionary {
        let nilDic: NSDictionary = NSDictionary()
        if jsonString.isEmpty {
            return nilDic
        }
        else {
            let jsonData = jsonString.data(using: String.Encoding.utf8)
            let dic : Any! = try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments)
            return dic as! NSDictionary
        }
    }
    
    // MARK: 中文字符串utf-8 编码
    public class func UTF_8With(string: String) -> String {
        if string.isEmpty {
            return ""
        }
        else {
            let encodedString = string.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            return encodedString!
        }
    }
    
    // MARK: lable显示不同的颜色、字体大小
    public class func labelDifferentColors(before: UIColor, label: UILabel, string: String, colorString: String, font: UIFont) {
        let attrstring: NSMutableAttributedString = NSMutableAttributedString(string:string)
        let str = NSString(string: string)
        let range = str.range(of: colorString)
        attrstring.addAttribute(NSForegroundColorAttributeName, value: before, range: range)
        attrstring.addAttribute(NSFontAttributeName, value: font, range: range)
        label.attributedText = attrstring
    }
    
    // MARK: lable显示不同的颜色、字体大小一致
    public class func labelDifferentColors(before: UIColor, label: UILabel, string: String, colorString: String) {
        self.labelDifferentColors(before: before, label: label, string: string, colorString: colorString, font: label.font)
    }
}


