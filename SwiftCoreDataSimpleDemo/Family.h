//
//  Family.h
//  SwiftCoreDataSimpleDemo
//
//  Created by CHENHAO on 14-6-7.
//  Copyright (c) 2014年 CHENHAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Family : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;

@end
