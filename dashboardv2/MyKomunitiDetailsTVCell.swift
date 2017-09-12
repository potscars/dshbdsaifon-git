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

class MyKomunitiDetailsTVCell: UITableViewCell {

    @IBOutlet weak var uilMKDTVCSender: UILabel!
    @IBOutlet weak var uilMKDTVCLevel: UILabel!
    @IBOutlet weak var uilMKDTVCTitle: UILabel!
    @IBOutlet weak var uilMKDTVCDate: UILabel!
    @IBOutlet weak var uilMKDTVCDesc: UILabel!
    
    @IBOutlet weak var uiivMKDTVCImages: UIImageView!
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
