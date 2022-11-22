#import "person+read.h"

@implementation Person (Read)

- (void)read:(NSString *)material {
  NSLog(@"I'm reading %@", material);
}

@end