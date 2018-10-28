//
//  AddModelViewController.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/27/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

protocol AddModelViewControllerDelegate {
    func controller(controller: AddModelViewController, didSaveModelWithName modelName: String,  andModelStats itemStats: String)
}

class AddModelViewController: UIViewController {

    @IBOutlet var modelNameTextField: UITextField!
    @IBOutlet var modelStatsTextField: UITextField!
    
    var delegate: AddModelViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func canel(sender: UIBarButtonItem) {
        //print("Cancel Button Pushed")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        //print("Save Button Pushed")
        let modelName = modelNameTextField.text
        let modelStats = modelStatsTextField.text
        
        // make sure values are not nil before saving
        if (modelName != nil), (modelStats != nil) {
            // Notiy Delegate
            //print("Pre-Delegate message")
            delegate?.controller(controller: self, didSaveModelWithName: modelName!, andModelStats: modelStats!)
            dismiss(animated: true, completion: nil)
        }
    }
}

