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

class MyKomunitiDetailsTVCell: UITableViewCell {

    @IBOutlet weak var uilMKDTVCSender: UILabel!
    @IBOutlet weak var uilMKDTVCLevel: UILabel!
    @IBOutlet weak var uilMKDTVCTitle: UILabel!
    @IBOutlet weak var uilMKDTVCDate: UILabel!
    @IBOutlet weak var uilMKDTVCDesc: UILabel!
    
    @IBOutlet weak var uiivMKDTVCImages: UIImageView!
    @IBOutlet weak var isMKDTVCImagesSlides: ImageSlideshow!
    
    var enlargeImageViewController: UIViewController? = nil
    
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
        
        //uiivMKDTVCImages.image = UIImage.ini
        
    }
    
    func updateImageArrayed(data: NSArray, withViewController: UIViewController) {
        
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
            print("Image in nsdict: \(unwrappedPhotos)")
            
            let selectPhotos: NSDictionary = unwrappedPhotos.value(forKey: "large") as! NSDictionary
            let grabPhotos: String = "\(selectPhotos.value(forKey: "domain") as! String)\(selectPhotos.value(forKey: "full_path") as! String)"
            
            print("photos grabbed: \(grabPhotos)")
            
            arrayPhotos.append(KingfisherSource(urlString: grabPhotos.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!)
            
        }
        
        isMKDTVCImagesSlides.setImageInputs(arrayPhotos)
        
    }
    
    @objc func didTapEnlargeImage() {
        
        isMKDTVCImagesSlides.presentFullScreenController(from: enlargeImageViewController!)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
