//
//  EditItemViewController.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/25/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

protocol EditItemViewControllerDelegate {
    func controller(controller: EditItemViewController, didUpdateItem item: Item)
}

class EditItemViewController: UIViewController {

    @IBOutlet var itemNameTextField: UITextField!
    @IBOutlet var itemStatsTextField: UITextField!
    @IBOutlet var itemRulesTextField: UITextField!
    @IBOutlet var itemPowerCostTextField: UITextField!
    @IBOutlet var itemPointCostTextField: UITextField!
    
    var item: Item!
    
    var delegate: EditItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Create Save Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        // Populate Text Fields
        itemNameTextField.text = item.itemName
        itemStatsTextField.text = item.itemStats
        itemRulesTextField.text = item.itemRules
        itemPowerCostTextField.text = item.itemPowerCost
        itemPointCostTextField.text = "\(item.itemPointCost)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions
    @objc func save(sender: UIBarButtonItem) {
        if let name = itemNameTextField.text, let stats = itemStatsTextField.text, let rules = itemRulesTextField.text, let itemPowerCost = itemPowerCostTextField.text,  let itemPointCost = itemPointCostTextField.text {
            
            // Update Item
            item.itemName = name
            item.itemStats = stats
            item.itemRules = rules
            item.itemPowerCost = itemPowerCost
            item.itemPointCost = itemPointCost
            
            print(item.itemPowerCost)
            print(item.itemPointCost)
            
            //Notify Delegate
            delegate?.controller(controller: self, didUpdateItem: item)
            
            // Pop View Controller
            navigationController?.popViewController(animated: true)
        }
    }

}
