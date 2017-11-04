//
//  TableViewController.swift
//  Weather
//
//  Created by Dimitri Cadars on 17-11-01.
//  Copyright © 2017 Dimitri Cadars. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController, AddCityDelegate {

    // MARK : Variables
    var cities = [City]()
    var newCity: City!
    var cityToPass: City!
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.cityName.text = cities[indexPath.row].name
        cell.cityTemp.text = String(format: "%.2f",(cities[indexPath.row].temp)) + "°C"
        cell.cityDescriptionWeather.text = cities[indexPath.row].weather
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityToPass = cities[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showDetail") {
            let detailVC = segue.destination as! DetailViewController
            detailVC.city = cityToPass
        }
        
        if (segue.identifier == "addCity"){
            let addCityVC = segue.destination as! AddCityViewController
            addCityVC.delegate = self
        }
    }
    
    func userDidEnterCity(city: City) {
        cities.append(city)
        self.tableView.reloadData()
    }
    

}
