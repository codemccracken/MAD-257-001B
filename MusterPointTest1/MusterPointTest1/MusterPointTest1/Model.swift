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
        aCoder.encode(modelRules, forKey: "modelRules")
        aCoder.encode(modelPointCost, forKey: "modelPointCost")
        aCoder.encode(modelPowerCost, forKey: "modelPowerCost")
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
        
        if let archivedItemRules = aDecoder.decodeObject(forKey: "modelRules") as? String {
            modelRules = archivedItemRules
        }
        
        if let archivedItemPowerCost = aDecoder.decodeObject(forKey: "modelPowerCost") as? String {
            modelPowerCost = archivedItemPowerCost
        }
        
        if let archivedItemPointCost = aDecoder.decodeObject(forKey: "modelPointCost") as? String {
            modelPointCost = archivedItemPointCost
        }
    }
    
    // Declair variables
    // Unique Identifier of type uuid
    var model_uuid: String = NSUUID().uuidString
    // Name of item
    var modelName: String = ""
    // Line for item stats
    var modelStats: String = ""
    // Line for item Rules
    var modelRules: String = ""
    // Item Power Cost
    var modelPowerCost: String = ""
    // Item Point Cost
    var modelPointCost: String = ""
    
    init(itemName: String, itemStats: String, itemRules: String, itemPowerCost: String, itemPointCost: String) {
        super.init()
        
        self.modelName = itemName
        self.modelStats = itemStats
        self.modelRules = itemRules
        self.modelPowerCost = itemPowerCost
        self.modelPointCost = itemPointCost
    }
    
}
