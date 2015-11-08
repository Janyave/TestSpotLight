//
//  Person.m
//  Spotlight
//
//  Created by hzzhanyawei on 15/9/23.
//  Copyright © 2015年 hzzhanyawei. All rights reserved.
//

#import "Person.h"

@implementation Person


- (instancetype)initWithName:(NSString*)name andImg:(UIImage*)img{
    self = [super init];
    if (self) {
        _name = name;
        _img = img;
    }
    return self;
}
@end
