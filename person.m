#import "person.h"

@implementation Person {
  NSString *_nickName;
  @private int _age;
}

#pragma mark - Lifecycle methods
+ (void)initialize {
  NSLog(@"called in initialize");
}

- (void)dealloc {
  NSLog(@"===========> dealloc");
  // If not using ARC, make sure to release class variable objects
  [_nickName release];
  // and call parent class dealloc
  [super dealloc];
}

#pragma mark - Constructor methods
- (id)init {
  self = self = [super init];
  // Check parent class init success, may return nil
  if (self) {
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

#pragma mark - Career protocol
@synthesize retired = _retired;

- (void)punchIn {
  NSLog(@"punch in.");
}

- (void)performWork {
  NSLog(@"do some work.");
}

- (void)punchOut {
  NSLog(@"punch in.");
}

#pragma mark - Class methods
+ (instancetype)createWithName:(NSString *)name {
  Person *p = [[self alloc] init];
  p.name = name;
  NSLog(@"createWithName %@", name);
  return p;
}

#pragma mark - Instance methods
- (void)changeName:(NSString *)name {
  [self setName: name];
  NSLog(@"change name to %@", _name);
}

- (void)changeRetireStatus:(BOOL)retired {
  _retired = retired;
  NSLog(@"change retired status to %d", retired);
}

- (void)sayHi:(NSString *)greeting message:(NSString *)msg {
  NSLog(@"%@, %@ aka %@(%li)! Welcome to the world of %@!", 
          greeting, _name, _nickName, _age, msg);
}

@end