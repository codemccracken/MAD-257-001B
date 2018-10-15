//
//  ViewController.swift
//  MacWeatherAp
//
//  Created by Eric McCracken on 10/14/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
   
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.forecast.io/forecast/d3250bf407f0579c8355cd39cdd4f9e1/42.2111,-88.3162"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print("\(String(describing: error))")
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    let currentConditions = parsedData["currently"] as! [String:Any]
                    
                    //print(currentConditions)
                    
                    let currentTemperatureF = currentConditions["temperature"] as! Double
                    //print(currentTemperatureF)
                    self.currentTempLabel.text = "\(currentTemperatureF)"
                    let currentSummary = currentConditions["summary"] as! String
                    //print(currentSummary)
                    self.currentSummaryLabel.text = "\(currentSummary)"
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
    
}
