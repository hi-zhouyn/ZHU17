//
//  ZHUtil.swift
//  ZHU17
//
//  Created by 周亚楠 on 2020/1/9.
//  Copyright © 2020 Zhou. All rights reserved.
//

import UIKit

//全局
let KAppDelegate = UIApplication.shared.delegate as! AppDelegate
let KScreenWidth = UIScreen.main.bounds.width
let KScreenHeight = UIScreen.main.bounds.height

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//MARK:颜色定义
extension UIColor {
    class var main: UIColor {
        return UIColor(hexString: "50D1AD")!
    }
    class var background: UIColor {
        return UIColor(hexString: "F4F4F4")!
    }
    
}




