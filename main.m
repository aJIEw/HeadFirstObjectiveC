#import "person.h"

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
  NSLog(@"Hello World!");

  id var = nil;
  if (var) {
    NSLog(@"This is %p", var);
  } else {
    NSLog(@"var is empty");
  }

  // create a NSNumber
  NSNumber *fortyTwoLongNumber = @42L;
  // call a method
  long fortyTwoLong = [fortyTwoLongNumber longValue];
  // print number
  NSLog(@"%i", fortyTwoLong);

  // set with generic type
  NSMutableSet<NSString *> *set = [NSMutableSet setWithObjects:@"Hi", nil];
  [set addObject:@"there"];
  NSLog(@"%@", set);

  Person *p =[Person createWithName:@"jun"];
  [p changeName:@"aJIEw"];
  [p sayHi:@"Hello" message: @"Objective-C"];
}
