//
//  STCHomeScreen.swift
//  ShootingClothes
//
//  Created by Quan Tran on 7/11/16.
//  Copyright © 2016 Quan Tran. All rights reserved.
//

import UIKit
import MobileCoreServices

class STCHomeScreen: STCBaseScreen, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var _takeImageView: UIImageView!
    var imagePicker:UIImagePickerController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScreen()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func setUpScreen() {
        super.setUpScreen()
        
        let selectedImage = UIImage(named: "shoot_colthes_nav_bar_camera_icon")!.imageWithRenderingMode(.AlwaysOriginal)
        let cameraButton : UIBarButtonItem = UIBarButtonItem(image: selectedImage, style: .Plain, target: self, action:#selector(openCameraButton))
        navigationItem.leftBarButtonItem = cameraButton
        
        
        let addTextView = STCAddTextView.createAddTextView(CGPointMake(5, 70), delegate: nil)
        view.addSubview(addTextView)
        
    }
    
    func openCameraButton () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            print("Button capture")
            
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
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
