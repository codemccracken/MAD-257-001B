//
//  EditModelViewController.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/28/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

protocol EditModelViewControllerDelegate {
    func controller(controller: EditModelViewController, didUpdateModel model: Model)
}

class EditModelViewController: UIViewController {
    
    @IBOutlet var modelNameTextField: UITextField!
    @IBOutlet var modelStatsTextField: UITextField!
    
    var model: Model!
    var delegate: EditModelViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Create Save Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        // Populate Text Fields
        modelNameTextField.text = model.modelName
        modelStatsTextField.text = model.modelStats
        
    }
    
    // MARK: Actions
    @objc func save(sender: UIBarButtonItem) {
        if let name = modelNameTextField.text, let stats = modelStatsTextField.text {
            
            // Update Model
            model.modelName = name
            model.modelStats = stats
            
            //Notify Delegate
            delegate?.controller(controller: self, didUpdateModel: model)
            
            // Pop View Controller
            navigationController?.popViewController(animated: true)
        }
    }
    
}
