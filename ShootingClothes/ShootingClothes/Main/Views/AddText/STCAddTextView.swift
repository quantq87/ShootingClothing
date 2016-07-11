//
//  STCAddTextView.swift
//  ShootingClothes
//
//  Created by Quan Tran on 7/11/16.
//  Copyright © 2016 Quan Tran. All rights reserved.
//

import UIKit

protocol STCAddTextViewDelegate {
    func didTypeTextCompleted(textString: NSString)
}

class STCAddTextView : STCBaseView {
    
    var delegateAddText: STCAddTextViewDelegate?
    
    var tfAddText : UITextField =  {
        let tf = UITextField(frame:CGRectZero)
        tf.font = UIFont.systemFontOfSize(15.0)
        tf.backgroundColor = UIColor.clearColor()
        tf.backgroundColor = UIColor.greenColor()
        tf.borderStyle = UITextBorderStyle.Line;
        return tf
    }()
    
    
    class func createAddTextView(point: CGPoint, delegate: STCAddTextViewDelegate!) -> STCAddTextView {
        let addTextView = STCAddTextView(frame : CGRectMake(point.x, point.y, 200, 50))
        addTextView.delegateAddText = delegate
        addTextView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.4)
        addTextView.addSubview(addTextView.tfAddText)
        addTextView.clipsToBounds = true
        addTextView.tfAddText.translatesAutoresizingMaskIntoConstraints = false
        addTextView.addConstraintForView(addTextView.tfAddText, horizontalConstraints: "H:|-5-[myView]-5-|", verticalConstraints: "V:|-5-[myView]-5-|")
        return addTextView;
    }
    
    
}
