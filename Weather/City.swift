//
//  City.swift
//  Weather
//
//  Created by Dimitri Cadars on 17-11-01.
//  Copyright © 2017 Dimitri Cadars. All rights reserved.
//

import UIKit

class City {
    
    //MARK: Properties
    
    var name: String
    var temp: Double
    var weather: String
    
    //MARK: Initialization
    
    init?(name: String, temp: Double, weather: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.temp = temp - 273.15 // kelvin to celsius
        self.weather = weather
        
    }
}
