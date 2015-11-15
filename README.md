# Step by Step Do iOS Swift CoreData Simple Demo #

This is a simple demo of access iOS core data in swift. 

Tested in Xcode7.1.1 and Swift 2 (2015-11-15)

## Support multi-thread Contexts

Florian Kugler gaved some advices for core data performance, [Concurrent Core Data Stacks – Performance Shootout](http://floriankugler.com/blog/2013/4/29/concurrent-core-data-stack-performance-shootout) and [Backstage with Nested Managed Object Contexts](http://floriankugler.com/blog/2013/5/11/backstage-with-nested-managed-object-contexts). 

I changed the implements to support this best practice. We should better write data in private background context, and read data from main queue context.

## Step by Step

### Common Steps

1. Create an Empty Application, and select in Swift language and use CoreData.
2. Modify generated code about persistentStoreCoordinator in AppDelegate.swift to CoreDataStore.
3. Modify generated code about NSManagedObjectContext in AppDelegate.swift to CoreDataHelper.
4. Adjust AppDelegate.swift to use CoreDataStore and CoreDataHelper. 

### Data Models

1. Create some entity in `SwiftCoreDataSimpleDemo.xcdatamodeld`, such as Family and Member. 
2. Add "members" attribute of Family, set relationship with Member/family, and "to Many", select delete rule as "Cascaded".
3. Add "family" attribute of Member, set relationship with Family/members, and "to One", unselect the checkbox of "Options".
4. Generate the NSManagedObject files in Swift.
5. You have to add sentences like `@objc(ClassName)` to Member.swift and Family.swift manually.  (Thanks for joshhinman's contributions.)

such as: 

    import CoreData
    
    @objc(Member)
    class Member: NSManagedObject {
        @NSManaged var name: String
        @NSManaged var sex: String
        @NSManaged var birthday: NSDate
    }

### About Demo Code

1. Add func demoFamily() to AppDelegate.swift, this is a demo of basic CoreData CRUD.
2. Add func demoMember() to AppDelegate.swift, this is a demo of relationship, and delete cascaded.
3. If you want to use CoreDataHelper in UIViewController, you'd better add a CoreDataHelper instance for each UIViewController. All CoreDataHelper instance share one CoreDataStore defined in AppDelegate.swift.
4. Generally, We should better write data in private background context, and read data from main queue context. 
5. BUT please make sure the context of saved the object is same with which fetched it.

### Other

There are a detail documents in Chinese at [here](https://github.com/iascchen/SwiftCoreDataSimpleDemo/blob/master/docs/swift_coredata_sample.md). 
Or you can read the pictures and the codes. :)

---

Author : iascchen(at)gmail(dot)com

Date : 2014-8-28

新浪微博 : [@问天鼓](http://www.weibo.com/iascchen)

---
