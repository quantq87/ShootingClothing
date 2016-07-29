//
//  STCHomeScreen.swift
//  ShootingClothes
//
//  Created by Quan Tran on 7/11/16.
//  Copyright © 2016 Quan Tran. All rights reserved.
//

import UIKit
import MobileCoreServices

class STCHomeScreen: STCBaseScreen, UIImagePickerControllerDelegate, UINavigationControllerDelegate, STCImageViewDelegate, STCPhotoScreenDelegate {
    
    @IBOutlet weak var _mainContentView: UIView!
    @IBOutlet weak var _takeImageView: STCImageView!
    
    var imagePicker:UIImagePickerController! = nil
    var addTextView: STCAddTextView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScreen()
        setUpDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func setUpScreen() {
        super.setUpScreen()
        
        let cameraImage = UIImage(named: "shoot_colthes_nav_bar_camera_icon")!.imageWithRenderingMode(.AlwaysOriginal)
        let cameraButton : UIBarButtonItem = UIBarButtonItem(image: cameraImage, style: .Plain, target: self, action:#selector(openCameraButton))
        navigationItem.leftBarButtonItem = cameraButton
        
        let photoImage = UIImage(named: "shoot_colthes_nav_bar_camera_icon")!.imageWithRenderingMode(.AlwaysOriginal)
        let photoButton : UIBarButtonItem = UIBarButtonItem(image: photoImage, style: .Plain, target: self, action:#selector(openPhotoButton))
        navigationItem.rightBarButtonItem = photoButton
        
        view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: self._takeImageView)
        view.addConstraintsWithFormat("V:|-16-[v0]-16-|", views: self._takeImageView)
    }
    
    func setUpDelegate() {
        self._takeImageView.setTestString("aaaaaaaa")
        self._takeImageView.setDelegate(self)
    }
    
    func openCameraButton () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            print("Button capture")
            
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openPhotoButton (sender: AnyObject) {
        print("openPhotoButton")
        
        performSegueWithIdentifier("segueShowPhotoScreen", sender: nil)
    }
    
    
    func didSelectedIamge(image: UIImage) {
        self._takeImageView.image = image
        calculatorImageFrameWithImage(image)
    }
    
    func calculatorImageFrameWithImage(image: UIImage) {
        let sizeImage = image.size;
        let currentSizeScreen = UIScreen.mainScreen().bounds.size
        
        let resultSize = percentSize(sizeImage, sizeScreen: currentSizeScreen)
        
        print("Current Size :\(resultSize)")
        self._takeImageView.frame = CGRectMake(0, 0, resultSize.width, resultSize.height)
    }
    
    func percentSize(sizeImage: CGSize, sizeScreen: CGSize) -> CGSize {
        var resultSize = CGSizeZero
        
        var percentH:CGFloat = (sizeScreen.width - 32)/sizeImage.width
        var percentV:CGFloat = (sizeScreen.height - 32)/sizeImage.height
        
        print("Current percentH :\(percentH), percentV :\(percentV)")
        if sizeImage.width > sizeScreen.width {
            resultSize = CGSizeMake(sizeImage.width*percentH, sizeImage.height*percentV)
        }
        else {
//            percent = sizeScreen.width/(sizeImage.width - 16)
//            resultSize = countdownSizeOnPercent(sizeImage, percent: percent)
        }
        return resultSize;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueShowPhotoScreen") {
            let yourNextViewController = (segue.destinationViewController as! STCPhotoScreen)
            yourNextViewController.delegate = self
        }
    }
    
    // MARK:- # STCAddTextViewDelegate
    func didTouchInSideImage(point: CGPoint) {
        if addTextView == nil {
            let size: CGSize = UIScreen.mainScreen().bounds.size
            addTextView = STCAddTextView.createAddTextView(point, parent: _mainContentView, size: size, delegate: nil)
        }
        else {
            addTextView.moveViewToPoint(point)
        }
        
        _mainContentView.addSubview(addTextView)
    }
    
    func didSelectedView() {
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        print("i've got an image");
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        _takeImageView.image = image
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
        
        // Setup the font specific variables
        let textColor: UIColor = UIColor.whiteColor()
        let textFont: UIFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        //Setup the image context using the passed image.
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ]
        
        //Put the image into a rectangle as large as the original image.
        inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
        
        // Creating a point within the space that is as bit as the image.
        let rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)
        
        //Now Draw the text into an image.
        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return newImage
        
    }
}
