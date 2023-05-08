//
//  MyTask.h
//  Ammar_ToDo
//
//  Created by ammar on 30/04/2023.
//

// MyTask.h

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, TaskPriority) {
    TaskPriorityLow,
    TaskPriorityMedium,
    TaskPriorityHigh
};

typedef NS_ENUM(NSInteger, TaskStatus) {
    TaskStatusToDo,
    TaskStatusInProgress,
    TaskStatusDone
};

@interface MyTask :  NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *taskDescription;
@property (nonatomic, assign) TaskPriority priority;
@property (nonatomic, assign) TaskStatus status;
@property (nonatomic, strong) NSDate *creationDate;


@end

