//
//  Extention.swift
//  redo51Sudai
//
//  Created by ZhongLiangLiang on 17/3/17.
//  Copyright © 2017年 zhongliangliang. All rights reserved.
//

import Foundation
import UIKit

// MARK: 扩展hexColor
extension UIColor {
    // MARK: 透明度为1的16进制颜色
    class func hexColor(hexString: String) -> UIColor {
        return self.hexColor(hexString: hexString, alpha: 1)
    }
    // MARK: 带透明度的16进制颜色
    class func hexColor(hexString: String, alpha: CGFloat) -> UIColor {
        var cString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.characters.count < 6 {
            return UIColor.clear
        }
        // strip 0X if it appears
        if cString.hasPrefix("0X") {
            let index = cString.index(cString.startIndex, offsetBy: 2)
            cString = cString.substring(from:index)
        }
        
        // strip # if it appears
        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = cString.substring(from:index)
        }
        
        // 颜色不是6位
        if cString.characters.count != 6 {
            return UIColor.clear
        }
        
        // Separate into r, g, b substrings
        var i = cString.index(cString.startIndex, offsetBy: 0)
        var j = cString.index(cString.startIndex, offsetBy: 2)
        //r
        let rString = cString.substring(with: i..<j)
        
        //g
        i = cString.index(cString.startIndex, offsetBy: 2)
        j = cString.index(cString.startIndex, offsetBy: 4)
        let gString = cString.substring(with: i..<j)
        
        //b
        i = cString.index(cString.startIndex, offsetBy: 4)
        j = cString.index(cString.startIndex, offsetBy: 6)
        let bString = cString.substring(with: i..<j)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return self.RGBColor(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: alpha)
    }
    
    // MARK: 透明度为1的RGB颜色
    class func RGBColor(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return self.RGBColor(r: r, g: g, b: b, a: 1)
    }
    // MARK: 带透明度的RGB颜色
    class func RGBColor(r:CGFloat, g:CGFloat, b:CGFloat,a:CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

//MARK: 扩展颜色创建图片
extension UIImage {
    class func create(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage!
    }
}
