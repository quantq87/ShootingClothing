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
    func addConstraintForView (myView: UIView, horizontalConstraints: String, verticalConstraints: String) {
        let views = ["view": self, "myView": myView]
        
        let widthConstraints = NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraints, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        self.addConstraints(widthConstraints)
        
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraints, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        self.addConstraints(heightConstraints)
    }
}

extension UITextField {
    
}

