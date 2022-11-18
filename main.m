#import "person.h"

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
  NSLog(@"Hello World!");


  NSLog(@"============ Primitive types =============");
  int primitiveInt  = 1;
  long primitiveLong = 1;
  float primitiveFloat = 1.0f;
  double primitiveDouble = 1.0;
  char charA = 'A';
  NSLog(@"%i %li %f %lf %c", primitiveInt, primitiveLong, primitiveFloat, primitiveDouble, charA);

  BOOL noBool  = NO;
  BOOL yesBool = YES;
  NSLog(@"%d %d", noBool, yesBool);

  id var = nil;
  if (var) {
    NSLog(@"This is %p", var);
  } else {
    NSLog(@"var is empty");
  }


  NSLog(@"============ Objective-C basic objects =============");
  NSNumber *fortyTwoLongNumber = @42L;
  long fortyTwoLong = [fortyTwoLongNumber longValue];
  NSLog(@"fortyTwoLong = %li", fortyTwoLong);

  NSArray *array = @[@1, @2L, @3.0F, @4U, @"5"];
  NSLog(@"array[2] = %@", array[2]);
  NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:2];
  [mutableArray addObject:@"Hello"];
  [mutableArray addObject:@"World"];
  [mutableArray removeObjectAtIndex:0];
  NSLog(@"mutableArray call: %@", [mutableArray objectAtIndex:0]);

  NSDictionary<NSString *, NSObject *> *dictionary = @{ @"name" : @"Objective-C", @"birth" : @1992};
  NSObject *dName = dictionary[@"name"];
  NSLog(@"dictionary = %@", [dictionary description]);

  NSMutableSet<NSString *> *set = [NSMutableSet setWithObjects:@"Hi", nil];
  [set addObject:@"there"];
  NSLog(@"set = %@", set);


  NSLog(@"============ Class objects =============");
  Person *p =[Person createWithName:@"jun"];
  [p changeName:@"aJIEw"];
  [p sayHi:@"Hello" message: @"Objective-C"];
  [p performWork];
  [p changeRetireStatus:YES];
  NSLog(@"retired %d", p.retired);


  NSLog(@"============ Selector with dynamic call =============");
  // run with ./a.out -t performWork sayHi:message:
  if (argc > 2) {
    NSLog(@"argc = %i", argc);
    for (int i = 2; i < argc; i++) {
      NSString *method = [NSString stringWithUTF8String: argv[i]];
      NSLog(@"method = %@", method);
      SEL sel = NSSelectorFromString(method);
      if ([p respondsToSelector:sel]) {
        IMP imp = [p methodForSelector:sel];
        void (*func)(id, SEL, NSString*, NSString*) = (void *)imp;
        func(p, sel, @"Hey", @"Objective-C");

        // [p performSelector:sel withObject:@"Hey" withObject:@"Objective-C"];
      }
    }
  }
  

  NSLog(@"============ Blocks example ============");
  void (^simpleBlock)(void);
  simpleBlock = ^{
    NSLog(@"This is a block");
  };
  simpleBlock();
}
