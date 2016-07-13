//
//  STCImageView.swift
//  ShootingClothes
//
//  Created by Quan Tran on 7/13/16.
//  Copyright © 2016 Quan Tran. All rights reserved.
//

import UIKit

protocol STCImageViewDelegate {
    func didTouchInSideImage(point: CGPoint)
}

class STCImageView: UIImageView {
    
    var delegate: STCImageViewDelegate?
    
    private struct Action {
        static let buttonTapped = #selector(handImageOnTapped(_:))
    }
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        addGestrueRecognizerForHand()
    }
    
    func addGestrueRecognizerForHand() {
        tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Action.buttonTapped)
        self.userInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    func setDelegate(aDelegate: STCImageViewDelegate) {
        delegate = aDelegate
    }
    
    func handImageOnTapped(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            let touchLocation: CGPoint = sender.locationInView(sender.view)
            if delegate != nil {
                delegate!.didTouchInSideImage(touchLocation)
            }
            print("Location : \(touchLocation)")
        }
    }
    
}
