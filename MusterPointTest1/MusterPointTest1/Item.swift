//
//  Item.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/17/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(item_uuid, forKey: "item_uuid")
        aCoder.encode(itemName, forKey: "itemName")
        aCoder.encode(itemStats, forKey: "itemStats")
        aCoder.encode(itemRules, forKey: "itemRules")
        aCoder.encode(itemPointCost, forKey: "itemPointCost")
        aCoder.encode(itemPowerCost, forKey: "itemPowerCost")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        if let archivedUuid = aDecoder.decodeObject(forKey: "item_uuid") as? String {
            item_uuid = archivedUuid
        }
        
        if let archivedItemName = aDecoder.decodeObject(forKey: "itemName") as? String {
            itemName = archivedItemName
        }
        
        if let archivedItemStats = aDecoder.decodeObject(forKey: "itemStats") as? String {
            itemStats = archivedItemStats
        }
        
        if let archivedItemRules = aDecoder.decodeObject(forKey: "itemRules") as? String {
            itemRules = archivedItemRules
        }
        
        if let archivedItemPowerCost = aDecoder.decodeObject(forKey: "itemPowerCost") as? Int {
            itemPowerCost = archivedItemPowerCost
        }
        
        if let archivedPointCost = aDecoder.decodeObject(forKey: "itemPointCost") as? Int {
            itemPointCost = archivedPointCost
        }
    }
    
    // Declair variables
    // Unique Identifier of type uuid
    var item_uuid: String = NSUUID().uuidString
    // Name of item
    var itemName: String = ""
    // Line for item stats
    var itemStats: String = ""
    // a Line for item Rules
    var itemRules: String = ""
    // Item Power Cost
    var itemPowerCost: Int = 0
    // Item Point Cost
    var itemPointCost: Int = 0
    
    init(itemName: String, itemPointCost: Int) {
        super.init()
        
        self.itemName = itemName
        self.itemPointCost = itemPointCost
    }

}
