//
//  ZHTabBarViewController.swift
//  ZHU17
//
//  Created by 周亚楠 on 2020/1/9.
//  Copyright © 2020 Zhou. All rights reserved.
//

import UIKit

class ZHTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController(controller:HomeViewController(),
                            title: "首页",
                            image: UIImage(named: "tab_home"),
                            selectedImage: UIImage(named: "tab_home_S"))
        setupViewController(controller:CateViewController(),
                            title: "分类",
                            image: UIImage(named: "tab_class"),
                            selectedImage: UIImage(named: "tab_class_S"))
        setupViewController(controller:BookcaseViewController(),
                            title: "书架",
                            image: UIImage(named: "tab_book"),
                            selectedImage: UIImage(named: "tab_book_S"))
        setupViewController(controller:MineViewController(),
                            title: "我的",
                            image: UIImage(named: "tab_mine"),
                            selectedImage: UIImage(named: "tab_mine_S"))
        
    }
    
    // MARK: - 便利构造
    func setupViewController(controller: UIViewController, title: String?, image: UIImage?, selectedImage: UIImage?) -> Void {
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem!.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: UIControl.State())
        controller.tabBarItem!.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.main], for: .selected)
        addChild(BaseNavigationController(rootViewController: controller))
    }
    
    // MARK: - tab index 选中
    func tabBarSelect(index: Int) -> Void {
        self.selectedIndex = index
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
