//
//  DetailsViewController.h
//  Ammar_ToDo
//
//  Created by ammar on 30/04/2023.
//

#import <UIKit/UIKit.h>
#import "MyTask.h"
@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *priority;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (nonatomic, strong) UIBarButtonItem *editButton;

@property MyTask* mytask;

@end


