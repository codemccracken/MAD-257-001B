//
//  AppDelegate.swift
//  MusterPointTest1
//
//  Created by Eric McCracken on 10/17/18.
//  Copyright © 2018 Eric McCracken. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Seed Items
        seedItems()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Mark -
    // Mark Helper Methods
    private func seedItems() {
        let ud = UserDefaults.standard
        if !ud.bool(forKey: "UserDefaultsSeedItems") {
            
            if let filePath = Bundle.main.path(forResource: "seed", ofType: "plist"), let seedItems = NSArray(contentsOfFile: filePath) as? [[String:Any]] {
                // items
                var items = [Item]()
                
                // create list of Items
                for seedItem in seedItems {
                    let itemName = seedItem["itemName"]
                    let itemStats = seedItem["itemStats"]
                    let itemRules = seedItem["itemRules"]
                    let itemPowerCost = seedItem["itemPointCost"]
                    let itemPointCost = seedItem["itemPointCost"]
                    if (itemName != nil), (itemPointCost != nil)  {
                        // create Item
                        let item = Item(itemName: itemName as! String, itemStats: itemStats as! String, itemRules: itemRules as! String, itemPowerCost: itemPowerCost as! String, itemPointCost: itemPointCost as! String)
                        
                        // add Item
                        items.append(item)
                    }
                }
                
                if let itemsPath = pathForItems() {
                    // write to file
                    if NSKeyedArchiver.archiveRootObject(items, toFile: itemsPath) {
                        ud.set(true, forKey: "UserDefaultSeedItems")
                    }
                }
            }
        }
    }
    
    private func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("items")?.path
        }
        
        return nil
    }
}

