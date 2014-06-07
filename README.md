# Step by Step Do IOS Swift CoreData Simple Demo #

This is a simple demo of access IOS core data in swift. 


## Step by Step

1. Create an Empty Application, and select in Swift language and use CoreData.

2. Create some entity in `SwiftCoreDataSimpleDemo.xcdatamodeld`, such as Family and Member. Generate the NSManagedObject files.

3. Modify generated code in AppDelegate.swift to CoreDataHelper.

4. Adjust AppDelegate.swift to use CoreDataHelper save CoreData automatically.
 
5. Add func demoFamily() to AppDelegate.swift, this func is a demo to access CoreData.

There are a detail documents in Chinese at [here](https://github.com/iascchen/SwiftCoreDataSimpleDemo/blob/master/docs/swift_coredata_sample.md). 
Or you can read the pictures and the codes. :)

## Some Failed Try

I tried to write a NSManagedObject class named Member.swift according to [Implementing Core Data Managed Object Subclasses](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/WritingSwiftClassesWithObjective-CBehavior.html#//apple_ref/doc/uid/TP40014216-CH5-XID_66)
.

    import CoreData
    
    class Member: NSManagedObject {
        @NSManaged var name: String
        @NSManaged var sex: String
        @NSManaged var birthday: NSDate
    }

But it is NOT WORK . :( The code can be build succeed, but run failed.

---

Author : iascchen(at)gmail(dot)com

Date : 2014-6-7

新浪微博 : [@问天鼓](http://www.weibo.com/iascchen)

---