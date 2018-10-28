//
//  AddItemViewController.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/19/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//
import UIKit

protocol AddItemViewControllerDelegate {
    func controller(controller: AddItemViewController, didSaveItemWithName itemName: String,  andItemStats itemStats: String, andItemRules itemRules: String, andItemPowerCost itemPowerCost: String, andItemPointCost itemPointCost: String)
}
class AddItemViewController: UIViewController {
    
    @IBOutlet var itemNameTextField: UITextField!
    @IBOutlet var itemStatsTextField: UITextField!
    @IBOutlet var itemRulesTextField: UITextField!
    @IBOutlet var itemPowerCostTextField: UITextField!
    @IBOutlet var itemPointCostTextField: UITextField!
    
    var delegate: AddItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Navigation
    
    
    
    // Mark -
    // Mark: Actions
    @IBAction func cancel(sender:UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        let itemName = itemNameTextField.text
        let itemStats = itemStatsTextField.text
        let itemRules = itemRulesTextField.text
        let itemPowerCost = itemPowerCostTextField.text
        let itemPointCost = itemPointCostTextField.text
        
        
        
        if (itemName != nil), (itemPointCost != nil) {
            // Notiy Delegate
            //print("Pre-Delegate message")
            delegate?.controller(controller: self, didSaveItemWithName: itemName!, andItemStats: itemStats ?? "no stats", andItemRules: itemRules ?? "no rules", andItemPowerCost: itemPowerCost! , andItemPointCost: itemPointCost!)
            dismiss(animated: true, completion: nil)
        }
    }
    
}

