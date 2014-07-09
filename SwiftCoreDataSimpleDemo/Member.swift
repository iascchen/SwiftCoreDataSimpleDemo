//
//  Member.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by CHENHAO on 14-6-7.
//  Copyright (c) 2014 CHENHAO. All rights reserved.
//

import CoreData

@objc(Member)
class Member: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var sex: String
    @NSManaged var birthday: NSDate
}
