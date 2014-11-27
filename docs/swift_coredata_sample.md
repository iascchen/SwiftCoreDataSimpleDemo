# Step by Step Do iOS Swift CoreData Simple Demo #

## 简介

这篇文章记录了在 iOS 中使用 Swift 操作 CoreData 的一些基础性内容，由于缺乏文档，基本上都是自行实验的结果，错漏不可避免，还请谅解。

部分内容借鉴了 Tim Roadley 的《Learning.Core.Data.for.iOS(2013.11)》, 这本书主要介绍 ObjC的 CoreData 。

![](images/img00.png)

---
## 创建一个新 XCode 项目

* 创建一个新的 XCode 项目。

![](images/img01.png)

* 创建一个 Empty Application

![](images/img02.png)

* 填写项目相关信息，如设置项目名称为： SwiftCoreDataSimpleDemo， 注意选择语言为 Swift， 并且勾选上 Use Core Data。

![](images/img03.png)

* 选择存储项目的目录

![](images/img04.png)

* 创建的新项目如下图所示

![](images/img05.png)

---
## 修改 Core Data Model

* 选择 SwiftCoreDataSimpleDemo.xcdatamodeld 文件，目前还是空的。

![](images/img07.png)

* 创建两个 Entity， 分别命名为 Family 和 Member。

![](images/img08.png)
![](images/img09.png)

* 在生成模型文件之前，我们可以创建一个名为 models 的 Group ， 用于存放生成的模型文件。

![](images/img10.png)

* 选中 SwiftCoreDataSimpleDemo.xcdatamodeld 文件的某个 Entity 之后，能够在 Editor 菜单中找到 Create NSManagedObject Subclass，选择此项目，开始创建模型文件。

![](images/img11.png)

* 跟随向导，完成模型创建，可以选中所有的 Entity ，并将存储位置指定为我们刚创建的 models Group 中。

![](images/img12.png)
![](images/img13.png)
![](images/img14.png)

* 在结束之前，XCode 会弹出对话框，问是否创建用于 Swift 和 ObjC 协同工作的库文件 SwiftCoreDataSimpleDemo-Bridging-Header.h， 此时当然是选择 Yes。

![](images/img15.png)

生成完成之后，就能够在 Project 中看见新的模型文件了。此时，SwiftCoreDataSimpleDemo-Bridging-Header.h 还是空的，我们需要在其中增加需要被 Swift 访问的头文件。结果如下图所示：

	#import "Family.h"
	#import "Member.h"
	
![](images/img16.png)

---
## 修改 AppDelegate

和新建 ObjC App 类似，新建项目将操作 CoreData 的代码添加在 AppDelegate.swift 文件中。为了能够使代码更简洁和清晰，我们将这部分代码提炼出来，移动到 CoreDataHelper.swift 和 CoreDataStore.swift 中去。

* 打开原始的 AppDelegate.swift，在程序的后半部分，能够看见操作 CoreData 相关的代码.如下图所示。

![](images/img06.png)

* 创建新 CoreDataHelper.swift 文件。修改文件名为 CoreDataHelper。

![](images/img17.png)
![](images/img18.png)
![](images/img19.png)

* 在 AppDelegate.swift 中将 `func saveContext ()` 及其后面的代码选中，转移到 CoreDataStore.swift 和 CoreDataHelper.swift 文件中。并对其做些小调整，将所用到的项目名称提成常量，放在 CoreDataHelper 前部，这样，以后如果需要在历史项目中使用 CoreDataHelper，就十分方便了。

![](images/img20.png)

完成后的 CoreDataStore.swift 代码如下：

    //
    //  CoreDataStore.swift
    //  SwiftCoreDataSimpleDemo
    //
    //  Created by CHENHAO on 14-7-9.
    //  Copyright (c) 2014 CHENHAO. All rights reserved.
    //
    
    import Foundation
    
    class CoreDataStore: NSObject{
        
        let storeName = "SwiftCoreDataSimpleDemo"
        let storeFilename = "SwiftCoreDataSimpleDemo.sqlite"
        
        // Returns the managed object model for the application.
        // If the model doesn't already exist, it is created from the application's model.
        var managedObjectModel: NSManagedObjectModel {
        if !_managedObjectModel {
            let modelURL = NSBundle.mainBundle().URLForResource(storeName, withExtension: "momd")
            _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)
            }
            return _managedObjectModel!
        }
        var _managedObjectModel: NSManagedObjectModel? = nil
        
        // Returns the persistent store coordinator for the application.
        // If the coordinator doesn't already exist, it is created and the application's store added to it.
        var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        if !_persistentStoreCoordinator {
            let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent(storeFilename)
            var error: NSError? = nil
            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            if _persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
                /*
                Replace this implementation with code to handle the error appropriately.
                
                abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                Typical reasons for an error here include:
                * The persistent store is not accessible;
                * The schema for the persistent store is incompatible with current managed object model.
                Check the error message to determine what the actual problem was.
                
                
                If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
                
                If you encounter schema incompatibility errors during development, you can reduce their frequency by:
                * Simply deleting the existing store:
                NSFileManager.defaultManager().removeItemAtURL(storeURL, error: nil)
                
                * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
                [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true}
                
                Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
                
                */
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
            }
            return _persistentStoreCoordinator!
        }
        var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil
        
        // #pragma mark - Application's Documents directory
        
        // Returns the URL to the application's Documents directory.
        var applicationDocumentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            return urls[urls.endIndex-1] as NSURL
        }
    }

修改 CoreDataHelper.swift ，所有的 NSManagedObjectContext 共享 APPDelegate.swift 中定义的 CoreDataStore 。

Florian Kugler 对如何高效使用 CoreData 给出了很好的建议, [Concurrent Core Data Stacks – Performance Shootout](http://floriankugler.com/blog/2013/4/29/concurrent-core-data-stack-performance-shootout) 和 [Backstage with Nested Managed Object Contexts](http://floriankugler.com/blog/2013/5/11/backstage-with-nested-managed-object-contexts). 
下面的代码是性能最好的 Stack 3 的实现。大家可以根据自己的需要灵活的使用 MainQueue 或 PrivateQueue 完成 Context 的操作。

如果需要在自己定义的 UIViewController 中使用 CoreDataHelper，建议的做法是为每个 UIViewController 创建自己的 CoreDataHelper 实例。
不建议所有 UIViewController 共用同一个 NSManagedObjectContext。

CoreDataHelper.swift 完整代码如下：

    //
    //  CoreDataHelper.swift
    //  SwiftCoreDataSimpleDemo
    //
    //  Created by CHENHAO on 14-6-7.
    //  Copyright (c) 2014 CHENHAO. All rights reserved.
    //
    
    import CoreData
    import UIKit
    
    class CoreDataHelper: NSObject{
        
        let store: CoreDataStore!
        
        init(){
            super.init()
    
            // all CoreDataHelper share one CoreDataStore defined in AppDelegate
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            self.store = appDelegate.cdstore
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "contextDidSaveContext:", name: NSManagedObjectContextDidSaveNotification, object: nil)
        }
        
        deinit{
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
        
        // #pragma mark - Core Data stack
        
        // Returns the managed object context for the application.
        // Normally, you can use it to do anything.
        // But for bulk data update, acording to Florian Kugler's blog about core data performance, [Concurrent Core Data Stacks – Performance Shootout](http://floriankugler.com/blog/2013/4/29/concurrent-core-data-stack-performance-shootout) and [Backstage with Nested Managed Object Contexts](http://floriankugler.com/blog/2013/5/11/backstage-with-nested-managed-object-contexts). We should better write data in background context. and read data from main queue context.
        // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
        
        // main thread context
        var managedObjectContext: NSManagedObjectContext {
        if !_managedObjectContext {
            let coordinator = self.store.persistentStoreCoordinator
            if coordinator != nil {
                _managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
                _managedObjectContext!.persistentStoreCoordinator = coordinator
            }
            }
            return _managedObjectContext!
        }
        var _managedObjectContext: NSManagedObjectContext? = nil
        
        // Returns the background object context for the application. 
        // You can use it to process bulk data update in background.
        // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
        
        var backgroundContext: NSManagedObjectContext {
        if !_backgroundContext {
            let coordinator = self.store.persistentStoreCoordinator
            if coordinator != nil {
                _backgroundContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
                _backgroundContext!.persistentStoreCoordinator = coordinator
            }
            }
            return _backgroundContext!
        }
        var _backgroundContext: NSManagedObjectContext? = nil
        
        // save NSManagedObjectContext
        func saveContext (context: NSManagedObjectContext) {
            var error: NSError? = nil
            if context != nil {
                if context.hasChanges && !context.save(&error) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error)")
                    abort()
                }
            }
        }
        
        func saveContext () {
            self.saveContext( self.backgroundContext )
        }
        
        // call back function by saveContext, support multi-thread 
        func contextDidSaveContext(notification: NSNotification) {
            let sender = notification.object as NSManagedObjectContext
            if sender === self.managedObjectContext {
                NSLog("======= Saved main Context in this thread")
                self.backgroundContext.performBlock {
                    self.backgroundContext.mergeChangesFromContextDidSaveNotification(notification)
                }
            } else if sender === self.backgroundContext {
                NSLog("======= Saved background Context in this thread")
                self.managedObjectContext.performBlock {
                    self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
                }
            } else {
                NSLog("======= Saved Context in other thread")
                self.backgroundContext.performBlock {
                    self.backgroundContext.mergeChangesFromContextDidSaveNotification(notification)
                }
                self.managedObjectContext.performBlock {
                    self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
                }
            }
        }
    }
	
* 修改 AppDelegate.swift。并创建 CoreDataHelper 和 CoreDataStore 的实例，用于操作 CoreData。

将 `applicationWillTerminate(application: UIApplication)` 方法之后的内容全部替换为以下代码。

    // #pragma mark - Core Data Helper
    
    var cdstore: CoreDataStore {
    if !_cdstore {
        _cdstore = CoreDataStore()
        }
        return _cdstore!
    }
    var _cdstore: CoreDataStore? = nil
    
    var cdh: CoreDataHelper {
        if !_cdh {
            _cdh = CoreDataHelper()
        }
        return _cdh!
    }
    var _cdh: CoreDataHelper? = nil

* 修改 AppDelegate.swift，以自动保存 CoreData。

代码如下：

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        self.cdh.saveContext()
    }
    ...
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        self.cdh.saveContext()
    }

---
## 操作模型对象
        
接下来我们将在 AppDelegate.swift 中创建一个访问 CoreData 的 demoFamily 方法，用于操作 CoreData。
这段代码放在 `func applicationDidBecomeActive(application: UIApplication)` 中执行，操作结果从 Log 文件中查看。

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        self.demoFamily()
    }

demoFamily() 的具体实现如下，代码说明请参考注释：

    func demoFamily(){
        var newItemNames = ["Apples", "Milk", "Bread", "Cheese", "Sausages", "Butter", "Orange Juice", "Cereal", "Coffee", "Eggs", "Tomatoes", "Fish"]
        
        // add families
        NSLog(" ======== Insert ======== ")
        
        for newItemName in newItemNames {
            var newItem: Family = NSEntityDescription.insertNewObjectForEntityForName("Family", inManagedObjectContext: self.cdh.backgroundContext) as Family
            
            newItem.name = newItemName
            NSLog("Inserted New Family for \(newItemName) ")
        }
        
        self.cdh.saveContext(self.cdh.backgroundContext)
        
        //fetch families
        NSLog(" ======== Fetch ======== ")
        
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Family")
        
        // set filter 
        fReq.predicate = NSPredicate(format:"name CONTAINS 'B' ")
        
        // set result sorter
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
        result = self.cdh.backgroundContext.executeFetchRequest(fReq, error:&error)
        
        for resultItem : AnyObject in result {
            var familyItem = resultItem as Family
            NSLog("Deleted Family for \(familyItem.name) ")
            self.cdh.backgroundContext.deleteObject(familyItem)
        }
        
        self.cdh.saveContext(self.cdh.backgroundContext)
        
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

Log输出如下：

    2014-06-07 14:01:53.717 SwiftCoreDataSimpleDemo[18348:1419062] Application windows are expected to have a root view controller at the end of application launch
    2014-06-07 14:01:54.100 SwiftCoreDataSimpleDemo[18348:1419062]  ======== Insert ======== 
    2014-06-07 14:01:54.115 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Apples 
    2014-06-07 14:01:54.115 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Milk 
    2014-06-07 14:01:54.115 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Bread 
    2014-06-07 14:01:54.116 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Cheese 
    2014-06-07 14:01:54.116 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Sausages 
    2014-06-07 14:01:54.116 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Butter 
    2014-06-07 14:01:54.117 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Orange Juice 
    2014-06-07 14:01:54.117 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Cereal 
    2014-06-07 14:01:54.117 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Coffee 
    2014-06-07 14:01:54.118 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Eggs 
    2014-06-07 14:01:54.118 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Tomatoes 
    2014-06-07 14:01:54.118 SwiftCoreDataSimpleDemo[18348:1419062] Inserted New Family for Fish 
    2014-06-07 14:01:54.118 SwiftCoreDataSimpleDemo[18348:1419062]  ======== Fetch ======== 
    2014-06-07 14:01:54.121 SwiftCoreDataSimpleDemo[18348:1419062] Fetched Family for Butter 
    2014-06-07 14:01:54.122 SwiftCoreDataSimpleDemo[18348:1419062] Fetched Family for Bread 
    2014-06-07 14:01:54.122 SwiftCoreDataSimpleDemo[18348:1419062]  ======== Delete ======== 
    2014-06-07 14:01:54.123 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Tomatoes 
    2014-06-07 14:01:54.123 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Cereal 
    2014-06-07 14:01:54.123 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Orange Juice 
    2014-06-07 14:01:54.123 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Eggs 
    2014-06-07 14:01:54.124 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Milk 
    2014-06-07 14:01:54.124 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Butter 
    2014-06-07 14:01:54.124 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Sausages 
    2014-06-07 14:01:54.125 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Cheese 
    2014-06-07 14:01:54.125 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Apples 
    2014-06-07 14:01:54.125 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Bread 
    2014-06-07 14:01:54.125 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Fish 
    2014-06-07 14:01:54.126 SwiftCoreDataSimpleDemo[18348:1419062] Deleted Family for Coffee 
    2014-06-07 14:01:54.126 SwiftCoreDataSimpleDemo[18348:1419062]  ======== Check Delete ======== 
    2014-06-07 14:01:54.127 SwiftCoreDataSimpleDemo[18348:1419062] Deleted All Families
    Program ended with exit code: 9

---
## 用 Swift 编写 NSManagementObject

参考 Swift 文档，尝试创建 Member.swift，编译通过，运行成功。

Swift 文档的相关说明如下，[Implementing Core Data Managed Object Subclasses](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/WritingSwiftClassesWithObjective-CBehavior.html#//apple_ref/doc/uid/TP40014216-CH5-XID_66)

    Implementing Core Data Managed Object Subclasses
    
    Core Data provides the underlying storage and implementation of properties in subclasses
     of the NSManagedObject class. Add the @NSManaged attribute before each property definition
      in your managed object subclass that corresponds to an attribute or relationship in your 
      Core Data model. Like the @dynamic attribute in Objective-C, the @NSManaged attribute 
      informs the Swift compiler that the storage and implementation of a property will be 
      provided at runtime. However, unlike @dynamic, the @NSManaged attribute is available only 
      for Core Data support. 
    
根据文档编写 Member.swift 如下：

    import CoreData
    
    @objc(Member)
    class Member: NSManagedObject {
        @NSManaged var name: String
        @NSManaged var sex: String
        @NSManaged var birthday: NSDate
    }

将 SwiftCoreDataSimpleDemo-Bridging-Header.h 中的 Member.h 行注释掉， 并从项目中删除 Member.h、Member.m 的引用：

	#import "Family.h"
	// #import "Member.h"

运行之后，编译成功.

---
## 代码地址 ##

[https://github.com/iascchen/SwiftCoreDataSimpleDemo/](https://github.com/iascchen/SwiftCoreDataSimpleDemo/)

---

打完收工

---

Author : iascchen(at)gmail(dot)com

Date : 2014-6-7

Update : 2014-7-9

新浪微博 : [@问天鼓](http://www.weibo.com/iascchen)

---
