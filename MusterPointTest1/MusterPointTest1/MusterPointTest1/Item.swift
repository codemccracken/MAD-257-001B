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
        
        if let archivedItemPowerCost = aDecoder.decodeObject(forKey: "itemPowerCost") as? String {
            itemPowerCost = archivedItemPowerCost
        }
        
        if let archivedItemPointCost = aDecoder.decodeObject(forKey: "itemPointCost") as? String {
            itemPointCost = archivedItemPointCost
        }
    }
    
    // Declair variables
    // Unique Identifier of type uuid
    var item_uuid: String = NSUUID().uuidString
    // Name of item
    var itemName: String = ""
    // Line for item stats
    var itemStats: String = ""
    // Line for item Rules
    var itemRules: String = ""
    // Item Power Cost
    var itemPowerCost: String = ""
    // Item Point Cost
    var itemPointCost: String = ""
    
    init(itemName: String, itemStats: String, itemRules: String, itemPowerCost: String, itemPointCost: String) {
        super.init()
        
        self.itemName = itemName
        self.itemStats = itemStats
        self.itemRules = itemRules
        self.itemPowerCost = itemPowerCost
        self.itemPointCost = itemPointCost
    }

}
