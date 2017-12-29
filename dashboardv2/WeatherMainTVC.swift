//
//  WeatherMainTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherMainTVC: UITableViewController, CLLocationManagerDelegate {
    
    let sensorFeedNotification: Notification.Name = Notification.Name("saifonSensorFeedNotification")
    var angle: Float = 0.0
    var locManager: CLLocationManager = CLLocationManager.init()
    var latitudePoint: CLLocationDegrees? = nil
    var longitudePoint: CLLocationDegrees? = nil
    var pointerCell: WeatherIntegratedTVCell? = nil
    
    var dataSensorFeed: NSMutableDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        print("[WeatherMainTVC] Geopoint initiating...")
        
        pointerCell = self.tableView.dequeueReusableCell(withIdentifier: "WeatherWindPointCellID") as? WeatherIntegratedTVCell
        
        DBWebServices.getSensorFeed(amount: 1, registeredNotification: sensorFeedNotification.rawValue)
        
        if(CLLocationManager.locationServicesEnabled()) {
            
            print("[WeatherMainTVC] Location service enabled. Initiating location manager...")
            
            self.locManager.delegate = self
            self.locManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locManager.distanceFilter = 100.0
            
            if(self.locManager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization))) {
                self.locManager.requestAlwaysAuthorization()
            }
            
            self.locManager.startUpdatingLocation()
            self.locManager.startUpdatingHeading()
        }
        
        //let geoPoint = ZGeoPoint.init(withLocationManager: self.locManager)
        self.latitudePoint = 48.848093
        self.longitudePoint = 2.294694
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: sensorFeedNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: sensorFeedNotification, object: nil);
        
    }

    @objc func populateData(data: NSNotification) {
        
        let unWrapObject = data.value(forKey: "object") as! NSDictionary
        let statusReceives: Int = unWrapObject.value(forKey: "status") as! Int
        
        if(statusReceives == 1) {
            
            let dataSensorFeedRaw: NSArray = unWrapObject.value(forKey: "data") as! NSArray
            var dataWind: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataTemperature: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataHumidity: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataWindSpeed: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataCO2: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataPressure: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataPM10: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataPM25: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataRainGauge: NSDictionary? = ["first_last_data":["value":"0"]]
            var dataLuminosity: NSDictionary? = ["first_last_data":["value":"0"]]
            
            print("[WeatherMainTVC] Datasensors count is \(dataSensorFeedRaw.count)")
            
            for i in 0...dataSensorFeedRaw.count - 1 {
                
                print("[WeatherMainTVC] Get sensors...")
                
                let getData: NSDictionary = dataSensorFeedRaw.object(at: i) as! NSDictionary
                
                switch(getData.value(forKey: "sensor_id") as! String) {
                    
                    case "CO":
                        
                        print("[Sensors] Carbon Monoxide Detected")
                        
                        dataCO2 = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                        
                        break;
                    
                    case "PRES":
                    
                        print("[Sensors] Pressure Detected")
                        
                        dataPressure = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                    
                        break;
                    
                    case "PLV1":
                    
                        print("[Sensors] Rain Gauge Detected")
                        
                        dataRainGauge = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                    
                        break;
                    
                    case "TC":
                    
                        print("[Sensors] Temperature Detected")
                        
                        dataTemperature = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                    
                        break;
                    
                    case "HUM":
                    
                        print("[Sensors] Humidity Detected")
                        
                        dataHumidity = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                    
                        break;
                    
                    case "PM10":
                    
                        print("[Sensors] PM10 Detected")
                        
                        dataPM10 = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                    
                        break;
                    
                    case "PM2_5":
                    
                        print("[Sensors] PM2.5 Detected")
                        
                        dataPM25 = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                    
                        break;
                    
                    case "ANE":
                    
                        print("[Sensors] Wind Speed Detected")
                        
                        dataWindSpeed = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                        
                        break;
                    
                    case "WV":
                    
                        print("[Sensors] Wind Direction Detected")
                        
                        dataWind = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                    
                        break;
                    
                    case "LUX":
                    
                        print("[Sensors] Luminosity Detected")
                        
                        dataLuminosity = dataSensorFeedRaw.object(at: i) as? NSDictionary ?? ["first_last_data":["value":"0"]]
                    
                        break;
                    
                    default:
                    break;
                    
                }
                
            }
 
            let dataWindFirstLast: NSDictionary = dataWind!.value(forKey: "first_last_data") as! NSDictionary
            let dataTemperatureFirstLast: NSDictionary = dataTemperature!.value(forKey: "first_last_data") as! NSDictionary
            let dataHumidityFirstLast: NSDictionary = dataHumidity!.value(forKey: "first_last_data") as! NSDictionary
            let dataWindSpeedFirstLast: NSDictionary = dataWindSpeed!.value(forKey: "first_last_data") as! NSDictionary
            let dataCO2FirstLast: NSDictionary = dataCO2!.value(forKey: "first_last_data") as! NSDictionary
            let dataPressureFirstLast: NSDictionary = dataPressure!.value(forKey: "first_last_data") as! NSDictionary
            let dataPM10FirstLast: NSDictionary = dataPM10!.value(forKey: "first_last_data") as! NSDictionary
            let dataPM25FirstLast: NSDictionary = dataPM25!.value(forKey: "first_last_data") as! NSDictionary
            let dataRainGaugeFirstLast: NSDictionary = dataRainGauge!.value(forKey: "first_last_data") as! NSDictionary
            let dataLuminosityFirstLast: NSDictionary = dataLuminosity!.value(forKey: "first_last_data") as! NSDictionary
            
            dataSensorFeed["SENSOR_CURRENT_WIND_DIRECTION"] = dataWindFirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_TEMPERATURE"] = dataTemperatureFirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_HUMIDITY"] = dataHumidityFirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_WINDSPEED"] = dataWindSpeedFirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_CO2"] = dataCO2FirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_PRESSURE"] = dataPressureFirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_PM10"] = dataPM10FirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_PM25"] = dataPM25FirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_RAINGAUGE"] = dataRainGaugeFirstLast.value(forKey: "value") ?? "No data"
            dataSensorFeed["SENSOR_CURRENT_LUX"] = dataLuminosityFirstLast.value(forKey: "value") ?? "No data"
            
            print("[WMTVC] Data Sensor Feeds are \(dataSensorFeed)")
            
            
            /*
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_WIND_DIRECTION" as NSCopying )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_TEMPERATURE" as NSCopying )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_HUMIDITY" as NSCopying )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_WINDSPEED" )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_CO2" )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_PRESSURE" )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_PM10" )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_PM25" )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_RAINGAUGE" )
            extractedData?.setObject(dataWindFirstLast.value(forKey: "value") ?? "No data", forKey: "SENSOR_CURRENT_LUX" )
            
            
             let extractedData: NSDictionary = [
             "SENSOR_CURRENT_WIND_DIRECTION":dataWindFirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_TEMPERATURE":dataTemperatureFirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_HUMIDITY":dataHumidityFirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_WINDSPEED":dataWindSpeedFirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_CO2":dataCO2FirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_PRESSURE":dataPressureFirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_PM10":dataPM10FirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_PM25":dataPM25FirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_RAINGAUGE":dataRainGaugeFirstLast.value(forKey: "value") ?? "No data",
             "SENSOR_CURRENT_LUX":dataLuminosityFirstLast.value(forKey: "value") ?? "No data"
             ]
 
            */
            
            
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(dataSensorFeed.count == 0)
        {
            return 1
        }
        else {
            return 4
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        tableView.allowsSelection = false
        
        if(dataSensorFeed.count == 0){
         //WeatherLoadingCellID
            let loadingCell: WeatherIntegratedTVCell? = self.tableView.dequeueReusableCell(withIdentifier: "WeatherLoadingCellID") as? WeatherIntegratedTVCell
            
            loadingCell!.updateLoading()
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            
            return loadingCell!
            
        }
        else {
            
            if(indexPath.row == 0)
            {
                self.pointerCell!.updateCompassPointer(rotationAngle: 0.0)
            
                pointerCell!.updateFirstRowInfo(data: dataSensorFeed)
                tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine

                return self.pointerCell!
            }
            else if(indexPath.row == 1) {
            
                let infoCell: WeatherIntegratedTVCell? = self.tableView.dequeueReusableCell(withIdentifier: "WeatherCoPressureCellID") as? WeatherIntegratedTVCell
            
                infoCell!.updateSecondRowInfo(data: dataSensorFeed)
                tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            
                return infoCell!
            }
            else if(indexPath.row == 2)
            {
                let infoCell: WeatherIntegratedTVCell? = self.tableView.dequeueReusableCell(withIdentifier: "WeatherPM1025CellID") as? WeatherIntegratedTVCell
            
                infoCell!.updateThirdRowInfo(data: dataSensorFeed)
                tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            
                return infoCell!
            }
            else
            {
                let infoCell: WeatherIntegratedTVCell? = self.tableView.dequeueReusableCell(withIdentifier: "WeatherRainLuxCellID") as? WeatherIntegratedTVCell
            
                infoCell!.updateFourthRowInfo(data: dataSensorFeed)
                tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            
                return infoCell!
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(dataSensorFeed.count == 0) {
            return 100
        }
        else {
            if(indexPath.row == 0) {
                return 200
            }
            else {
                return 110
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    func radiansToDegrees(_ rad: Float) -> Float {
        
        return rad * 180.0/Float.pi
        
    }
    
    func degreesToRadians(_ deg: Float) -> Float {
        
        return deg * Float.pi/180.0
        
    }

    
    func calculateAngle(userLocation: CLLocation) -> Float {
        
        print("[WeatherMainTVC] Calculating angle...")
        
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
        
        print("[WeatherMainTVC] New Location: \(locations.last!)")
        
        angle = calculateAngle(userLocation: locations.last!)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("[WeatherMainTVC] Error detected: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        print("[WeatherMainTVC] New Heading: \(newHeading)")
        
        var direction: Float = Float(newHeading.magneticHeading)
        //var direction: Float = Float(DBWindPoint.getWindDegree(fromShortOrdinalDirection: "W"))
        
        if(direction > 180.0) {
            
            direction = 360.0 - direction
            
        }
        else {
            
            direction = 0 - direction
            
        }
        
        print("[WeatherMainTVC] Calculated Direction: \(direction)")
        
        //let degRad: CGFloat = CGFloat(degreesToRadians(direction))
        let degRad: CGFloat = CGFloat(degreesToRadians(Float(DBWindPoint.getWindDegree(fromShortOrdinalDirection: String(describing: dataSensorFeed["SENSOR_CURRENT_WIND_DIRECTION"]!)))))
        //let angled: CGFloat = CGFloat(self.angle)
        let angled: CGFloat = CGFloat(0.0)
        
        let rotatedAngleCalculated: CGFloat = degRad + angled
        
        print("[WeatherMainTVC] Calculated Direction To Rad: \(degRad)")
        print("[WeatherMainTVC] Calculated Angle: \(angled)")
        print("[WeatherMainTVC] Rotated angle calculated: \(rotatedAngleCalculated)")
        
        self.pointerCell!.updateCompassPointer(rotationAngle: rotatedAngleCalculated)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
