//
//  ZWAItemStore.m
//  Homepwner
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAItemStore.h"
#import "ZWAItem.h"
#import "ZWAImageStore.h"
#import "AppDelegate.h"

@interface ZWAItemStore ()
//内部用的可变数组
@property (nonatomic, strong) NSMutableArray *privateItems;

@end

@implementation ZWAItemStore

+ (instancetype)sharedStore {
    //静态变量，程序不会释放，并不是保存在栈中的。
    static ZWAItemStore *sharedStore = nil;
//    if (!sharedStore) {
//        sharedStore = [[self alloc]initPrivate];
//    }
    //多线程单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ZWAItemStore sharedStore]" userInfo:nil];
    return nil;
}

//真正的（私有的）初始化方法
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
//        _privateItems = [[NSMutableArray alloc]init];
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

- (ZWAItem *)createItem {
    ZWAItem *item = [[ZWAItem alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    item.valueInDollars = [defaults integerForKey:ZWANextItemValuePrefsKey];
    item.itemName = [defaults objectForKey:ZWANextItemNamePrefsKey];
    NSLog(@"defaults = %@", [defaults dictionaryRepresentation]);
    [self.privateItems addObject:item];
    return item;
}

- (NSArray *)allItems {
    //这里虽然 privateItems是可变数组，但也是数组的子类，所以没有问题。
    return self.privateItems;
}

- (void)removeItem:(ZWAItem *)item {
    NSString *key = item.itemKey;
    [[ZWAImageStore sharedStore] deleteImageForKey:key];
    
    //removeObjectIdenticalTo: 方法不会比较对象所包含的数据，只会比较指向对象的指针。
    [self.privateItems removeObjectIdenticalTo:item];

}

- (void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }

    ZWAItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];

}

@end
