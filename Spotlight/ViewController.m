//
//  ViewController.m
//  Spotlight
//
//  Created by hzzhanyawei on 15/9/23.
//  Copyright © 2015年 hzzhanyawei. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "DetailViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong)Person *object;
@property (nonatomic, strong)NSArray* personList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Person* jane = [[Person alloc] initWithName:@"Jane" andImg:[UIImage imageNamed:@"Jane"]];
    Person* pate = [[Person alloc] initWithName:@"Pate" andImg:[UIImage imageNamed:@"Pate"]];
    Person* ray = [[Person alloc] initWithName:@"Ray" andImg:[UIImage imageNamed:@"Ray"]];
    Person* tom = [[Person alloc] initWithName:@"Tom" andImg:[UIImage imageNamed:@"Tom"]];
    Person* becky = [[Person alloc] initWithName:@"Becky" andImg:[UIImage imageNamed:@"Becky"]];
    Person* ben = [[Person alloc] initWithName:@"Ben" andImg:[UIImage imageNamed:@"Ben"]];
    self.personList = [[NSArray alloc] initWithObjects:jane, pate, ray, tom, becky, ben, nil];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    //通过coreSpotLight添加搜索项。
    [self saveData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//用于corespotlight打开响应
- (void)showViewControllerWithidetifier:(NSString *)idetifier{
    
    NSIndexPath* indexPath =  [NSIndexPath indexPathForRow:[idetifier intValue] inSection:0];
    
    [self.myTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

//用于NSUserActivity打开响应。
- (void)showViewControllerWithActivityState:(NSUserActivity *)activity
{
    NSDictionary *userInfo = [activity userInfo];
    Person *person = [[Person alloc]initWithName:[userInfo objectForKey:@"name"] andImg:[UIImage imageWithData:[userInfo objectForKey:@"pic"]]];
    self.object = person;
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}


#pragma mark - UITableViewDataSource Func

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.personList count] ;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
   
    Person* person = [self.personList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = person.name;
    cell.imageView.image = person.img;

  
    
    return cell;
}

#pragma mark - UITableViewDelegate Func

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        DetailViewController* viewController = [segue destinationViewController];
        if (self.object == nil) {
            NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
            Person *object = self.personList[indexPath.row];
            
            [viewController setDetailItem:object];
        }
        else
        {
            [viewController setDetailItem:self.object];
            self.object = nil;
        }
        
        
    }
}

#pragma mark - CoreSpotLight Func

- (void)saveData{
    NSMutableArray* searchableItems = [[NSMutableArray alloc]init];
    [self.personList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Person* person = (Person*)obj;
        CSSearchableItemAttributeSet* attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"views"];
        attributeSet.title = person.name;
        attributeSet.contentDescription = [NSString stringWithFormat:@"My name is %@", person.name];
        

       
        attributeSet.thumbnailData = UIImagePNGRepresentation(person.img);
        CSSearchableItem* item = [[CSSearchableItem alloc]initWithUniqueIdentifier:[NSString stringWithFormat:@"%ld", idx] domainIdentifier:@"Netease.Spotlight" attributeSet:attributeSet];
        [searchableItems addObject:item];
    }];

//删除所有的Spotlight的searchableItems
//    [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
//
//    }];
    
//    根据Identifier来删除searchableItems
    NSArray* removeItemsIdentifier = [NSArray arrayWithObjects:@"Jane", @"Pate", @"Ray", @"Tom", @"Becky", @"Ben", nil];
    [[CSSearchableIndex defaultSearchableIndex] deleteSearchableItemsWithIdentifiers:removeItemsIdentifier completionHandler:^(NSError * _Nullable error) {
          if (error) {
              NSLog(@"--------%@-----------", error.description);
          }
    }];
   

//添加searchableItems
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchableItems completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"--------%@-----------", error.description);
        }
    }];
    
}

@end
