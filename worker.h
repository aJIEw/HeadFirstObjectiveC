#import <Foundation/Foundation.h>

@protocol Worker <NSObject>

  @property BOOL retired;

  - (void)punchIn;

  - (void)performWork;

  - (void)punchOut;
@end