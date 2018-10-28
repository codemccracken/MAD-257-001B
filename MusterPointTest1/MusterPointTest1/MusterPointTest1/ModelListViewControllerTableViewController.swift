//
//  ModelListViewControllerTableViewController.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/27/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

class ModelListViewControllerTableViewController: UITableViewController {

    var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Models"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    // Mark: Helper Methods
    private func loadModels() {
        if let filePath = pathForModels(), FileManager.default.fileExists(atPath: filePath) {
            if let archivedModels = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Model] {
                models = archivedModels
            }
        }
    }
    
    private func pathForModels() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("models.plist")?.path
        }
        
        return nil
    }
}
