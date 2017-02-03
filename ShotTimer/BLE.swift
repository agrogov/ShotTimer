//
//  BLE.swift
//  ShotTimer
//
//  Created by Dr. Morg on 02.02.17.
//  Copyright © 2017 Alexey Rogov. All rights reserved.
//

import UIKit
import Foundation
import CoreBluetooth

let deviceName = "ShotTimer"
// Service UUIDs
let UARTServiceUUID = CBUUID(string: "0000ffe0-0000-1000-8000-00805f9b34fb")
// Characteristic UUIDs
let RXTXCharUUID = CBUUID(string: "0000ffe1-0000-1000-8000-00805f9b34fb")


class Sensors {
    
    // Check name of device from advertisement data
    class func sensorsFound (_ advertisementData: [AnyHashable: Any]!) -> Bool {
        let nameOfDeviceFound = (advertisementData as NSDictionary).object(forKey: CBAdvertisementDataLocalNameKey) as? String
        return (nameOfDeviceFound == deviceName)
    }
    
    // Check if the service has a valid UUID
    class func validService (_ service : CBService) -> Bool {
        if service.uuid == UARTServiceUUID {
            return true
        }
        else {
            return false
        }
    }
    
    // Check if the characteristic has a valid data UUID
    class func validDataCharacteristic (_ characteristic : CBCharacteristic) -> Bool {
        if characteristic.uuid == RXTXCharUUID {
            return true
        }
        else {
            return false
        }
    }
    
    // Get labels of all sensors
    class func getSensorLabels () -> [String] {
        let sensorLabels : [String] = [
            "BLE ET",
            "BLE BT"
        ]
        return sensorLabels
    }
    
    // Process the values from sensor
    // Convert NSData to Strings
    // Parsing string from Arduino
    class func getETBT(_ value : Data) -> [String] {
        var dataFromSensor = String(data: value, encoding: String.Encoding.utf8)!
        dataFromSensor = dataFromSensor.replacingOccurrences(of: "\r\n", with: "")
        let array = dataFromSensor.components(separatedBy: ",")
        return array
    }
    
}

class SensorsTableViewCell: UITableViewCell {
    
    var sensorNameLabel  = UILabel()
    var sensorValueLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // sensor name
        self.addSubview(sensorNameLabel)
        sensorNameLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        sensorNameLabel.frame = CGRect(x: self.bounds.origin.x+self.layoutMargins.left*2, y: self.bounds.origin.y, width: self.frame.width, height: self.frame.height)
        sensorNameLabel.textAlignment = NSTextAlignment.left
        sensorNameLabel.text = "Sensor Name Label"
        
        // sensor value
        self.addSubview(sensorValueLabel)
        sensorValueLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        sensorValueLabel.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.frame.width, height: self.frame.height)
        sensorValueLabel.textAlignment = NSTextAlignment.right
        sensorValueLabel.text = "Value"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
