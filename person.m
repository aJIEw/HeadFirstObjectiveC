#import "person.h"

@implementation Person {
  NSString *_nickName;
  @private int _age;
}

+ (void)initialize {
  NSLog(@"called in initialize");
}

- (id)init {
  // Check parent class init success
  if ([super init]) {
    _nickName = @"default";
    _age = 0;
  }
  return self;
}

// The parameters are also part of the method signature!
- (id)initWithNickname:(NSString *)nickName age:(int)ageArg {
  if ([super init]) {
    _nickName = nickName;
    _age = ageArg;
  }
  return self;
}

+ (instancetype)createWithName:(NSString *)name {
  Person *p = [[self alloc] init];
  p.name = name;
  return p;
}

- (void)changeName:(NSString *)name {
  _name = name;
  NSLog(@"name = %@", _name);
}

- (void)sayHi:(NSString *)greeting message:(NSString *)msg {
  NSLog(@"%@, %@ aka %@(%li)! Welcome to the world of %@!", 
          greeting, _name, _nickName, _age, msg);
}

- (void)dealloc {
  // If not using ARC, make sure to release class variable objects
  [_nickName release];
  // and call parent class dealloc
  [super dealloc];
}

@end