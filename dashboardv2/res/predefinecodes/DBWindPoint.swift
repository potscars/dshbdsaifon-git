//
//  DBWindPoint.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 07/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBWindPoint: NSObject {
    
    static func getWindDegree(fromShortOrdinalDirection: String) -> CGFloat {
        
        var degree: CGFloat = 0.0
        
        switch (fromShortOrdinalDirection) {
            
            case "N":
                degree = 0.0
            break
            
            case "NNE":
                degree = 22.5
            break
            
            case "NE":
                degree = 45.0
            break
            
            case "ENE":
                degree = 67.5
            break
            
            case "E":
                degree = 90.0
            break
            
            case "ESE":
                degree = 112.5
            break
            
            case "SE":
                degree = 22.5
            break
            
            case "SSE":
                degree = 135.0
            break
            
            case "S":
                degree = 180.0
            break
            
            case "SSW":
                degree = 202.5
            break
            
            case "SW":
                degree = 225.0
            break
            
            case "WSW":
                degree = 247.5
            break
            
            case "W":
                degree = 270.0
            break
            
            case "WNW":
                degree = 292.5
            break
            
            case "NW":
                degree = 315
            break
            
            case "NNW":
                degree = 337.5
            break
            
            default:
                degree = 360.0
            break
            
        }
        
        return degree
        
    }

}
