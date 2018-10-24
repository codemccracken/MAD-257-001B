//
//  ListViewContrroller.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/17/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

class ListViewContrroller: UITableViewController {
    
    let CellIdentifier = "Cell Identifier"
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Items"
        print(items)

        // Register Class
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        
        // Create Add Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    // Mark: -
    // Mark: Initialization
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        // Load Items
        loadItems()
    }
    // MARK: - Table view data source

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        // Fetch Item
        let item = items[indexPath.row]
        // Configure Table View Cell
        cell.textLabel?.text = item.itemName

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Mark Helper Methods
    private func loadItems() {
        if let filePath = pathForItems(), FileManager.default.fileExists(atPath: filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item] {
                items = archivedItems
            }
        }
    }
    
    private func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("items.plist")?.path
        }
        
        return nil
    }
    
    private func saveItems() {
        print("Items Saved")
        if let filePath = pathForItems() {
        NSKeyedArchiver.archiveRootObject(items, toFile: filePath)
        }
    }
    
    // Mark: Add Item button pushed
    @objc func addItem(sender: UIBarButtonItem) {
        //print("New Item button was pressed")
        performSegue(withIdentifier: "AddItemViewController", sender: self)
    }
    
    // Mark: -
    // Mark: Add Item View Controller Delegate Methods
    func controller(controller: AddItemViewController, didSaveItemWithName itemName: String, andItemPointCost itemPointCost: Int) {
        //Create Item
        let item = Item(itemName: itemName, itemPointCost: itemPointCost)
        
        // add Item to Items
        items.append(item)
        
        // add Row to Table View
        tableView.insertRows(at: [NSIndexPath(row: (items.count - 1), section: 0) as IndexPath], with: .none)
        
        // Save Items
        saveItems()
    }
}
