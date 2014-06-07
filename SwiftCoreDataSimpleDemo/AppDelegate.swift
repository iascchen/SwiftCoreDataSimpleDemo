//
//  AppDelegate.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by CHENHAO on 14-6-7.
//  Copyright (c) 2014年 CHENHAO. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        self.cdh.saveContext()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // self.demoFamily()
        self.demoMember()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        self.cdh.saveContext()
    }
    
    // #pragma mark - Core Data Helper
    
    var cdh: CoreDataHelper {
    if !_cdh {
        _cdh = CoreDataHelper()
        }
        return _cdh!
    }
    var _cdh: CoreDataHelper? = nil
    
    func demoFamily(){
        var newItemNames = ["Apples", "Milk", "Bread", "Cheese", "Sausages", "Butter", "Orange Juice", "Cereal", "Coffee", "Eggs", "Tomatoes", "Fish"]
        
        // add families
        NSLog(" ======== Insert ======== ")
        
        for newItemName in newItemNames {
            var newItem: Family = NSEntityDescription.insertNewObjectForEntityForName("Family", inManagedObjectContext: self.cdh.managedObjectContext) as Family
            
            newItem.name = newItemName
            NSLog("Inserted New Family for \(newItemName) ")
        }
        
        //self.cdh.saveContext()
        
        //fetch families
        NSLog(" ======== Fetch ======== ")
        
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Family")
        
        fReq.predicate = NSPredicate(format:"name CONTAINS 'B' ")
        
        var sorter: NSSortDescriptor = NSSortDescriptor(key: "name" , ascending: false)
        fReq.sortDescriptors = [sorter]
        
        var result = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        for resultItem : AnyObject in result {
            var familyItem = resultItem as Family
            NSLog("Fetched Family for \(familyItem.name) ")
        }
        
        //delete families
        NSLog(" ======== Delete ======== ")
        
        fReq = NSFetchRequest(entityName: "Family")
        result = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        
        for resultItem : AnyObject in result {
            var familyItem = resultItem as Family
            NSLog("Deleted Family for \(familyItem.name) ")
            self.cdh.managedObjectContext.deleteObject(familyItem)
        }
        
        //self.cdh.saveContext()
        
        NSLog(" ======== Check Delete ======== ")
        
        result = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        if result.isEmpty {
            NSLog("Deleted All Families")
        }
        else{
            for resultItem : AnyObject in result {
                var familyItem = resultItem as Family
                NSLog("Fetched Error Family for \(familyItem.name) ")
            }
        }
    }
    
    func demoMember(){
        var newItemNames = ["Apples", "Milk", "Bread", "Cheese", "Sausages", "Butter", "Orange Juice", "Cereal", "Coffee", "Eggs", "Tomatoes", "Fish"]
        
        // add Member
        NSLog(" ======== Insert ======== ")
        
        for newItemName in newItemNames {
            var newItem: Member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: self.cdh.managedObjectContext) as Member
            
            newItem.name = newItemName
            NSLog("Inserted New Member for \(newItemName) ")
        }
        
        //self.cdh.saveContext()
        
        //fetch Member
        NSLog(" ======== Fetch ======== ")
        
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Member")
        
        fReq.predicate = NSPredicate(format:"name CONTAINS 'B' ")
        
        var sorter: NSSortDescriptor = NSSortDescriptor(key: "name" , ascending: false)
        fReq.sortDescriptors = [sorter]
        
        var result = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        for resultItem : AnyObject in result {
            var familyItem = resultItem as Member
            NSLog("Fetched Member for \(familyItem.name) ")
        }
        
        //delete families
        NSLog(" ======== Delete ======== ")
        
        fReq = NSFetchRequest(entityName: "Member")
        result = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        
        for resultItem : AnyObject in result {
            var familyItem = resultItem as Member
            NSLog("Deleted Member for \(familyItem.name) ")
            self.cdh.managedObjectContext.deleteObject(familyItem)
        }
        
        //self.cdh.saveContext()
        
        NSLog(" ======== Check Delete ======== ")
        
        result = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        if result.isEmpty {
            NSLog("Deleted All Member")
        }
        else{
            for resultItem : AnyObject in result {
                var familyItem = resultItem as Family
                NSLog("Fetched Error Family for \(familyItem.name) ")
            }
        }
    }

}

