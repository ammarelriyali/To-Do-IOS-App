//
//  ViewController.m
//  Ammar_ToDo
//
//  Created by ammar on 30/04/2023.
//

#import "ViewController.h"
#import "TableViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mytask=[MyTask new];
    _mytask.priority=TaskPriorityHigh;
    _mytask.status=TaskStatusToDo;
    self.navigationController.delegate = self;
    
    self.statusPicker.dataSource = self;
    self.statusPicker.delegate = self;
    
    [self.view addSubview:self.statusPicker];
    
    self.saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(saveButtonTapped:)];
    self.navigationItem.rightBarButtonItem = self.saveButton;
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = newBackButton;
}

- (void)saveButtonTapped:(id)sender {
    if(_nameTxt.text.length==0||_descTxt.text.length==0)
        _erorr.text=@"pleas enter name and desc";
    else
    {
        _mytask.name=_nameTxt.text;
        _mytask.taskDescription=_descTxt.text;
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // Create the path to the plist file
        NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"tasks.plist"];
        
        // Load the existing tasks (if any)
        
        
        NSMutableArray<MyTask *> *tasks = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
        
        // If there are no existing tasks, create a new array
        if (!tasks) {
            tasks = [NSMutableArray array];
        }
        
        // Add the task to the array
        [tasks addObject:_mytask];
        
        // Save the tasks to the plist file
        BOOL success = [NSKeyedArchiver archiveRootObject:tasks toFile:plistPath];
        
        if (success) {
            NSLog(@"Tasks saved successfully");
            [_deleget relaod];
            [self.navigationController popViewControllerAnimated:true];
        } else {
            NSLog(@"Failed to save tasks");
        }
        
      
    }
}
-(void) back{
    // Display an alert view to confirm if the user wants to go back
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to go back?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // If the user confirms, pop the view controller
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component==0) {
        switch (row) {
            case 0:
                return @"High";
            case 1:
                return @"Med";
                
            default:
            return @"low";}
    }
    else {
        // Return the content to display for each row in the UIPickerView
        switch (row) {
            case 0:
                return @"To Do";
            case 1:
                return @"In Progress";
            default:
                return @"Done";
                
        }
    }
    
}



#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component){
        switch (row) {
            case 0:
                _mytask.status=TaskStatusToDo;
            case 1:
                _mytask.status=TaskStatusInProgress;
            default:
                _mytask.status=TaskStatusDone;
                
        }
    }
    else{
        switch (row) {
            case 0:
                _mytask.priority=TaskPriorityHigh;
            case 1:
                _mytask.priority=TaskPriorityMedium;
                
            default:
                _mytask.priority=TaskPriorityLow;
                
                
        }
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    // Return the height of each row in the UIPickerView
    return 44.0; // Replace 44.0 with the height you want for each row
}

@end
