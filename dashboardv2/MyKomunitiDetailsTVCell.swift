//
//  MyKomunitiDetailsTVCell.swift
//  dashboardv2
//
//  Cell-id Sender: MyKomunitiDetailsSenderCellID
//  Cell-id Title: MyKomunitiDetailsTitleCellID
//  Cell-id Desc: MyKomunitiDetailsDescCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 04/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher

class MyKomunitiDetailsTVCell: UITableViewCell {

    @IBOutlet weak var uilMKDTVCSender: UILabel!
    @IBOutlet weak var uilMKDTVCLevel: UILabel!
    @IBOutlet weak var uilMKDTVCTitle: UILabel!
    @IBOutlet weak var uilMKDTVCDate: UILabel!
    @IBOutlet weak var uilMKDTVCDesc: UILabel!
    
    @IBOutlet weak var uiivMKDTVCImages: UIImageView!
    @IBOutlet weak var isMKDTVCImagesSlides: ImageSlideshow!
    
    var enlargeImageViewController: UIViewController? = nil
    var parentViewController: UIViewController? = nil
    
    @IBOutlet weak var uibMKDTVCDldImg: UIButton!
    
    var imageUrlsInArray: NSMutableArray = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateSenderCell(data: NSDictionary)
    {
        uilMKDTVCSender.text = data.value(forKey: "MESSAGE_SENDER") as? String ?? "Tiada Nama Penghantar"
        uilMKDTVCLevel.text = data.value(forKey: "MESSAGE_LEVEL") as? String ?? "Tidak Diketahui"
    }
    
    func updateTitleCell(data: NSDictionary)
    {
        uilMKDTVCTitle.text = data.value(forKey: "MESSAGE_TITLE") as? String ?? "Tiada Tajuk"
        uilMKDTVCDate.text = ZDateTime.dateFormatConverter(valueInString: data.value(forKey: "MESSAGE_DATE") as! String, dateTimeFormatFrom: nil, dateTimeFormatTo: ZDateTime.DateInLong)
    }
    
    func updateDescCell(data: NSDictionary)
    {
        uilMKDTVCDesc.text = ZParsers.parseAllHTMLStrings(stringToParse: data.value(forKey: "MESSAGE_DESC") as? String) ?? "Tiada Huraian"
    }
    
    func updateImage(data: NSDictionary) {
        
        let combinationPath: String = "\(DBSettings.mainURL)\(data.value(forKey: "full_path")!)"
        
        print("Path combined: \(combinationPath)")
        
        ZImages.getImageFromUrlSession(fromURL: combinationPath, defaultImage: "ic_imagebroken", imageView: self.uiivMKDTVCImages)
        
    }
    
    func updateImageArrayed(data: NSArray, withViewController: UIViewController) {
        
        parentViewController = withViewController
        enlargeImageViewController = withViewController
        
        isMKDTVCImagesSlides.backgroundColor = UIColor.darkGray
        isMKDTVCImagesSlides.slideshowInterval = 5.0
        isMKDTVCImagesSlides.pageControlPosition = PageControlPosition.underScrollView
        isMKDTVCImagesSlides.pageControl.currentPageIndicatorTintColor = UIColor.black
        //isMKDTVCImagesSlides.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapEnlargeImage))
        isMKDTVCImagesSlides.addGestureRecognizer(recognizer)
        
        var arrayPhotos: [KingfisherSource] = []
        
        for i in 0...data.count - 1 {
            
            let unwrappedPhotos: NSDictionary = data.object(at: i) as! NSDictionary
            let selectPhotos: NSDictionary = unwrappedPhotos.value(forKey: "large") as! NSDictionary
            let grabPhotos: String = "\(selectPhotos.value(forKey: "domain") as! String)\(selectPhotos.value(forKey: "full_path") as! String)"
            
            print("photos grabbed: \(grabPhotos)")
            
            imageUrlsInArray.add(grabPhotos)
            arrayPhotos.append(KingfisherSource(urlString: grabPhotos.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!)
            
        }
        
        isMKDTVCImagesSlides.setImageInputs(arrayPhotos)
        isMKDTVCImagesSlides.currentPageChanged = { page in print("current page changed \(page)") }

        uibMKDTVCDldImg.addTarget(self, action: #selector(performDownloadImage(sender:)), for: UIControlEvents.touchUpInside)
        
    }
    
    @objc func didTapEnlargeImage() {
        
        isMKDTVCImagesSlides.presentFullScreenController(from: enlargeImageViewController!)
        
    }
    
    @objc func performDownloadImage(sender: UIButton) {
        
        uibMKDTVCDldImg.titleLabel?.text = "Sedang memuatturun..."
        uibMKDTVCDldImg.isEnabled = false
        
        ImageDownloader.default.downloadImage(with: URL.init(string: self.imageUrlsInArray.object(at: isMKDTVCImagesSlides.currentPage) as! String)!, retrieveImageTask: nil, options: nil, progressBlock: nil, completionHandler: { image, error, url, data in

            if let error = error {
                
                ZUIs.showOKDialogBox(viewController: self.parentViewController!, dialogTitle: "Masalah", dialogMessage: "Gambar gagal disimpan. Sila hubungi petugas untuk tindakan. (\(error))", afterDialogDismissed: nil)
                
                self.uibMKDTVCDldImg.titleLabel?.text = "Muaturun Gambar"
                self.uibMKDTVCDldImg.isEnabled = true
                
            }
            else {
                UIImageWriteToSavedPhotosAlbum(image!, self, #selector(self.saveImage(image:error:context:)), nil)
            }
        })
        
    }
    
    @objc func saveImage(image: UIImage, error: NSError?, context: UnsafeRawPointer) {
        if let error = error {
            print("not saved \(error)")
            ZUIs.showOKDialogBox(viewController: self.parentViewController!, dialogTitle: "Masalah", dialogMessage: "Gambar gagal disimpan. Sila hubungi petugas untuk tindakan. (\(error))", afterDialogDismissed: nil)
            
            self.uibMKDTVCDldImg.titleLabel?.text = "Muaturun Gambar"
            self.uibMKDTVCDldImg.isEnabled = true
        }
        else {
            print("saved")
            ZUIs.showOKDialogBox(viewController: self.parentViewController!, dialogTitle: "Disimpan", dialogMessage: "Gambar ini telah disimpan. Sila periksa di Photos.", afterDialogDismissed: nil)
            
            self.uibMKDTVCDldImg.titleLabel?.text = "Muaturun Gambar"
            self.uibMKDTVCDldImg.isEnabled = true
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
