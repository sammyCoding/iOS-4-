//
//  ViewController.m
//  Homepwner
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ViewController.h"
#import "ZWAItem.h"
#import "ZWAItemStore.h"


@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 250; i++) {
            [[ZWAItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ZWAItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    //创建或重用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *items = [[ZWAItemStore sharedStore] allItems];
    ZWAItem *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    return cell;
}







@end
