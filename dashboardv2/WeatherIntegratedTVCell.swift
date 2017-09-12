//
//  WeatherIntegratedTVCell.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class WeatherIntegratedTVCell: UITableViewCell {
    
    @IBOutlet weak var uilWITVCTempValue: UILabel!
    @IBOutlet weak var uilWITVCHumidValue: UILabel!
    @IBOutlet weak var uilWITVCWindSpeedValue: UILabel!
    
    @IBOutlet weak var uivWITVCCO2Panel: UIView!
    @IBOutlet weak var uiivWITVCCO2Icon: UIImageView!
    @IBOutlet weak var uilWITVCCO2Name: UILabel!
    @IBOutlet weak var uilWITVCCO2Value: UILabel!
    
    @IBOutlet weak var uilWITVCPressurePanel: UIView!
    @IBOutlet weak var uiivWITVCPressureIcon: UIImageView!
    @IBOutlet weak var uilWITVCPressureName: UILabel!
    @IBOutlet weak var uilWITVCPressureValue: UILabel!
    
    @IBOutlet weak var uivWITVCPM10Panel: UIView!
    @IBOutlet weak var uiivWITVCPM10Icon: UIImageView!
    @IBOutlet weak var uilWITVCPM10Name: UILabel!
    @IBOutlet weak var uilWITVCPM10Value: UILabel!
    
    @IBOutlet weak var uivWITVCPM25Panel: UIView!
    @IBOutlet weak var uiivWITVCPM25Icon: UIImageView!
    @IBOutlet weak var uilWITVCPM25Name: UILabel!
    @IBOutlet weak var uilWITVCPM25Value: UILabel!
    
    @IBOutlet weak var uivWITVCRainPanel: UIView!
    @IBOutlet weak var uiivWITVCRainIcon: UIImageView!
    @IBOutlet weak var uivWITVCRainName: UILabel!
    @IBOutlet weak var uilWITVCRainValue: UILabel!
    
    @IBOutlet weak var uivWITVCLuxPanel: UIView!
    @IBOutlet weak var uiivWITVCLuxIcon: UIImageView!
    @IBOutlet weak var uilWITVCLuxName: UILabel!
    @IBOutlet weak var uilWITVCLuxValue: UILabel!
    
    
    @IBOutlet weak var uivWITVCCompassPointer: UIImageView!

    
    //loading
    @IBOutlet weak var uilWITVCLoadingLabel: UILabel!
    @IBOutlet weak var uiaivWITVCLoadingIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCompassPointer(rotationAngle: CGFloat)
    {
        
        //self.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "ic_saifonweather_bg")!)
        
        if((self.uivWITVCCompassPointer) != nil)
        {
            UIView.animate(withDuration: 3.0, animations: { () -> Void in
                
                self.uivWITVCCompassPointer.transform = CGAffineTransform.init(rotationAngle: rotationAngle)
                
            })
        }
        
    }
    
    func updateFirstRowInfo(data: NSDictionary?) {
        
        uilWITVCTempValue.text = "Kota Belud \n \(data!["SENSOR_CURRENT_TEMPERATURE"] as? String ?? "0") ° c"
        uilWITVCHumidValue.text = "\(data!.value(forKey: "SENSOR_CURRENT_HUMIDITY") as? String ?? "0") % \n Kelembapan"
        uilWITVCWindSpeedValue.text = "\(data!.value(forKey: "SENSOR_CURRENT_WINDSPEED") as? String ?? "0") kph \n kelajuan angin"
        
    }
    
    func updateSecondRowInfo(data: NSDictionary) {
        
        //uivWITVCCO2Panel
        //uiivWITVCCO2Icon
        uilWITVCCO2Name.text = "Karbon Monoksida"
        uilWITVCCO2Value.text = "\(data["SENSOR_CURRENT_CO2"] as? String ?? "0") PPM"

        
        //uilWITVCPressurePanel: UIView!
        //uiivWITVCPressureIcon: UIImageView!
        uilWITVCPressureName.text = "Tekanan Udara"
        uilWITVCPressureValue.text = "\(data["SENSOR_CURRENT_PRESSURE"] as? String ?? "0") kPa"
        
    }
    
    func updateThirdRowInfo(data: NSDictionary) {
        
        //uivWITVCPM10Panel
        //uiivWITVCPM10Icon
        uilWITVCPM10Name.text = "PM10"
        uilWITVCPM10Value.text = "\(data["SENSOR_CURRENT_PM10"] as? String ?? "0") PPM"
        
        //uivWITVCPM25Panel
        //uiivWITVCPM25Icon
        uilWITVCPM25Name.text = "PM2.5"
        uilWITVCPM25Value.text = "\(data["SENSOR_CURRENT_PM25"] as? String ?? "0") PPM"
        
    }
    
    func updateFourthRowInfo(data: NSDictionary) {
        
        //uivWITVCRainPanel
        //uiivWITVCRainIcon
        uivWITVCRainName.text = "Tolok Hujan"
        uilWITVCRainValue.text = "\(data["SENSOR_CURRENT_RAINGAUGE"] as? String ?? "0") mm/h"
        
        //uivWITVCLuxPanel
        //uiivWITVCLuxIcon
        uilWITVCLuxName.text = "Pancaran"
        uilWITVCLuxValue.text = "\(data["SENSOR_CURRENT_LUX"] as? String ?? "0") lux"
        
        
    }
    
    func updateLoading() {
        
        uiaivWITVCLoadingIndicator.startAnimating()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
