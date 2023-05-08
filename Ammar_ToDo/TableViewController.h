//
//  TableViewController.h
//  Ammar_ToDo
//
//  Created by ammar on 30/04/2023.
//

#import <UIKit/UIKit.h>
#include "MyTask.h"
#include "HomeDeleget.h"

@interface TableViewController : UITableViewController<UISearchResultsUpdating,HomeDeleget>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIBarButtonItem *addButton;
@property NSMutableArray<MyTask *> *arr;
@property NSMutableArray<MyTask *> *dataSource;
@property bool isPriority;
@property UISearchController *searchController;

@end

