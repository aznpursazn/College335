//
//  ViewController.swift
//  Lab6
//
//  Created by Kathy Nguyen on 10/22/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cityTable: UITableView!
    var myCitiesList:Cities = Cities()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCitiesList.numOfCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as! CityTableViewCell
        let city = myCitiesList.getCity(index: indexPath.row)
        cell.cityName.text = city.cityName
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTable.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addCity(_ sender: Any) {
        // BEGIN ALERT 1
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of City"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text, !name.isEmpty {
                let geoCoder = CLGeocoder();
                //let addressString = "699, S. Mill Ave, Tempe, AZ, 85281"
                let addressString = name.capitalized
                geoCoder.geocodeAddressString(addressString, completionHandler:
                    {(placemarks, error) in
                        
                        if error != nil {
                            print("Geocode failed: \(error!.localizedDescription)")
                        } else if placemarks!.count > 0 {
                            let placemark = placemarks![0]
                            let location = placemark.location
                            let coords = location!.coordinate
                            guard let loc = location else {
                                print("Error: Placemark.location")
                                return
                            }
                            print(loc)
                            
                            let addC = City(cn: name.capitalized, lat: coords.latitude, long: coords.longitude)
                            self.myCitiesList.addCity(city: addC)
                            
                            print("City name: \(name)")
                            self.cityTable.reloadData()
                        }
                })
            } else {
                let alertError = UIAlertController(title: "Data Input Error", message: "Correct data input is required.", preferredStyle: .alert)
                
                alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alertError, animated: true)
            }
        }))
        self.present(alert, animated: true)
        // END OF ALERT 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailedView") {
            let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
            let city = myCitiesList.cities[selectedIndex.row]
            
            if let viewController: DetailedViewController = segue.destination as? DetailedViewController {
                viewController.city = city.cityName
                viewController.lat = city.latitude
                viewController.long = city.longitude
            }
            
        }
    }
    
}

