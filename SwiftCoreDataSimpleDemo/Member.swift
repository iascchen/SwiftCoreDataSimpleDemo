//
//  Member.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by CHENHAO on 14-6-7.
//  Copyright (c) 2014年 CHENHAO. All rights reserved.
//

//  !!! Attention, It will return exception !!!
//  This class is test code for https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/WritingSwiftClassesWithObjective-CBehavior.html#//apple_ref/doc/uid/TP40014216-CH5-XID_66
//  Please remove it as reference from your project

import CoreData

class Member: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var sex: String
    @NSManaged var birthday: NSDate
}
