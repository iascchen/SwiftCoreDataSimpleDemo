# Step by Step Do IOS Swift CoreData Simple Demo #

This is a simple demo of access IOS core data in swift. 

## Support multi-thread Contexts

Florian Kugler gaved some advices for core data performance, [Concurrent Core Data Stacks – Performance Shootout](http://floriankugler.com/blog/2013/4/29/concurrent-core-data-stack-performance-shootout) and [Backstage with Nested Managed Object Contexts](http://floriankugler.com/blog/2013/5/11/backstage-with-nested-managed-object-contexts). 

I changed the implements to support this best practice. We should better write data in private background context, and read data from main queue context.

In your IOS application, 

## Step by Step

1. Create an Empty Application, and select in Swift language and use CoreData.
2. Create some entity in `SwiftCoreDataSimpleDemo.xcdatamodeld`, such as Family and Member. Generate the NSManagedObject files.
3. Modify generated code about persistentStoreCoordinator in AppDelegate.swift to CoreDataStore.
4. Modify generated code about NSManagedObjectContext in AppDelegate.swift to CoreDataHelper.
5. Adjust AppDelegate.swift to use CoreDataStore and CoreDataHelper. 
6. Add func demoFamily() and demoMember() to AppDelegate.swift, this func is a demo to access CoreData.
7. If you want to use CoreDataHelper in UIViewController, you'd better add a CoreDataHelper instance for each UIViewController. All CoreDataHelper instance share one CoreDataStore defined in AppDelegate.swift.

There are a detail documents in Chinese at [here](https://github.com/iascchen/SwiftCoreDataSimpleDemo/blob/master/docs/swift_coredata_sample.md). 
Or you can read the pictures and the codes. :)

## Write NSManagedObject in Swift 

I tried to write a NSManagedObject class named Member.swift according to [Implementing Core Data Managed Object Subclasses](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/WritingSwiftClassesWithObjective-CBehavior.html#//apple_ref/doc/uid/TP40014216-CH5-XID_66). 

    import CoreData
    
    @objc(Member)
    class Member: NSManagedObject {
        @NSManaged var name: String
        @NSManaged var sex: String
        @NSManaged var birthday: NSDate
    }

It is WORKED . Thanks for joshhinman's contributions.

---

Author : iascchen(at)gmail(dot)com

Date : 2014-7-9

新浪微博 : [@问天鼓](http://www.weibo.com/iascchen)

---