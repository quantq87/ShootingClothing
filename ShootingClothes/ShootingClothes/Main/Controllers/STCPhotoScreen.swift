//
//  STCPhotoScreen.swift
//  ShootingClothes
//
//  Created by Quan Tran on 7/20/16.
//  Copyright © 2016 Quan Tran. All rights reserved.
//

import UIKit

protocol STCPhotoScreenDelegate {
    func didSelectedIamge(image: UIImage)
}

class STCPhotoScreen : STCBaseScreen, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var _photoCollectionView: UICollectionView!
    
    var selectionList = []
    var delegate:STCPhotoScreenDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        setUpScreen()
//        setUpDelegate()
        setUpData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func setUpScreen() {
        super.setUpScreen()
        
        navigationItem.title = "Select Images"
        
        let aFlowLayout = UICollectionViewFlowLayout()
        _photoCollectionView.collectionViewLayout = aFlowLayout
        _photoCollectionView.registerClass(PhotoCell.self, forCellWithReuseIdentifier: "photoCellIdentify")
    }
    
    func setUpData() {
        selectionList = ["Photos Library", "Other"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectionList.count > 0 {
            return selectionList.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCellIdentify", forIndexPath: indexPath) as! PhotoCell
        
        let title = selectionList.objectAtIndex(indexPath.row) as! String
        collectionCell.photoTitleLabel.text = title
        
        return collectionCell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            openPhotosInCamera()
        }
    }
    
    
    func openPhotosInCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil);
        let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.delegate.didSelectedIamge(tempImage)
        navigationController?.popViewControllerAnimated(true)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}

class PhotoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    let thumnailImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blueColor()
        return imageView
    }()
    
    let saparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    
    var photoTitleLabel: UILabel = {
        let label = UILabel(frame:CGRectZero)
        label.font = UIFont.systemFontOfSize(24)
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        return label
    }()
    
    func setUpView() {
        backgroundColor = UIColor.greenColor()
        
        addSubview(thumnailImageView)
        addSubview(saparatorView)
        addSubview(photoTitleLabel)
        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumnailImageView]))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumnailImageView]))
        
        // ex
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[v0]-16-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumnailImageView, "v1": saparatorView]))
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumnailImageView)
        addConstraintsWithFormat("V:|-16-[v0]-16-[v1(1)]|", views: thumnailImageView, saparatorView)
        addConstraintsWithFormat("H:|[v0]|", views: saparatorView)
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: photoTitleLabel)
        addConstraintsWithFormat("V:|-16-[v0]-16-|", views: photoTitleLabel)
        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": saparatorView]))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": saparatorView]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension UIView {
    public func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String : UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
