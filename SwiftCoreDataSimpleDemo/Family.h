//
//  Family.h
//  SwiftCoreDataSimpleDemo
//
//  Created by CHENHAO on 14-7-9.
//  Copyright (c) 2014年 CHENHAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Family : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * name;

@end
