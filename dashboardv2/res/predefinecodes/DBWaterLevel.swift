//
//  DBWaterLevel.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 02/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBWaterLevel: NSObject {

    static func detectIndicatorNumber(status: String) -> Int {
        
        if(status == "RIVER_IN_SAFE_MODE") {
            return 0
        }
        else if(status == "RIVER_IN_CAUTION_MODE") {
            return 1
        }
        else if(status == "RIVER_IN_WARNING_MODE") {
            return 2
        }
        else if(status == "RIVER_IN_DANGER_MODE") {
            return 3
        }
        else {
            return 3
        }
        
    }
    
    static func waterLevelStatus(currentLevel currLevelStr: String, caution cautionStr: String, warning warningStr: String, danger dangerStr: String) -> NSArray {
        
        //return [RIVER STATUS,BACKGROUNDCOLORINHEX,TEXTCOLORINHEX]
        
        let currInt: Double = Double(currLevelStr)!
        let cautionInt: Double = Double(cautionStr)!
        let warningInt: Double = Double(warningStr)!
        let dangerInt: Double = Double(dangerStr)!
        
        print("[WaterLevelLibrary] Current Level: \(currInt), Caution Level: \(cautionInt), Warning Level: \(warningInt), Danger Level: \(dangerInt)")
        
        if(currInt > dangerInt)
        {
            print("[WaterLevelLibrary] Current: \(currInt), Danger: \(dangerInt), is Danger Mode")
            return ["RIVER_IN_DANGER_MODE","F44336","FFFFFF"]
        }
        else if(currInt > warningInt)
        {
            print("[WaterLevelLibrary] Current: \(currInt), Warning: \(warningInt), is Warning Mode")
            return ["RIVER_IN_WARNING_MODE","FF943B","FFFFFF"]
        }
        else if(currInt > cautionInt)
        {
            print("[WaterLevelLibrary] Current: \(currInt), Caution: \(cautionInt), is Caution Mode")
            return ["RIVER_IN_CAUTION_MODE","FFEB3B","FFFFFF"]
        }
        else
        {
            return ["RIVER_IN_SAFE_MODE","4CAF50","FFFFFF"]
        }
        
    }
    
}
