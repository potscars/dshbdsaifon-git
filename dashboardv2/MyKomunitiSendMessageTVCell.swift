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
        
        uiivMKSTVCImagePicked.image = data
    }
    
    func convertToImage(fromAsset: PHAsset) {
        
        let photoManager: PHImageManager = PHImageManager.default()
        let pManOptions: PHImageRequestOptions = PHImageRequestOptions.init()
        pManOptions.isSynchronous = true
        photoManager.requestImage(for: fromAsset, targetSize: CGSize(width: 600, height: 200), contentMode: PHImageContentMode.aspectFit, options: pManOptions, resultHandler: {(result, info) -> Void in
        
            
            
            self.imageInArray.add(result!)
            
        })
        
        
    }

}
