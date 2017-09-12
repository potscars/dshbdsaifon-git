//
//  MapTasks.swift
//  dashboardKB
//
//  Created by Hainizam on 01/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MapTasks: NSObject {
    
    let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    
    var selectedRoute: Dictionary<NSObject, AnyObject>!
    var overviewPolyline: Dictionary<NSObject, AnyObject>!
    //var originCoordinate: CLLocationCoordinate2D!
    //var destinationCoordinate: CLLocationCoordinate2D!
    var originAddress: String!
    var destinationAddress: String!
    
    override init() {
        super.init()
    }
    
}










