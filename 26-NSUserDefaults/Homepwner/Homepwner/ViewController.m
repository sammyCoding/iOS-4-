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
#import "ZWADetailViewController.h"
#import "ZWAItemCell.h"
#import "ZWAImageStore.h"
#import "ZWAImageViewController.h"


@interface ViewController ()<UIPopoverControllerDelegate, UIDataSourceModelAssociation>

@property (nonatomic, strong) IBOutlet UIView *headerView;

@property (nonatomic, strong) UIPopoverController *imagePopover;

@end

@implementation ViewController

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
//        navItem.title = @"Homepwner";
        navItem.title = NSLocalizedString(@"Homepwner", @"Name of application");
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        
        //UIViewController 对象有一个名为editButtonItem 的属性，当该对象收到editButtonItem消息后，如果editButtonItem属性的值为nil，就会创建一个标题为“编辑”的UIBarButtonItem对象。此外，editButtonItem方法返回的 UIBarButtonItem对象默认设置好了目标-动作对。当用户点击对应的按钮时，包含该对象的 UIViewController对象就会收到setEditing:animated:消息。
        
        navItem.leftBarButtonItem = self.editButtonItem;
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(updateTableViewForDynamicTypeSize) name:UIContentSizeCategoryDidChangeNotification object:nil];
        [nc addObserver:self selector:@selector(localeChanged:) name:NSCurrentLocaleDidChangeNotification object:nil];
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    UINib *nib = [UINib nibWithNibName:@"ZWAItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ZWAItemCell"];
    
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
    
    self.tableView.restorationIdentifier = @"ViewControllerTableView";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [coder encodeBool:self.editing forKey:@"TableViewIsEditing"];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    self.editing = [coder decodeBoolForKey:@"TableViewIsEditing"];
    [super decodeRestorableStateWithCoder:coder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTableViewForDynamicTypeSize];

}

- (void)updateTableViewForDynamicTypeSize {
    static NSDictionary *cellHeightDictionary;
    if (!cellHeightDictionary) {
        cellHeightDictionary = @{
                                 UIContentSizeCategoryExtraSmall : @44,
                                 UIContentSizeCategorySmall : @44,
                                 UIContentSizeCategoryMedium : @44,
                                 UIContentSizeCategoryLarge : @44,
                                 UIContentSizeCategoryExtraLarge : @55,
                                 UIContentSizeCategoryExtraExtraLarge : @65,
                                 UIContentSizeCategoryExtraExtraExtraLarge : @75
                                 
                                 };
         }
        NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
        NSNumber *cellHeight = cellHeightDictionary[userSize];
        [self.tableView setRowHeight:cellHeight.floatValue];
        [self.tableView reloadData];
   

}

- (IBAction)addNewItem:(id)sender {
    ZWAItem *newItem = [[ZWAItemStore sharedStore] createItem];
//    NSInteger lastRow = [[[ZWAItemStore sharedStore] allItems] indexOfObject:newItem];
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    ZWADetailViewController *detailVC = [[ZWADetailViewController alloc] initForNewItem:YES];
    detailVC.item = newItem;
    detailVC.dismissBlock = ^{
        [self.tableView reloadData];
    };
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailVC];
    navController.restorationIdentifier = NSStringFromClass([navController class]);
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    //不覆盖UINavigationBar
//    navController.modalPresentationStyle = UIModalPresentationCurrentContext;
//    self.definesPresentationContext = YES;
//    
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navController animated:YES completion:nil];
    
}

- (void)localeChanged:(NSNotification *)note {
    [self.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ZWAItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    //创建或重用cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ZWAItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWAItemCell" forIndexPath:indexPath];
    
    NSArray *items = [[ZWAItemStore sharedStore] allItems];
    ZWAItem *item = items[indexPath.row];
//    cell.textLabel.text = [item description];
    
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    static NSNumberFormatter *currencyFormatter = nil;
    if (currencyFormatter == nil) {
        currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    
//    cell.valueLabel.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    cell.valueLabel.text = [currencyFormatter stringFromNumber:@(item.valueInDollars)];
    
    cell.thumbnailView.image = item.thumbnail;
    __weak ZWAItemCell *weakCell = cell;
    cell.actionBlock = ^{
        NSLog(@"going to show image for %@", item);
        ZWAItemCell *strongCell = weakCell;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            NSString *itemKey = item.itemKey;
            UIImage *img = [[ZWAImageStore sharedStore] imageForKey:itemKey];
            if (!img) {
                return ;
            }
            
            //
            CGRect rect = [self.tableView convertRect:strongCell.thumbnailView.bounds fromView:strongCell.thumbnailView];
            ZWAImageViewController *ivc = [[ZWAImageViewController alloc] init];
            ivc.image = img;
            
            self.imagePopover = [[UIPopoverController alloc] initWithContentViewController:ivc];
            self.imagePopover.delegate = self;
            self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
            [self.imagePopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        
        
        
        
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[ZWAItemStore sharedStore] allItems];
        ZWAItem *item = items[indexPath.row];
        [[ZWAItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[ZWAItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZWADetailViewController *detailVC = [[ZWADetailViewController alloc] initForNewItem:NO];
    NSArray *items = [[ZWAItemStore sharedStore] allItems];
    ZWAItem *selectedItem = items[indexPath.row];
    
    detailVC.item = selectedItem;
    [self.navigationController pushViewController:detailVC animated:YES];

}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.imagePopover = nil;
}

- (void)dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];

}

-(NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view {
    NSString *identifier = nil;
    if (idx && view) {
        ZWAItem *item = [[ZWAItemStore sharedStore] allItems][idx.row];
        identifier = item.itemKey;
    }
    return identifier;
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view {
    NSIndexPath *indexPath = nil;
    if (identifier && view) {
        NSArray *items = [[ZWAItemStore sharedStore] allItems];
        for (ZWAItem *item  in items) {
            if ([identifier isEqualToString:item.itemKey]) {
                int row = [items indexOfObjectIdenticalTo:item];
                indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                break;
            }
        }
    }
    return indexPath;

}

@end
