//
//  ViewController.h
//  Ammar_ToDo
//
//  Created by ammar on 30/04/2023.
//

#import <UIKit/UIKit.h>
#import "MyTask.h"
#import "HomeDeleget.h"

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *statusPicker;
@property (weak, nonatomic) IBOutlet UILabel *erorr;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *descTxt;
@property MyTask* mytask;
@property (nonatomic, strong) UIBarButtonItem *saveButton;
@property id<HomeDeleget> deleget;

@end

