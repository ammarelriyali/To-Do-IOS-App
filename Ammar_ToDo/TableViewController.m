//
//  TableViewController.m
//  Ammar_ToDo
//
//  Created by ammar on 30/04/2023.
//

#import "TableViewController.h"
#include "DetailsViewController.h"
#include "ViewController.h"

@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"tasks.plist"];
    _dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    _isPriority=false;

    _arr = _dataSource;
    
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"all notes ",@"to-do", @"in progress",@"done", @"priority"]];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = self.segmentedControl;
    
    [self.segmentedControl addTarget:self
                              action:@selector(segmentedControlDidChangeValue:)
                    forControlEvents:UIControlEventValueChanged];
    
    self.addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(addButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = self.addButton;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
}

- (void)addButtonTapped:(id)sender {
    ViewController *myViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AddTask"];
    myViewController.deleget=self;
    [self.navigationController pushViewController:myViewController animated:YES];
}

- (void)segmentedControlDidChangeValue:(UISegmentedControl *)sender {
    self.tableView.backgroundView = nil;
    NSPredicate *predicate;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            _arr=_dataSource ;
            _isPriority=false;
            
            break;
        case 1:{
            predicate = [NSPredicate predicateWithFormat:@"status == %d", TaskStatusToDo];
            _arr = [_dataSource filteredArrayUsingPredicate:predicate] ;
            _isPriority=false;
            
        }
            break;
            
        case 2:
            predicate = [NSPredicate predicateWithFormat:@"status == %d", TaskStatusInProgress];
            _arr = [_dataSource filteredArrayUsingPredicate:predicate] ;
            _isPriority=false;
            
            break;
        case 3:
            predicate = [NSPredicate predicateWithFormat:@"status == %d", TaskStatusDone];
            _arr = [_dataSource filteredArrayUsingPredicate:predicate] ;
            _isPriority=false;
            
            break;
        case 4:
            _isPriority=true;
            break;
            
    }
    [self.tableView reloadData];
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    
    _arr = [self.dataSource filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[c] %@", searchText]];
    if (_arr.count == 0) {
        self.tableView.backgroundView = [[UILabel alloc] initWithFrame:self.tableView.bounds];
        self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
        self.tableView.backgroundView.opaque = NO;
        self.tableView.backgroundView.alpha = 0.5;
        ((UILabel *)self.tableView.backgroundView).text = @"No results found";
        ((UILabel *)self.tableView.backgroundView).textAlignment = NSTextAlignmentCenter;
    } else {
        self.tableView.backgroundView = nil;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_isPriority)
        return 3;
    
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_isPriority){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"priority == %d", TaskPriorityLow];
        NSArray *lowArray = [_dataSource filteredArrayUsingPredicate:predicate];
        predicate = [NSPredicate predicateWithFormat:@"priority == %d", TaskPriorityMedium];
        NSArray *mediumArray = [_dataSource filteredArrayUsingPredicate:predicate];
        predicate = [NSPredicate predicateWithFormat:@"priority == %d", TaskPriorityHigh];
        NSArray *highArray = [_dataSource filteredArrayUsingPredicate:predicate];
        switch (section) {
            case 0:
                return lowArray.count;
                break;
            case 1:
                return mediumArray.count;
                break;
                
            default:
                return highArray.count;
                
        }
    }
    else{
        return _arr.count;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(_isPriority){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"priority == %d", TaskPriorityLow];
        NSArray<MyTask *> *lowArray = [_dataSource filteredArrayUsingPredicate:predicate];
        predicate = [NSPredicate predicateWithFormat:@"priority == %d", TaskPriorityMedium];
        NSArray<MyTask *> *mediumArray = [_dataSource filteredArrayUsingPredicate:predicate];
        predicate = [NSPredicate predicateWithFormat:@"priority == %d", TaskPriorityHigh];
        NSArray<MyTask *> *highArray = [_dataSource filteredArrayUsingPredicate:predicate];
        
        switch (indexPath.section) {
            case 0:{
                cell.textLabel.text= [[lowArray objectAtIndex:indexPath.row] name];
                cell.detailTextLabel.text =[[lowArray objectAtIndex:indexPath.row] taskDescription];
                TaskStatus i =[[lowArray objectAtIndex:indexPath.row] priority];
                if (i== TaskStatusDone)
                    cell.imageView.image=[UIImage imageNamed:@"done"];
                else if(i==TaskStatusToDo)
                    cell.imageView.image=[UIImage imageNamed:@"toDo"];
                else
                    cell.imageView.image=[UIImage imageNamed:@"inProgress"];
                
            }
                
                break;
            case 1:{
                cell.textLabel.text= [[mediumArray objectAtIndex:indexPath.row] name];
                cell.detailTextLabel.text =[[mediumArray objectAtIndex:indexPath.row] taskDescription];
                TaskStatus i =[[mediumArray objectAtIndex:indexPath.row] priority];
                if (i== TaskStatusDone)
                    cell.imageView.image=[UIImage imageNamed:@"done"];
                else if(i==TaskStatusToDo)
                    cell.imageView.image=[UIImage imageNamed:@"toDo"];
                else
                    cell.imageView.image=[UIImage imageNamed:@"inProgress"];
                
            }
                
                break;
                
            default:{
                cell.textLabel.text= [[highArray objectAtIndex:indexPath.row] name];
                cell.detailTextLabel.text =[[highArray objectAtIndex:indexPath.row] taskDescription];
                TaskStatus i =[[highArray objectAtIndex:indexPath.row] priority];
                if (i== TaskStatusDone)
                    cell.imageView.image=[UIImage imageNamed:@"done"];
                else if(i==TaskStatusToDo)
                    cell.imageView.image=[UIImage imageNamed:@"toDo"];
                else
                    cell.imageView.image=[UIImage imageNamed:@"inProgress"];
                
            }
                
        }
    }
    
    else{
        cell.textLabel.text= [[_arr objectAtIndex:indexPath.row] name];
        cell.detailTextLabel.text =[[_arr  objectAtIndex:indexPath.row] taskDescription];
        TaskStatus i =[[_arr objectAtIndex:indexPath.row] priority];
        if (i== TaskStatusDone)
            cell.imageView.image=[UIImage imageNamed:@"done"];
        else if(i==TaskStatusToDo)
            cell.imageView.image=[UIImage imageNamed:@"toDo"];
        else
            cell.imageView.image=[UIImage imageNamed:@"inProgress"];
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // Create the path to the plist file
        NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"tasks.plist"];
        
        // Load the existing tasks (if any)
        
        
        NSMutableArray<MyTask *> *tasks = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
        
        // If there are no existing tasks, create a new array
        if (!tasks) {
            tasks = [NSMutableArray array];
        }
        
        MyTask *reTask=[_arr objectAtIndex:indexPath.row];
        for (NSInteger i = tasks.count - 1; i >= 0; i--) {
            MyTask *task=[tasks objectAtIndex:i];
            if(task.name==reTask.name&&task.taskDescription==reTask.taskDescription){
                [tasks removeObject:task];
            }
        }
        // Save the tasks to the plist file
        BOOL success = [NSKeyedArchiver archiveRootObject:tasks toFile:plistPath];
        
        [_arr removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(_isPriority){
        if (section == 2) {
            return @"High Priority";
        } else if (section == 1) {
            return @"Medium Priority";
        } else {
            return @"Low Priority";
        }
        
    }
    else return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *myViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    myViewController.mytask= [_arr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:myViewController animated:YES];
}

- (void)relaod{
    printf("\nlksjdl");
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"tasks.plist"];
    _dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    _isPriority=false;
    
    _arr = _dataSource;
    [self.tableView reloadData];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
