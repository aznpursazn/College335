//
//  ViewController.swift
//  Lab5
//
//  Created by Kathy Nguyen on 10/19/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var cityTable: UITableView!
    
    var cm:CityModel = CityModel();
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cm.fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        
        let rowdata = cm.getCityObject(row: indexPath.row)
        cell.nameLabel?.text = rowdata.name
        if let image = rowdata.image {
            cell.imageBox?.image = UIImage(data: image as Data)
        } else {
            cell.imageBox?.image = nil
        }
        
        return cell
    }
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            cm.removeCity(row: indexPath.row)
            // reload the table after deleting a row
            cm.updateObject()
            cityTable.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTable.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailedView") {
            let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
            
            let city = cm.getCityObject(row: selectedIndex.row)
            
            if let viewController: DetailedViewController = segue.destination as? DetailedViewController {
                viewController.city = city.name
                viewController.image = city.image;
                viewController.info = city.info;
            }
        }
    }
    
        @IBAction func addCity(_ sender: Any) {
            // ALERT 1 - NAME
            let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Enter Name of City"
            })
    
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                if let name = alert.textFields?.first?.text, !name.isEmpty {
                    print("City name: \(name)")
    
                    // ALERT 2 - DESCRIPTION
                    let alert2 = UIAlertController(title: "Add Description", message: nil, preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
    
                    alert2.addTextField(configurationHandler: { textField in
                        textField.placeholder = "Enter Name of Description of City"
                    })
    
                    alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        if let describe = alert2.textFields?.first?.text, !describe.isEmpty {
                            print("Description: \(describe)")
    
                            // ALERT 3 - IMAGE
                            let alert3 = UIAlertController(title: "Add Image", message: nil, preferredStyle: .alert)
                            
                            alert3.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                                
                                // remove it from the coredata because image was cancelled
                                self.cm.removeCity(row: self.cm.fetchRecord() - 1)
                                // reload the data
                                self.cityTable.reloadData()
                                
                            } ))
                            
                            alert3.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                                let photoPicker = UIImagePickerController ()
                                photoPicker.delegate = self
                                photoPicker.sourceType = .photoLibrary
                                // display image selection view
                                self.present(photoPicker, animated: true, completion: nil)
    
                            } ))
    
                            self.present(alert3, animated: true)
                            // END OF ALTER 3
    
                            self.cm.addCity(n: name, d: describe)
    
                            self.cm.updateObject()
    
                            self.cityTable.reloadData()
                        }
                        else {
                            let alertError = UIAlertController(title: "Data Input Error", message: "Correct data input is required.", preferredStyle: .alert)
    
                            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alertError, animated: true)
                        }
                    }))
    
                    self.present(alert2, animated: true)
                    // END OF ALERT 2
    
                }
                else {
                    let alertError = UIAlertController(title: "Data Input Error", message: "Correct data input is required.", preferredStyle: .alert)
    
                    alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertError, animated: true)
                }
            }))
            self.present(alert, animated: true)
            // END OF ALERT 1
    
        }
    
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
            picker .dismiss(animated: true, completion: nil)
    
            // fetch resultset has the recently added row without the image
            // this code ad the image to the row
            if let city = cm.fetchResults.last {
                guard let image = info[.originalImage] as? UIImage else {
                    fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                }
                city.image = image.pngData()! as NSData
                cm.updateObject()
                cityTable.reloadData()
            }
        }

}

