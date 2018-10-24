//
//  AddItemViewController.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/19/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate {
    func controller(controller: AddItemViewController, didSaveItemWithName itemName: String,  andItemPointCost itemPointCost: Int)
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
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItemViewController" {
            if let navigationController = segue.destination as? UINavigationController, let addItemViewController = navigationController.viewControllers.first as? AddItemViewController {
                addItemViewController.delegate = self as? AddItemViewControllerDelegate
            }
            
        }
    }
 
    
    // Mark -
    // Mark: Actions
    @IBAction func cancel(sender:UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        let itemName = itemNameTextField.text
        let pointCostasString = itemPointCostTextField.text
        let itemPointCost = Int(pointCostasString!)
        
        if (itemName != nil), (itemPointCost != nil) {
        // Notiy Delegate
            delegate?.controller(controller: self, didSaveItemWithName: itemName!, andItemPointCost: itemPointCost!)
        dismiss(animated: true, completion: nil)
        }
    }

}
