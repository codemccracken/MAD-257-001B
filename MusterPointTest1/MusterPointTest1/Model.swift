//
//  Model.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/27/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

class Model: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(model_uuid, forKey: "model_uuid")
        aCoder.encode(modelName, forKey: "modelName")
        aCoder.encode(modelStats, forKey: "modelStats")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        if let archivedUuid = aDecoder.decodeObject(forKey: "model_uuid") as? String {
            model_uuid = archivedUuid
        }
        
        if let archivedItemName = aDecoder.decodeObject(forKey: "modelName") as? String {
            modelName = archivedItemName
        }
        
        if let archivedItemStats = aDecoder.decodeObject(forKey: "modelStats") as? String {
            modelStats = archivedItemStats
        }
        
        
    }
    
    
    // Declair variables
    // Unique Identifier of type uuid
    var model_uuid: String = NSUUID().uuidString
    // Name of item
    var modelName: String = ""
    // Line for item stats
    var modelStats: String = ""
    
    
    init(modelName: String, modelStats: String) {
        super.init()
        
        self.modelName = modelName
        self.modelStats = modelStats
        
    }
    
}
