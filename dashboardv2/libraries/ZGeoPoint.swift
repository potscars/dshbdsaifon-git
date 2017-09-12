//
//  ZGeoPoint.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import CoreLocation

class ZGeoPoint: NSObject, CLLocationManagerDelegate {
    
    var angle: Float? = nil
    var locManager: CLLocationManager = CLLocationManager.init()
    var latitudePoint: CLLocationDegrees? = nil
    var longitudePoint: CLLocationDegrees? = nil

    func radiansToDegrees(_ rad: Float) -> Float {
        
        return rad * 180.0/Float.pi
        
    }
    
    func degreesToRadians(_ deg: Float) -> Float {
        
        return deg * Float.pi/180.0
        
    }
    
    override init() {
        
        super.init()
        
    }
    
    convenience init (withLocationManager locationMgr: CLLocationManager) {
        
        self.init()
        
        print("[ZGeoPoint] Geopoint initiating...")
        
        self.locManager = locationMgr
        
    }
    
    
    func calculateAngle(userLocation: CLLocation) -> Float {
        
        print("[ZGeoPoint] Calculating angle...")
        
        let userLocationLatitude: Float = degreesToRadians(Float(userLocation.coordinate.latitude))
        let userLocationLongitude: Float = degreesToRadians(Float(userLocation.coordinate.longitude))
        
        let latPointTargeted: Float = degreesToRadians(Float(latitudePoint!))
        let lonPointTargeted: Float = degreesToRadians(Float(longitudePoint!))
        
        let lonDiff: Float = lonPointTargeted - userLocationLongitude
        
        let y: Float = sinf(lonDiff) * cosf(latPointTargeted)
        let x: Float = cosf(userLocationLatitude) * sinf(latPointTargeted) - sinf(userLocationLatitude) * cosf(latPointTargeted) * cosf(lonDiff)
        
        var radiansValue: Float = atan2f(y, x)
        
        if(radiansValue < 0.0) {
            
            radiansValue += 2 * Float.pi
            
        }
        
        return radiansValue
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("[ZGeoPoint] New Location: \(locations.last!)")
        
        angle = calculateAngle(userLocation: locations.last!)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("[ZGeoPoint] Error detected: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        print("[ZGeoPoint] New Heading: \(newHeading)")

        
        var direction: Float = Float(newHeading.magneticHeading)
        
        if(direction > 180.0) {
            
           direction = 360.0 - direction
            
        }
        else {
            
            direction = 0 - direction
            
        }
        
    }
    
}
