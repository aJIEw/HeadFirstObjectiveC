#import "worker.h"

#import <Foundation/Foundation.h>

@interface Person : NSObject<Worker>

@property (assign) NSString *name;

- (void)sayHi:(NSString *)greeting message:(NSString *)msg;

@end