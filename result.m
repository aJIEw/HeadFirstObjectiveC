#import "result.h"

@implementation Result

- (void)handleSuccess:(void (^)(id))success
              failure:(void (^)(NSError *))failure {
  success(@42);
}

@end