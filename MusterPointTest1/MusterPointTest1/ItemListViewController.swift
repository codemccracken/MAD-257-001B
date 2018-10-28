//
//  ListViewContrroller.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/17/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//
import UIKit

class ItemListViewController: UITableViewController, AddItemViewControllerDelegate, EditItemViewControllerDelegate {
    
    let CellIdentifier = "Cell Identifier"
    var items = [Item]()
    var selection: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Items"
        print(items)
        
        // Register Class
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        
        // Create Add Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        // Create Edit Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItems))
    }
    
    // Mark: Initialization
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        // Load Items
        loadItems()
    }
    
    // MARK: - TableView Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        // Fetch Item
        let item = items[indexPath.row]
        // Configure Table View Cell
        cell.textLabel?.text = item.itemName
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete Item from Items
            items.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Save Changes
            saveItems()
        }
     }
    
    // MARK: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
     
        //print("accessoryButton pressed")
        // Fetch Item
        let item = items[indexPath.row]

        // Update Selection
        selection = item

        // perform Segue
        performSegue(withIdentifier: "EditItemViewController", sender: self)
    }
    
    // MARK: Save and Load Items
    private func saveItems() {
        if let filePath = pathForItems() {
            NSKeyedArchiver.archiveRootObject(items, toFile: filePath)
        }
    }
    
    private func loadItems() {
        if let filePath = pathForItems(), FileManager.default.fileExists(atPath: filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item] {
                items = archivedItems
                
            }
        }
    }
    
    // MARK: Helper Methods
    private func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("items.plist")?.path
        }
        
        return nil
    }
    
    // MARK: AddItem button pushed
    @objc func addItem(sender: UIBarButtonItem) {
        //print("New Item button was pressed")
        performSegue(withIdentifier: "AddItemViewController", sender: self)
    }
    
    // MARK: EditItems button pushed
    @objc func editItems(sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    // MARK: AddItemViewController Delegate Methods
    func controller(controller: AddItemViewController, didSaveItemWithName itemName: String,  andItemStats itemStats: String, andItemRules itemRules: String, andItemPowerCost itemPowerCost: String, andItemPointCost itemPointCost: String) {
        
        //Create Item
        let item = Item(itemName: itemName, itemStats: itemStats, itemRules: itemRules, itemPowerCost: itemPowerCost, itemPointCost: itemPointCost)
        
        // add Item to Items
        items.append(item)
        
        //print(items.count)

        // add Row to Table View
        tableView.insertRows(at: [NSIndexPath(row: (items.count - 1), section: 0) as IndexPath], with: .none)

        // Save Items
        saveItems()
    }
    
    // MARK: EditItemViewController Delegate Methods
    func controller(controller: EditItemViewController, didUpdateItem item: Item ) {
        // Fetch Index for Item
        if let index = items.index(of: item) {
            // Update Table View
            tableView.reloadRows(at: [NSIndexPath(row: index, section: 0) as IndexPath], with: .fade)
            
            // save item
            saveItems()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemViewController" {
            print("AddItem Segue")
            if let navigationController = segue.destination as? UINavigationController,
                let addItemViewController = navigationController.viewControllers.first as? AddItemViewController {
                addItemViewController.delegate = (self as AddItemViewControllerDelegate)
            }
        } else if segue.identifier == "EditItemViewController" {
            //print("EditItem Segue")
            if let editItemViewController = segue.destination as? EditItemViewController, let item = selection {
                    editItemViewController.delegate = self as EditItemViewControllerDelegate
                    editItemViewController.item = item
            } else {
                print("Something went wrong")
            }
        }
    }
    
    
}
