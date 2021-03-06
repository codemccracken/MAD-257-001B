//
//  ModelListViewControllerTableViewController.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/27/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//
import UIKit

class ModelListViewController: UITableViewController, AddModelViewControllerDelegate, EditModelViewControllerDelegate {
    
    let CellIdentifier = "Cell Identifier"
    var models = [Model]()
    var selection: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Models"
        print(models)
        
        // Register Class
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        
        // Create Add Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addModel))
        
        // Create Edit Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editModel))
    }

    // Mark: Initialization
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        // Load Items
        loadModels()
    }
    
    // MARK: - TableView Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        // Fetch Item
        let model = models[indexPath.row]
        // Configure Table View Cell
        cell.textLabel?.text = model.modelName
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete Item from Items
            models.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Save Changes
            saveModels()
        }
    }
    
    // MARK: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        print("accessoryButton pressed")
        // Fetch Item
        let model = models[indexPath.row]
        
        // Update Selection
        selection = model
        
        // perform Segue
        performSegue(withIdentifier: "EditModelViewController", sender: self)
    }

    // MARK: Save and Load Models
    private func saveModels() {
        if let filePath = pathForModels() {
            NSKeyedArchiver.archiveRootObject(models, toFile: filePath)
        }
    }
    
    private func loadModels() {
        if let filePath = pathForModels(), FileManager.default.fileExists(atPath: filePath) {
            if let archivedModels = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Model] {
                models = archivedModels
            }
        }
    }
    
    // MARK: Helper Methods
    private func pathForModels() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("models.plist")?.path
        }
        
        return nil
    }
    
    // MARK: AddModel Button Pressed
    @objc func addModel(sender: UIBarButtonItem) {
        //print("Add Model button was tapped")
        performSegue(withIdentifier: "AddModelViewController", sender: self)
    }
    
    // MARK: EditModel Button Pressed
    @objc func editModel(sender: UIBarButtonItem) {
        print("Edit Button Pressed")
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    // MARK: AddModelViewController Delegate Methods
    func controller(controller: AddModelViewController, didSaveModelWithName modelName: String,  andModelStats modelStats: String) {
        
        //Create Model
        let model = Model(modelName: modelName, modelStats: modelStats)
        
        // Add Model to Models
        models.append(model)
        
        print(models.count)
        
        // add Row to Table View
        tableView.insertRows(at: [NSIndexPath(row: (models.count - 1), section: 0) as IndexPath], with: .none)
        
        // Save Items
        saveModels()
    }
    
    // MARK: EditModelViewController Delegate Methods
    func controller(controller: EditModelViewController, didUpdateModel model: Model ) {
        // Fetch Index for model
        if let index = models.index(of: model) {
            // Update Table View
            tableView.reloadRows(at: [NSIndexPath(row: index, section: 0) as IndexPath], with: .fade)
            
            // save item
            saveModels()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddModelViewController" {
            //print("AddModel Segue")
            if let navigationController = segue.destination as? UINavigationController,
                let addModelViewController = navigationController.viewControllers.first as? AddModelViewController {
                addModelViewController.delegate = (self as AddModelViewControllerDelegate)
            }
        } else if segue.identifier == "EditModelViewController" {
            //print("EditItem Segue")
            if let editModelViewController = segue.destination as? EditModelViewController, let model = selection {
                editModelViewController.delegate = self as EditModelViewControllerDelegate
                editModelViewController.model = model
            } else {
                print("Something went wrong")
            }
        }
    }
}
