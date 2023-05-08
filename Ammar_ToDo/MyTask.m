//
//  MyTask.m
//  Ammar_ToDo
//
//  Created by ammar on 30/04/2023.
//

#import "MyTask.h"

@implementation MyTask
- (instancetype)init {
    self = [super init];
    if (self) {
        _creationDate = [NSDate date];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.taskDescription = [decoder decodeObjectForKey:@"taskDescription"];
        self.priority = [decoder decodeIntegerForKey:@"priority"];
        self.status = [decoder decodeIntegerForKey:@"status"];
        self.creationDate = [decoder decodeObjectForKey:@"creationDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.taskDescription forKey:@"taskDescription"];
    [encoder encodeInteger:self.priority forKey:@"priority"];
    [encoder encodeInteger:self.status forKey:@"status"];
    [encoder encodeObject:self.creationDate forKey:@"creationDate"];
}

@end
