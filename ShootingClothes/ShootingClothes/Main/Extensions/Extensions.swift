//
//  Extesions.swift
//  ShootingClothes
//
//  Created by Quan Tran on 7/11/16.
//  Copyright © 2016 Quan Tran. All rights reserved.
//

import UIKit

// UIView

extension UIView {
    func addConstraintView (format: String, views:[String : UIView]) {
        let option = NSLayoutFormatOptions(rawValue: 0);
        let constraint = NSLayoutConstraint.constraintsWithVisualFormat(format, options: option, metrics: nil, views: views)
        self.addConstraints(constraint)
    }
}

extension UITextField {
    
}

