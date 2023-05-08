//
//  DetailsViewController.m
//  Ammar_ToDo
//
//  Created by ammar on 30/04/2023.
//

#import "DetailsViewController.h"



@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TaskStatus i =[_mytask priority];
    if (i== TaskStatusDone)
        _image.image=[UIImage imageNamed:@"done"];
    else if(i==TaskStatusToDo)
        _image.image=[UIImage imageNamed:@"toDo"];
    else
        _image.image=[UIImage imageNamed:@"inProgress"];
    
    _name.text=_mytask.name;
    _desc.text=_mytask.taskDescription;
    NSString *myString = [NSString stringWithFormat:@"%ld", (long)_mytask.priority];
    _priority.text=myString;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *stringFromDate = [dateFormatter stringFromDate:_mytask.creationDate];
    _date.text=stringFromDate;
    
    
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(editButtonTapped:)];
    self.navigationItem.rightBarButtonItem = self.editButton;

}
- (void)editButtonTapped:(id)sender {
    
}



@end
