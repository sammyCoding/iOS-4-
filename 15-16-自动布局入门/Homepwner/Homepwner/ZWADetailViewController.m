//
//  ZWADetailViewController.m
//  Homepwner
//
//  Created by Zeon Waa on 3/8/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWADetailViewController.h"
#import "ZWAItem.h"
#import "ZWAImageStore.h"

@interface ZWADetailViewController ()<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation ZWADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valueField.keyboardType = UIKeyboardTypeNumberPad;
    
    //将imageView垂直方向的优先级设置为比其他视图低的数值
    
    //1.Content hugging priority 表示视图固有大小的放大优先级，如果该优先级为1000，表示不允许自动布局系统基于固有内容大小放大视图尺寸；相反，如果该优先级小于1000，自动布局系统则会在必要时放大视图尺寸
    //2.Content compression resistance priority 表示视图固有内容大小的缩小优先级，如果该优先级为1000，表示不允许自动布局系统基于固有内容大小缩小视图尺寸；相反，如果该优先级小于1000，自动布局系统则会在必要时缩小视图尺寸。
    
    /*
    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisVertical];
    */
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ZWAItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];

    
    //根据itemKey，显示照片
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[ZWAImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消当前的第一响应对象
    [self.view endEditing:YES];
    
    //将修改“保存”到 ZWAItem对象
    ZWAItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
}

-(void)setItem:(ZWAItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    [self.view endEditing:YES];
//}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //用相机拍摄
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        //从相册中选择
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - imagePicker delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[ZWAImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//将uiview改成UIControl 再添加action实现点击背景关闭键盘

- (IBAction)backgroundTapped:(id)sender {
     [self.view endEditing:YES];
}

@end
