//
//  UILabelFont.swift
//  Books
//
//  Created by Dang Duy Cuong on 9/30/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

extension UILabel {
    func setDefaultFont() {
        self.font = UIFont(name: "Roboto-Regular", size: 15)
    }
    
    func setDefaultTitleField() {
        self.font = UIFont(name: "Roboto-Regular", size: 14)
        self.textColor = UIColor.darkGray
    }
}

