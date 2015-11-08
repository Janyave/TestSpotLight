#Spotlight demo

##1.实现tableView和detailView

![](/Users/hzzhanyawei/Desktop/1.jpg)  ![](/Users/hzzhanyawei/Desktop/2.jpg)
##2.导入框架包
先将framework导入

工程->Build Phases->Link Binary With Libraries->搜索CoreSpotlight
##3.然后将需要索引的数据保存到CoreSpotlight
引入头文件`#import <CoreSpotlight/CoreSpotlight.h>`

然后：

	- (void)saveData{

    	NSMutableArray* searchableItems = [[NSMutableArray alloc]init];
    	[self.personList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Person* person = (Person*)obj;
        CSSearchableItemAttributeSet* attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"views"];
        attributeSet.title = person.name;//标题
        attributeSet.contentDescription = [NSString stringWithFormat:@"My name is %@", person.name];//标题描述
        attributeSet.thumbnailData = UIImagePNGRepresentation(person.img);//缩略图片
        CSSearchableItem* item = [[CSSearchableItem alloc]initWithUniqueIdentifier:[NSString stringWithFormat:@"%ld", idx] domainIdentifier:@"Netease.Spotlight" attributeSet:attributeSet];
        [searchableItems addObject:item];
    }];
    	[[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchableItems completionHandler:^(NSError * _Nullable error) {
        	if (!error) {
           		 NSLog(@"--------%@-----------", error.description);
        	}
    	}];    
	}
	
此时搜索App中的数据（人名）会出现：

![](/Users/hzzhanyawei/Desktop/3.jpg)

##4.点击搜索响应

在AppDelegate中实现

	- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:	(void (^)(NSArray * _Nullable))restorationHandler{
    	NSString* idetifier = [userActivity.userInfo objectForKey:@"kCSSearchableItemActivityIdentifier"];
    	UINavigationController* navigationController = (UINavigationController*)self.window.rootViewController;
    	[navigationController popToRootViewControllerAnimated:YES];
    	ViewController* viewController = [[navigationController viewControllers] firstObject];
    	[viewController showViewControllerWithidetifier:idetifier];
    
    	return YES;
	}
	
##5.从CoreSpotlight中删除索引数据

删除所有索引

    [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {

    }];

根据identitier删除索引
  
    NSArray* removeItemsIdentifier = [NSArray arrayWithObjects:@"Jane", @"Pate", @"Ray", @"Tom", @"Becky", @"Ben", nil];
    [[CSSearchableIndex defaultSearchableIndex] deleteSearchableItemsWithIdentifiers:removeItemsIdentifier completionHandler:^(NSError * _Nullable error) {
          if (!error) {
              NSLog(@"--------%@-----------", error.description);
          }
    }];

