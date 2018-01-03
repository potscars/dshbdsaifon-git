//
//  MyKomunitiSendMessageTVCell.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class MyKomunitiSendMessageTVCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var uitvMSTVCMsgContent: UITextView!
    @IBOutlet weak var uiivMKSTVCImagePicked: UIImageView!
    @IBOutlet weak var nslcMKSTVCImagePickedConstraint: NSLayoutConstraint!
    var imageInArray: NSMutableArray = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMsgContent() {
        
        uitvMSTVCMsgContent.delegate = self
        uitvMSTVCMsgContent.sizeToFit()
        uitvMSTVCMsgContent.layoutIfNeeded()
        uitvMSTVCMsgContent.isScrollEnabled = false
        
    }
    
    func setAddImageBtn(parentViewController: UIViewController, notificationName: String) {
        
        let imgPicker: BSImagePickerViewController = BSImagePickerViewController()
        
        parentViewController.bs_presentImagePickerController(imgPicker, animated: true,
            select: { (asset: PHAsset) -> Void in
            print("Asset selected: \(asset)")
        },
            deselect: { (asset: PHAsset) -> Void in
                print("Asset deselected: \(asset)")
        },
            cancel: { (asset: [PHAsset]) -> Void in
                print("Asset cancelled: \(asset)")
        },
            finish: { (asset: [PHAsset]) -> Void in
                print("Asset finished: \(asset)")
                
                for i in 0...asset.count - 1 {
                    
                    self.convertToImage(fromAsset: asset[i])
                }
                NotificationCenter.default.post(name: Notification.Name(notificationName), object: self.imageInArray)
        },
            completion: { () -> Void in
                
                
        })

    }

    func updateImageCell(data: UIImage) {
        
        //uiivMKSTVCImagePicked.image = data
        self.imageSet(image: data)
    }
    
    func convertToImage(fromAsset: PHAsset) {
        
        let photoManager: PHImageManager = PHImageManager.default()
        let pManOptions: PHImageRequestOptions = PHImageRequestOptions.init()
        pManOptions.isSynchronous = true
        photoManager.requestImage(for: fromAsset, targetSize: CGSize(width: fromAsset.pixelWidth, height: fromAsset.pixelHeight), contentMode: PHImageContentMode.aspectFit, options: pManOptions, resultHandler: {(result, info) -> Void in
            
            self.imageInArray.add(result!)
            
        })
        
        
    }
    
    func imageSet(image: UIImage) {
        
        let heightPoint: CGFloat = image.size.height
        let widthPoint: CGFloat = image.size.width
        
        let heightPointDivideToTwo: CGFloat = heightPoint / 6
        let widthPointDivideToTwo: CGFloat = widthPoint / 6
        
        print("retrieved height: \(heightPoint) and width: \(widthPoint)")
        print("divided height: \(heightPointDivideToTwo) and width: \(widthPointDivideToTwo)")
        
        let gcd = aspectRatioCalc(a: 1920,b: 1080)
        
        print("aspectRatio: \(1920 / gcd) and \(1080 / gcd)")
        
        uiivMKSTVCImagePicked.image = image
        uiivMKSTVCImagePicked.frame.size = CGSize.init(width: widthPointDivideToTwo, height: heightPointDivideToTwo)
        uiivMKSTVCImagePicked.bounds.size = CGSize.init(width: widthPointDivideToTwo, height: heightPointDivideToTwo)
        uiivMKSTVCImagePicked.removeConstraint(nslcMKSTVCImagePickedConstraint)
        nslcMKSTVCImagePickedConstraint = NSLayoutConstraint.init(item: uiivMKSTVCImagePicked, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: uiivMKSTVCImagePicked, attribute: NSLayoutAttribute.width, multiplier: heightPointDivideToTwo / widthPointDivideToTwo, constant: 0)
        uiivMKSTVCImagePicked.addConstraint(nslcMKSTVCImagePickedConstraint)
        uiivMKSTVCImagePicked.setNeedsDisplay()
        
    }
    
    func aspectRatioCalc(a: Int, b: Int) -> Int{
        
        var aa = a
        var bb = b
        
        while (aa != 0 && bb != 0) {
            if (aa > bb) {
                aa %= bb
            }
            else {
                bb %= aa
            }
        }
        
        if (aa == 0) {
            return bb
        }
        else {
            return aa
        }
        
    }
}
