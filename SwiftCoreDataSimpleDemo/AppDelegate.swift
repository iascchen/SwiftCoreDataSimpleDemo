//
//  AppDelegate.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by CHENHAO on 14-6-7.
//  Copyright (c) 2014 CHENHAO. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
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
        
        self.demoFamily()
        self.demoMember()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        self.cdh.saveContext()
    }
    
    // #pragma mark - Core Data Helper
    
    lazy var cdstore: CoreDataStore = {
        let cdstore = CoreDataStore()
        return cdstore
        }()
    
    lazy var cdh: CoreDataHelper = {
        let cdh = CoreDataHelper()
        return cdh
        }()
    
    // #pragma mark - Demo
    
    func demoFamily(){
        NSLog(" ======================== ")
        NSLog(" ======== Family ======== ")
        
        var newItemNames = ["Apples", "Milk", "Bread", "Cheese", "Sausages", "Butter", "Orange Juice", "Cereal", "Coffee", "Eggs", "Tomatoes", "Fish"]
        
        // add families
        NSLog(" ======== Insert ======== ")
        
        for newItemName in newItemNames {
            var newItem: Family = NSEntityDescription.insertNewObjectForEntityForName("Family", inManagedObjectContext: self.cdh.backgroundContext!) as! Family
            
            newItem.name = newItemName
            NSLog("Inserted New Family for \(newItemName) ")
        }
        
        self.cdh.saveContext(self.cdh.backgroundContext!)
        
        //fetch families
        NSLog(" ======== Fetch ======== ")
        
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Family")
        
        fReq.predicate = NSPredicate(format:"name CONTAINS 'B' ")
        
        var sorter: NSSortDescriptor = NSSortDescriptor(key: "name" , ascending: false)
        fReq.sortDescriptors = [sorter]
        
        fReq.returnsObjectsAsFaults = false
        
        var result = self.cdh.managedObjectContext!.executeFetchRequest(fReq, error:&error)
        for resultItem in result! {
            var familyItem = resultItem as! Family
            NSLog("Fetched Family for \(familyItem.name) ")
        }
        
        //delete families
        NSLog(" ======== Delete ======== ")
        
        fReq = NSFetchRequest(entityName: "Family")
        result = self.cdh.backgroundContext!.executeFetchRequest(fReq, error:&error)
        
        for resultItem in result! {
            var familyItem = resultItem as! Family
            NSLog("Deleted Family for \(familyItem.name) ")
            self.cdh.backgroundContext!.deleteObject(familyItem)
        }
        
        self.cdh.saveContext(self.cdh.backgroundContext!)
        
        NSLog(" ======== Check Delete ======== ")
        
        result = self.cdh.managedObjectContext!.executeFetchRequest(fReq, error:&error)
        if result!.isEmpty {
            NSLog("Deleted All Families")
        }
        else{
            for resultItem in result! {
                var familyItem = resultItem as! Family
                NSLog("Fetched Error Family for \(familyItem.name) ")
            }
        }
    }
    
    func demoMember(){
        NSLog(" ======================== ")
        NSLog(" ======== Member ======== ")
        
        var family: Family = NSEntityDescription.insertNewObjectForEntityForName("Family", inManagedObjectContext: self.cdh.backgroundContext!) as! Family
        family.name = "Fruits"
        
        // add Members
        
        var newItemNames = ["Apples", "Milk", "Bread", "Cheese", "Sausages", "Butter", "Orange Juice", "Cereal", "Coffee", "Eggs", "Tomatoes", "Fish"]
        
        NSLog(" ======== Insert Member with family attribute ======== ")
        
        for newItemName in newItemNames {
            var newItem: Member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: self.cdh.backgroundContext!) as! Member
            
            newItem.name = newItemName
            newItem.family = family
            NSLog("Inserted New Member for \(family.name) , \(newItem.name) ")
        }
        
        self.cdh.saveContext(self.cdh.backgroundContext!)
        
        //fetch Member
        NSLog(" ======== Fetch Members ======== ")
        
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Member")
        
        fReq.predicate = NSPredicate(format:"name CONTAINS 'B' ")
        
        var sorter: NSSortDescriptor = NSSortDescriptor(key: "name" , ascending: false)
        fReq.sortDescriptors = [sorter]
        
        var result = self.cdh.managedObjectContext!.executeFetchRequest(fReq, error:&error)
        for resultItem in result! {
            var memberItem = resultItem as! Member
            NSLog("Fetched Member for \(memberItem.family.name) , \(memberItem.name)  ")
        }
        
        NSLog(" ======== Fetch Family and all Members can be found======== ")
        error = nil
        fReq = NSFetchRequest(entityName: "Family")
        
        fReq.predicate = NSPredicate(format:"name == 'Fruits' ")
        
        result = self.cdh.managedObjectContext!.executeFetchRequest(fReq, error:&error)
        for resultItem in result! {
            var familyItem = resultItem as! Family
            NSLog("Fetched Family for \(familyItem.name) ")
            
            for memberItem in familyItem.members {
                NSLog("Fetched Family Member for \(memberItem.name) ")
            }
            
        }
        
        //delete family
        NSLog(" ======== Delete Family with cascade delete Members ======== ")
        
        var familyItem = result![0] as! Family
        self.cdh.managedObjectContext!.deleteObject(familyItem)
        
        self.cdh.saveContext(self.cdh.managedObjectContext!)
        
        NSLog(" ======== Confirm Members Deleted======== ")
        
        fReq = NSFetchRequest(entityName: "Member")
        
        result = self.cdh.backgroundContext!.executeFetchRequest(fReq, error:&error)
        if result!.isEmpty {
            NSLog("Delete Successed")
        }
        else{
            for resultItem in result! {
                var memberItem = resultItem as! Member
                NSLog("Delete Failed, \(memberItem.name)")
            }
        }

        

    }
    
}

