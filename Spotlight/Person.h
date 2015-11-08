//
//  Person.h
//  Spotlight
//
//  Created by hzzhanyawei on 15/9/23.
//  Copyright © 2015年 hzzhanyawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject

@property (nonatomic, retain)NSString* name;
@property (nonatomic, retain)UIImage* img;


- (instancetype)initWithName:(NSString*)name andImg:(UIImage*)img;
@end
