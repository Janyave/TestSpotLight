//
//  DetailViewController.h
//  Spotlight
//
//  Created by hzzhanyawei on 15/9/24.
//  Copyright © 2015年 hzzhanyawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import <CoreSpotlight/CoreSpotlight.h>

@interface DetailViewController : UIViewController
- (void)setDetailItem:(Person*)person;
@end
