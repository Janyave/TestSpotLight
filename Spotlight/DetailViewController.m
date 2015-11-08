//
//  DetailViewController.m
//  Spotlight
//
//  Created by hzzhanyawei on 15/9/24.
//  Copyright © 2015年 hzzhanyawei. All rights reserved.
//

#import "DetailViewController.h"
#import "Person.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (nonatomic, strong)Person* person;
@property (nonatomic, strong)NSUserActivity *activity;

@end

@implementation DetailViewController

- (void)setDetailItem:(Person*)person{
    if (person != _person) {
        _person = person;
    }
}


- (void)configDate:(Person*)person{
    self.myTitle.text = person.name;
    self.img.image = person.img;
    
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.netease.zyw.spotlight"];
    activity.userInfo = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:person.name, UIImagePNGRepresentation(person.img), nil] forKeys:[NSArray arrayWithObjects:@"name",@"pic", nil]];
    activity.title = person.name;
    
    activity.keywords = [NSSet setWithObjects:person.name, nil];
    activity.eligibleForHandoff = NO;
    activity.eligibleForSearch = YES;
    //activity.eligibleForPublicIndexing = YES;
    
    CSSearchableItemAttributeSet* attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"views"];
    attributeSet.title = person.name;
    attributeSet.contentDescription = [NSString stringWithFormat:@"My name is %@", person.name];
    
    attributeSet.thumbnailData = UIImagePNGRepresentation(person.img);
    activity.contentAttributeSet =  attributeSet;
    [activity becomeCurrent];
    self.activity = activity;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle.text = self.person.name;
    self.img.image = self.person.img;
    //[self configDate:_person];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
