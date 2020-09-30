//
//  BaseNavigationController.swift
//  Books
//
//  Created by Dang Duy Cuong on 9/30/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationBar.isTranslucent = false
//        navigationBar.barTintColor = Constant.color.blueVSmart
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: Constant.font.robotoBold(ofSize: 17)]
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 17)!
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs
        navigationBar.tintColor = .white
//        BroadCastNewInfoModel.sharedInstance.isAdded = false
    }
}
