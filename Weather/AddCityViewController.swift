//
//  AddCityViewController.swift
//  Weather
//
//  Created by Dimitri Cadars on 17-11-01.
//  Copyright © 2017 Dimitri Cadars. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD


protocol AddCityDelegate: class {
    func userDidEnterCity(city: City)
}

class AddCityViewController: UIViewController {

    @IBOutlet weak var cityName: UITextField!
    weak var delegate: AddCityDelegate? = nil
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "dab810ea14c5cbdd84666837f1ba850a"
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addCity(_ sender: Any) {
        name = cityName.text!.capitalized
        loadWeather(city: name, completion: { response in
            self.delegate?.userDidEnterCity(city: response)
            self.dismiss(animated: true, completion: nil)
        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addCitySegue" {
            name = cityName.text!.capitalized
        }
    }
    
    func loadWeather(city: String,completion: @escaping (_ success: City) -> Void) {
        
        // Show Loading...
        let hud = MBProgressHUD(view: self.view)
        hud.label.text = "Loading..."
        self.view.addSubview(hud)
        hud.show(animated: true)
        
        Alamofire.request("\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)").responseJSON { (response) in
            hud.hide(animated: true)
            if response.error == nil {
                var cityJSON = JSON(response.result.value!)
                print(cityJSON)
                if cityJSON["cod"].int == 200 {
                    let weather = cityJSON["weather"][0]["description"].string
                    let temp = cityJSON["main"]["temp"].double
                    let cityWeather = City(name: city, temp: temp!, weather: weather!)!
                    completion(cityWeather)
                } else {
                    let alertController = UIAlertController(title: "Weather app",
                                                            message: "Please enter a valid city!",
                                                            preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                    return

                }
            } else {
                print("Error : \(String(describing: response.error))")
                return
            }

        }
        
    }


}
