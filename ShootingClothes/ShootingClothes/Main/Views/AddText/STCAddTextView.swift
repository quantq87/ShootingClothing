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
    
    var handleImageView: UIImageView = {
        let imageView = UIImageView (frame : CGRectZero)
        imageView.backgroundColor = UIColor.clearColor()
        imageView.image = UIImage(named:"shoot_colthes_move_hand_image");
        return imageView
    }()
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    struct Actions {
        static let buttonTapped = #selector(STCAddTextView.handImageOnTapped(_:))
    }
    
    
    class func createAddTextView(point: CGPoint, delegate: STCAddTextViewDelegate!) -> STCAddTextView {
        let addTextView = STCAddTextView(frame : CGRectZero)
        addTextView.setFrameConfiguration(CGRectMake(point.x, point.y, 200, 50))
        addTextView.delegateAddText = delegate
        addTextView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.4)
        addTextView.clipsToBounds = true
        
        // Add View
        addTextView.addSubview(addTextView.tfAddText)
        addTextView.addSubview(addTextView.handleImageView)
        
        addTextView.tfAddText.translatesAutoresizingMaskIntoConstraints = false
        addTextView.handleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["addView": addTextView, "tfAddText": addTextView.tfAddText, "handleImageView": addTextView.handleImageView]
        
        addTextView.addConstraintView("V:|-5-[tfAddText]-5-|", views:views);
        addTextView.addConstraintView("H:|-5-[tfAddText]-5-[handleImageView(32)]-5-|", views:views);
        addTextView.addConstraintView("V:|-(>=8)-[handleImageView(==32)]-(>=8)-|", views:views);
        
        addTextView.addGestrueRecognizerForHand()
        
        return addTextView;
    }
    
    func addGestrueRecognizerForHand() {
        tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(STCAddTextView.handImageOnTapped(_:)))
        handleImageView.userInteractionEnabled = true
    }
    
    func handImageOnTapped(sender: UITapGestureRecognizer) {
        
    }
    
    func setFrameConfiguration(frameLocal: CGRect) {
        var frameConfig = CGRectZero
        var originX: CGFloat = 0.0
        var originY: CGFloat = 0.0
        let sizeWidth: CGFloat = frameLocal.size.width
        let sizeHeght: CGFloat = frameLocal.size.height
        
        if frameLocal.origin.x > sizeWidth/2 {
            originX = frameLocal.origin.x - (sizeWidth/2)
        }
        else {
            originX = frameLocal.origin.x/2
        }
        
        if frameLocal.origin.y > sizeHeght/2 {
            originY = frameLocal.origin.y - (sizeHeght/2)
        }
        else {
            originY = frameLocal.origin.y/2
        }
        
        frameConfig = CGRectMake(originX, originY, sizeWidth, sizeHeght)
        self.frame = frameConfig
    }
    
}
