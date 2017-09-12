//
//  HeaderView.swift
//  dashboardKB
//
//  Created by Hainizam on 20/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            
            if let image = image {
                imageView.image = image
            }
        }
    }
}
