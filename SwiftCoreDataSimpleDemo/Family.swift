//
//  Family.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by CHENHAO on 14-8-28.
//  Copyright (c) 2014年 CHENHAO. All rights reserved.
//

import Foundation
import CoreData

@objc(Family)
class Family: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var name: String
    @NSManaged var members: Set<Member>

}
