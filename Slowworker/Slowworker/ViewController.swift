//
//  ViewController.swift
//  Slowworker
//
//  Created by Eric McCracken on 10/16/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var resultsTextView: UITextView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "Hi There"
    }
    
    func processData(data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    func calculateFirstResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        return "Number of chars: \(data.count)"
    }
    
    func calculateSecondResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
    
    @IBAction func doWork(sender: AnyObject) {
        let startTime = NSDate()
        resultsTextView.text = ""
        startButton.isEnabled = false
        spinner.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        
        queue.async() {
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(data: fetchedData)
//            let firstResult = self.calculateFirstResult(data: processedData)
//            let secondResult = self.calculateSecondResult(data: processedData)
            var firstResult: String!
            var secondResult: String!
            let group = DispatchGroup()
            
            queue.async(group: group) {
                firstResult = self.calculateFirstResult(data: processedData)
            }
            
            queue.async(group: group) {
                secondResult = self.calculateSecondResult(data: processedData)
            }
            group.notify(queue: queue) {
                let resultsSummary = "First: [\(firstResult!)] \n Second: [\(secondResult!)]"
//                print("\(resultsSummary)")
                DispatchQueue.main.async {
                    self.resultsTextView.text = resultsSummary
                    self.startButton.isEnabled = true
                    self.spinner.stopAnimating()
                }
            }
            let endTime = NSDate()
            print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
            
        }
        
    }
    
}

