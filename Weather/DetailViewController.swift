//
//  DetailViewController.swift
//  Weather
//
//  Created by Dimitri Cadars on 17-11-01.
//  Copyright © 2017 Dimitri Cadars. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityWeather: UILabel!
    
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName.text = city.name
        cityTemp.text = String(format: "%.2f",city.temp) + "°C"
        cityWeather.text = city.weather

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
