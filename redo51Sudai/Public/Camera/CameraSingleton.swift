//
//  CameraSingleton.swift
//  base_swift
//
//  Created by ZhongLiangLiang on 17/2/28.
//  Copyright © 2017年 zll. All rights reserved.
//

import Foundation
import UIKit
@objc
protocol CameraDelegate{
    
    @objc func get(image:UIImage)
}

class Camera: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //config start ----
    weak  var delegate:CameraDelegate? {
        didSet{
        }
    }
    
    internal static let shareInstance = Camera()
    //必须保证init方法的私有性，只有这样，才能保证单例是真正唯一的，避免外部对象通过访问init方法创建单例类的其他实例。由于Swift中的所有对象都是由公共的初始化方法创建的，我们需要重写自己的init方法，并设置其为私有的。
    private override init(){
        print("create camera 单例")
    }
    
    // MARK: 调用系统照相机和相册
    public func showCallImage(delegate: CameraDelegate) {
        self.delegate = delegate
        let alertController = UIAlertController.init(title: "请选择来源", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction.init(title: "照相机", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.readImageFromCamera()
        }
        let albumAction = UIAlertAction.init(title: "相册", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.readImageFromAlbum()
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: 读取相册
    private func readImageFromAlbum() {
        let imagePicker = UIImagePickerController.init()
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: 读取照相机
    private func readImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController.init()
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController.init(title: "警告", message: "未检测到摄像头", preferredStyle: UIAlertControllerStyle.alert)
            let sureAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(sureAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: 选取完图片 触发
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage]
        if self.delegate != nil {
            self.delegate?.get(image: image as! UIImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

