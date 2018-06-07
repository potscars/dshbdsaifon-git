//
//  Announcement.swift
//  dashboardKB
//
//  Created by Hainizam on 07/06/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation

struct Announcement {
    
    var id: Int
    var title: String
    var content: String
    var typePost: Int
    var comments: [Comment]?
    var thumbnail: String?
    var images: [String]?
    var dateCreated: String
}
