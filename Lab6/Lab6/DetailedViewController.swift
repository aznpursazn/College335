//
//  DetailedViewController.swift
//  Lab6
//
//  Created by Kathy Nguyen on 10/22/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailedViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var manager:CLLocationManager!
    
    var city:String!
    var lat:CLLocationDegrees!
    var long:CLLocationDegrees!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        cityName.text = city
        latitude.text = String(lat)
        longitude.text = String(long)
        
        self.addMainLocation()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func search(_ sender: Any) {
        let request = MKLocalSearch.Request()
        guard let searchBox = textField.text else {
            print("Error: Incorrect input")
            return
        }
        request.naturalLanguageQuery = searchBox
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print( response.mapItems )
            
            // Reload map
            let allAnnotations = self.map.annotations
            self.map.removeAnnotations(allAnnotations)
            
            self.addMainLocation()
            
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                guard let placeLat = place.location?.coordinate.latitude else {
                    print("Error: No latitude")
                    return
                }
                guard let placeLong = place.location?.coordinate.longitude else {
                    print("Error: No longitude")
                    return
                }
                guard let placeName = place.name else {
                    print("Error: No name")
                    return
                }
                
                let coordinates = CLLocationCoordinate2D( latitude: placeLat, longitude: placeLong)
            
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                annotation.title = place.name
                
                self.map.addAnnotation(annotation)
                
                print(placeLat)
                print(placeLong)
                print(placeName)
            }
        }
    }
    
    @IBAction func showMap(_ sender: Any) {
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
            
        case 1:
            map.mapType = MKMapType.satellite
            
        default:
            map.mapType = MKMapType.standard
        }
        
        self.addMainLocation()
    }
    
    func addMainLocation() {
        let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: long)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
        
        self.map.setRegion(region, animated: true)
        
        // add an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = city
        
        self.map.addAnnotation(annotation)
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
