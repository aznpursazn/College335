//
//  ViewController.swift
//  Lab7
//
//  Created by Kathy Nguyen on 10/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var infoTable: UITableView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    
    var cInfo:Informations = Informations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoTable.dataSource = self
        self.infoTable.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cInfo.lengthInfo()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoTableViewCell
        let city = cInfo.getInfo(index: indexPath.row)
        cell.infoLabel.text = "Lat: " + city.lat!.stringValue + " Long: " + city.long!.stringValue
        return cell
    }
    
    @IBAction func search(_ sender: Any) {
        if let loc = locationTextField.text, !loc.isEmpty {
            let geoCoder = CLGeocoder();
            //let addressString = "699, S. Mill Ave, Tempe, AZ, 85281"
            geoCoder.geocodeAddressString(loc, completionHandler:
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
                        
                        let long = Float(coords.longitude)
                        let lat = Float(coords.latitude)
                        
                        self.longLabel.text = String(long)
                        self.latLabel.text = String(lat)
                        
                        self.getJSONData(latitude: lat, longitude: long)
                        
                        self.cInfo.deleteAll()
                    }
            })
        } else {
            let alertError = UIAlertController(title: "Data Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
        }
    }
    
    func getJSONData(latitude: Float, longitude: Float) {
        
        /* make sure to change the user name to change your user name once you have registered in
         http://api.geonames.org/
         */
        
        let longup = String(longitude + 10)
        let longdown = String(longitude - 10)
        let latup = String(latitude + 10)
        let latdown = String(latitude - 10)
        
        let urlAsString = "http://api.geonames.org/earthquakesJSON?formatted=true&north=" + latdown +  "&south=" + latup + "&east=" + longdown + "&west=" + longup + "&username=aznpursazn&style=full"
        
        // http://api.geonames.org/earthquakesJSON?formatted=true&north=44.1&south=-9.9&east=-22.4&west=55.2&username=aznpursazn&style=full
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            let array:NSArray = jsonResult["earthquakes"] as! NSArray
            //            print(array)
            
            
            for item in array {
                var info = item as? [String: AnyObject]
                
                let ln = info?["lng"]! as! NSNumber
                let lt = info?["lat"]! as! NSNumber
                let dt = info?["datetime"]! as! NSString
                let dph = info?["depth"]! as! NSNumber
                let mg = info?["magnitude"]! as! NSNumber
                let sc = info?["src"]! as! NSString
                let eqd = info?["eqid"]! as! NSString
                
                let toAdd = Info(ln: ln, lt: lt, d: dt, dp: dph, m: mg, s: sc, e: eqd)
                self.cInfo.addInfo(info: toAdd)
                
                DispatchQueue.main.async {
                    self.infoTable.reloadData()
                }
                
            }
        })
        
        jsonQuery.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "detailedView") {
            let selectedIndex: IndexPath = self.infoTable.indexPath(for: sender as! UITableViewCell)!
            
            let city = cInfo.getInfo(index: selectedIndex.row)
            
            if let viewController: DetailedViewController = segue.destination as? DetailedViewController {
                viewController.d = city.date
                viewController.dp = city.dep
                viewController.lt = city.lat
                viewController.ln = city.long
                viewController.mg = city.mag
                viewController.eq = city.eqid
                viewController.sc = city.src
            }
            
        }
    }
    
}

