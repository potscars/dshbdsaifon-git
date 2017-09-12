//
//  DBMenus.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 28/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBMenus: NSObject {
    
    static func dashboardHeader() -> NSArray {
        
        return []
    }
    
    static func dashboardFrontMenu() -> NSArray {
        
        var dictionaryAdd: NSDictionary = ["MenuString":"NULL","ColorObject":"NULL"]
        let compiledArrays: NSMutableArray = [dictionaryAdd]
        
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYKOMUNITI_MS, "IconString":DBImages.DB_ICON_MYKOMUNITI, "ColorObject": DBColorSet.dashboardKBTertiaryColor, "MenuBgImage":DBImages.DB_MENU_BG_MYKOMUNITI]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYSOAL_MS, "IconString":DBImages.DB_ICON_MYSOAL, "ColorObject": DBColorSet.dashboardKBTertiaryColor, "MenuBgImage":DBImages.DB_MENU_BG_MYSOAL]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYSKOOL_MS, "IconString":DBImages.DB_ICON_MYSKOOL, "ColorObject": DBColorSet.dashboardKBTertiaryColor, "MenuBgImage":DBImages.DB_MENU_BG_MYSKOOL]
        compiledArrays.add(dictionaryAdd)
//        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_MYPLACE_MS, "IconString":DBImages.DB_ICON_MYSKOOL, "ColorObject": DBColorSet.dashboardKBTertiaryColor, "MenuBgImage":DBImages.DB_MENU_BG_MYPLACE]
//        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_WATERLEVEL_MS, "IconString":DBImages.DB_ICON_SAIFON, "ColorObject": DBColorSet.dashboardKBTertiaryColor, "MenuBgImage":DBImages.DB_MENU_BG_SAIFON]
        compiledArrays.add(dictionaryAdd)
        dictionaryAdd = ["MenuString":DBStrings.DB_MENU_WEATHER_MS, "IconString":DBImages.DB_ICON_SAIFON, "ColorObject": DBColorSet.dashboardKBTertiaryColor, "MenuBgImage":DBImages.DB_MENU_BG_SAIFON]
        compiledArrays.add(dictionaryAdd)
        
        
        return compiledArrays
    }
    
    static func dashboardSettingsMenu() -> NSArray {
        
        var dictionaryAdd: NSDictionary = [:]
        let compiledArrays: NSMutableArray = []
        
        dictionaryAdd = ["MenuTitle":"NULL","MenuDescription":"NULL","PredefinedSelector":"DB_SETTINGS_REMEMBERME"]
        compiledArrays.add(dictionaryAdd)
        
        return compiledArrays
        
    }

}
