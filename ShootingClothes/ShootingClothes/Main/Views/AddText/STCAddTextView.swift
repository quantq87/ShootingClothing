//
//  STCAddTextView.swift
//  ShootingClothes
//
//  Created by Quan Tran on 7/11/16.
//  Copyright © 2016 Quan Tran. All rights reserved.
//

import UIKit

struct Constants {
    static var textInputSizeWidth: CGFloat {
        return 200.0
    }
    static var textInputSizeHeight: CGFloat {
        return 50.0
    }
}

protocol STCAddTextViewDelegate {
    func didTypeTextCompleted(textString: NSString)
    func didSelectedView()
}

class STCAddTextView : STCBaseView {
    
    var delegateAddText: STCAddTextViewDelegate?
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    var frameSize: CGRect = CGRectZero
    
    var adjust_x: CGFloat = 0.0
    var adjust_y: CGFloat = 0.0
    
    var parentView:UIView! = nil
    var parentSize:CGSize = CGSizeZero
    
    var isBeginMove: Bool = false
    
    private struct Action {
        static let buttonTapped = #selector(handImageOnTapped(_:))
    }
    
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
    
    
    class func createAddTextView(point: CGPoint, parent: UIView, size: CGSize, delegate: STCAddTextViewDelegate!) -> STCAddTextView {
        let addTextView = STCAddTextView(frame : CGRectZero)
        addTextView.parentView = parent
        addTextView.parentSize = size
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
        return addTextView;
    }
    
    func setUpView() {
        addGestrueRecognizerForHand()
    }
    
    func addGestrueRecognizerForHand() {
        tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Action.buttonTapped)
        handleImageView.userInteractionEnabled = true
        handleImageView.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    func handImageOnTapped(sender: UITapGestureRecognizer) {
        if sender.state == .Changed {
            let touchLocation: CGPoint = sender.locationInView(sender.view)
            print("Location : \(touchLocation)")
        }
    }
    
    func moveViewToPoint(point: CGPoint) {
        setFrameConfiguration(CGRectMake(point.x, point.y, Constants.textInputSizeWidth, Constants.textInputSizeHeight))
    }
    
    func setFrameConfiguration(frameLocal: CGRect) {
        frameSize = frameLocal
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

extension STCAddTextView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
            if isBeginMove == false {
//                let touchLocation: CGPoint = touch.locationInView(parentView)
                adjust_x = frameSize.size.width - 30
                adjust_y = frameSize.size.height/2
                isBeginMove = true
            }
//        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation: CGPoint = touch.locationInView(parentView)
            var originX: CGFloat = touchLocation.x - adjust_x
            var originY: CGFloat = touchLocation.y - adjust_y
            
            if originX > parentSize.width - Constants.textInputSizeWidth {
                originX = parentSize.width - Constants.textInputSizeWidth
            }
            else if originX <= 0 {
                originX = 0
            }
            
            print("Location \(originY) and size \(parentSize.height -  Constants.textInputSizeHeight - 64)")
            
            if originY > parentSize.height -  Constants.textInputSizeHeight - 64 {
                originY = parentSize.height - Constants.textInputSizeHeight
            }
            else if originY < 0 {
                originY = 0
            }
            self.frame = CGRectMake(originX, originY, frameSize.size.width, frameSize.size.height)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation: CGPoint = touch.locationInView(parentView)
            
            var originX: CGFloat = touchLocation.x - adjust_x
            var originY: CGFloat = touchLocation.y - adjust_y
            
            if originX > parentSize.width - Constants.textInputSizeWidth {
                originX = parentSize.width - Constants.textInputSizeWidth
            }
            else if originX < 0 {
                originX = 0
            }
            
            if originY > parentSize.height - Constants.textInputSizeHeight - 64 {
                originY = parentSize.height - Constants.textInputSizeHeight
            }
            else if originY < 0 {
                originY = 0.0
            }
            self.frame = CGRectMake(originX, originY, frameSize.size.width, frameSize.size.height)
            
            isBeginMove = false
        }
    }
}
