#import <Foundation/Foundation.h>

@interface Result<__covariant A> : NSObject

- (void)handleSuccess:(void (^)(A))success
              failure:(void (^)(NSError *))failure;

@end