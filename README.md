Objective-C 主要用于开发 macOS/iOS/iPadOS 等平台上的应用，看它的名字就可以猜到，这是一门基于 C 的面向对象的编程语言。

### 程序入口

与大多数编程语言类似，OC 的程序运行入口也是 main 方法：

```objective-c
// 导入依赖，因为使用了 NSLog
#import <Foundation/Foundation.h>

// main 方法的返回值通常是 int
// main 方法参数分别是参数个数和参数数组，如果不需要也可以不写
// int main() {
int main(int argc, const char * argv[]) {
  // 为了和 C 的字符串区分，声明 NSString 时，需要在字符串前加 @
  // 另外，在创建一些字面量 literals 时，也需要使用 @
  NSLog(@"Hello World!");
}
```

我们可以使用 [clang](https://opensource.apple.com/source/clang/clang-23/clang/tools/clang/docs/UsersManual.html) 或 [gcc](https://opensource.apple.com/source/clang/clang-23/clang/tools/clang/docs/UsersManual.html) 编译 OC 源文件：

```shell
clang main.m -w -framework Foundation -o main
```

运行编译后生成的二进制文件：

```sh
./main
```

### 数据类型

#### Primitive types

Objective-C 是一门基于 C 的语言，所以为了兼容 C，它做了很多改进。我们可以像 C 中一样声明原始数据类型，也可以声明 Objective-C 中独有的支持作为对象使用的数据类型。

```objective-c
int primitiveInt  = 1;
long primitiveLong = 1;
float primitiveFloat = 1.0f;
double primitiveDouble = 1.0;
char charA = 'A';
```

Objective 中布尔类型字面量为数字 0 和 1：

```objective-c
BOOL noBool  = NO;
BOOL yesBool = YES;
NSLog(@"%d %d", noBool, yesBool);
```

另外，与 C 中一样，所有的整形数字分为  `signed` 与 `unsigned` 类型，`unsigned` 类型数据只能代表非负数。以 `unsigned int` 为例，同样 16 位的情况下，它的取值范围是 0 ~ 65535，而普通 `int` 的取值范围则是 -32767 ~ 32767。

#### Objects

除了基本数据类型之外，其它所有的数据类型都是作为对象被创建的。

```objective-c
MyClass *myObject1 = nil;  // Strong typing
id       myObject2 = nil;  // Weak typing
```

上面的例子中，`MyClass` 是我们定义的一个类，创建它时在对象名称前加 `*` 表示这是一个强类型对象。我们也可以使用 `id` 声明一个对象，它表示这是一个弱类型的对象，它可以代表任何类的对象。

```objective-c
id var = nil;
if (var) {
  NSLog(@"This is %p", var);
} else {
  NSLog(@"var is empty");
}
```

上面的例子中，我们声明一个 `var` 变量，并且初始化值为 `nil`，表示空值，此时使用 `if` 判断将会为 `false`，我们可以尝试将它修改成 `1` 或者 `YES` 再运行看看。

##### NSString

Objective-C 中的字符串用 `NSString` 表示，由于它是对象，所以创建时也需要使用指针。

```objective-c
NSString *str = @"Objective-C";
NSLog(str);

// 可变字符串
NSMutableString *mutableString = [NSMutableString stringWithString:@"Hello"];
[mutableString appendString:@" World!"];
NSLog(mutableString);
```

##### NSNumber

我们可以使用 `NSNumber` 创建数字类型的对象，与创建字符串类似，同样需要使用 `@` 符号。

```objective-c
// 创建一个长整型数字类型的对象
NSNumber *fortyTwoLongNumber = @42L;
// 转换成 long
long fortyTwoLong = [fortyTwoLongNumber longValue];
// 打印
NSLog(@"%li", fortyTwoLong);
```

##### NSArray

数组可以包含不同类型的数据，但是必须是对象。

```objective-c
NSArray *anArray = @[@1, @2L, @3.0F, @4U, @"5"];

NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:2];
[mutableArray addObject:@"Hello"];
[mutableArray addObject:@"World"];
[mutableArray removeObjectAtIndex:0];
NSLog(@"%@", [mutableArray objectAtIndex:0]);
```

##### NSDictionary

字典，类似于其它编程语言中的 `Map` 的数据类型。

```objective-c
NSDictionary<NSString *, NSObject *> *dictionary = 
    @{ @"name" : @"Objective-C", @"birth" : @1992 };
NSObject *dName = dictionary[@"name"];
NSLog(@"dictionary = %@", [dictionary description]);
```

##### NSSet

集合对象。

```objective-c
// 创建一个可变集合对象
NSMutableSet<NSString *> *set = [NSMutableSet setWithObjects:@"Hi", nil];
[set addObject:@"there"];
// 空值不会被加入
NSLog(@"set = %@", set);
```

### 类

Objective-C 虽然也是面向对象的语言，但是如果你像我一样之前没有接触过 C，那么第一点感到不适应的地方可能会是：为什么所有的类都要分别创建一个 `.h` 和一个 `.m` 文件呢？为什么要在 `.h` 文件中定义所有的属性和方法，然后再在 `.m` 文件中去实现呢？

其实这主要是因为过去的编程范式遗留下来的习惯，为了最大程度地复用代码，同时也保证了代码的清晰度，而且编译器也能根据 `.h` 文件来决定哪些属性和方法会被编译到最终生成的可执行文件中。[^注1]

如下所示，我们创建了一个 `person.h` 和 `person.m` 文件，其中定义和实现了 Person 类：

```objective-c
// 所有类都继承自 NSObject
@interface Person : NSObject
  // 属性
  @property (assign) NSString *name;
  // 方法，+ 表示类方法（类似静态方法），- 表示实例方法
  - (void)sayHi:(NSString *)greeting;
@end
```

定义完 `.h` 文件之后再在 `person.m` 中实现：

```objective-c
// 首先需要导入头文件
#import "person.h"

@implementation Person {
  // 实例变量
  NSString *_nickName;
  // 私有实例变量
  @private int _age;
}

- (void)sayHi:(NSString *)greeting {
  // 方法体
}

@end
```

#### Properties

类的属性，也就是可以被外界直接访问类中的变量，和实例变量最大的区别是，实例变量只能在当前类或者类中的实例方法才能被访问。

```objective-c
// 编译器会为属性生成一个 setter 方法，这里的话就是 setName 方法
@property NSString *name;

// 我们也可以自定义 getter 和 setter
@property (getter = ageGet, setter = ageSet: ) int age;
```

##### Attributes

我们还可以为类的属性设置其它修饰符 (*attribute*)，上面例子中的自定义 setter 和 getter 其实也是属性的修饰符，其它这样的修饰符还有：

- `readonly`: 表示只读，不会生成 setter 方法，默认为 `readwrite`。
- `copy`: 复制属性的值，也就是使用强引用，即使引用值发生了修改也不会影响属性本身的值。
- `nonatomic`: 非原子性（线程不安全）。默认所有的属性都是原子性的，也就是支持跨进程赋值。
- `unsafe_unretained`: 等同于 `weak`，也就是弱引用，当没有强引用的时候即释放它。主要用于防止多个对象之间的循环引用。

除了 `readonly` 之外，默认的 attribute 还有：

- `assign`: 赋值，告诉编译期生成 setter 方法
- `retain`: 等同于 `strong`，也就是强引用，保持引用直到所有对象都释放了它。
- `atomic`: 保持原子性，只有单个线程能访问它，线程安全但是效率更低。

##### `synthesize`

属性背后其实也依赖于实例属性，它会自动生成为我们生产一个 `_perpertyName` 的幕后属性 (*backing field*)，假如我们想要在实现类中使用不一样的名字，可以使用 `synthesize` 自定义：

```objective-c
@implementation YourClass

@synthesize propertyName = instanceVariableName;

@end
```

定义完属性之后，在实现类中有下面几种方式去访问它：

```objective-c
- (void)changeName {
  NSString *var = @"Objective-C";
  // 通过 backing field 访问
  _name = var;
  
  // 通过 setter
  [self setName:var];
  
  // 还可以使用 self. 语法
  self.name = var;
}
```

##### 实例属性

通常我们只会在实现类中定义实例属性。

```objective-c
@implementation SomeClass {
    NSString *_myNonPropertyInstanceVariable;
}
```

对于这样的实例属性，我们通常会在构造器方法中去初始化它，后面会提到。

#### Methods

前面提到过，Objective-C 中的方法有两种，一种是类方法，一种是实例方法，分别使用方法前面的 `+` 和 `-` 表示。除此之外，实现类中的方法通常由四部分组成，返回值+方法名+可选的方法参数+方法体。

```objective-c
- (void)myMethod:(int)arg1, param:(NSString *)arg2 {
  // do something
}
```

可以看到，和其它编程语言不同的地方在于，方法的参数和参数值是分开表示的，而且参数也是方法的一部分，调用的时候需要将参数一一列出：

```objective-c
[myClass meMethod:1 param:@"arg2"];
```

##### Constructors

构造器是一类特殊的方法，返回值通常是 `id`，我们可以在其中做一些类的初始化工作。

默认的构造器是 `init`：

```objective-c
- (id)init {
  self = [super init];
  // 判断父类是否初始化成功，如果初始化失败将会返回 nil
  if (self) {
    _nickName = @"default";
  }
  return self;
}
```

自定义构造器：

```objective-C
- (id)initWithNickname:(NSString *)nickName {
  self = [super init];
  if (self) {
    _nickName = nickName;
  }
  return self;
}
```

##### Selectors



#### Class Lifecycles

Objective-C 中的类也有生命周期，而且在创建和销毁的过程中还需要我们去管理内存的释放，这点以后会慢慢提到。

```objective-c
// 任何类在实例化之前都会先调用该方法
+ (void)initialize {  
}

// 对应于 initialize 方法，用于清空对象，当引用计数为 0 时被调用
- (void)dealloc {
  // 如果未启用 ARC，则需要手动释放引用计数
  [nickName release];
  // 调用父类方法
  [super dealloc];
}
```

#### Extensions

### Others

#### Protocols

协议类似于接口 (*Interface*) 的概念，我们可以在 `@protocol` 中定义方法和属性，然后交由其它类去实现。

```objective-c
@protocol Career <NSObject>

  @property BOOL retired;

  - (void)performWork;
@end
```

使用某个协议的类，必须实现该协议中所有的属性和方法。

```objective-c
// 下面这行注释会在文件和导航栏中添加一条分割线
#pragma mark -
// pragma mark 是一种特殊的管理代码的注释，方便我们在 XCode 导航栏中跳转到页面的各个区域
#pragma mark Career protocol
// 如果需要在实现类中使用 protocol 中的属性，必须使用 synthesize 暴露出属性
@synthesize retired = _retired;

// 实现 protocol 中的方法
- (void)performWork {
  NSLog(@"do some work.");
}
```

#### Categories

#### Blocks

Blocks 是 Objective-C 中一种特殊的对象，它可以直接执行一段代码，类似其它语言中的 lambda 表达式。

##### Block 字面量

我们可以使用 `^` 符创建一个 block 字面量：

```objective-c
^{
  NSLog(@"This is a block");
}
```

类似与 C 中的方法指针，我们可以使用下面的语法去引用一个 block：

```objective-c
void (^simpleBlock)(void);
```

以上可以理解为我们创建了一个 `simpleBlock` 变量来表示一个参数为 void，返回值也为 void 的方法。

之后，我们可以创建方法体：

```objective-c
simpleBlock = ^ {
  NSLog(@"This is a block");
}
```

当然，我们也可以将上面两个步骤合二为一：

```objective-c
void (^simpleBlock)(void) = ^ {
  NSLog(@"This is a block");
}
```

另外，block 也可以包含参数和返回值：

```objective-c
double (^addBlock)(double, double) = 
  ^(double firstValue, double secondValue) {
    return firstValue * secondValue;
  };
```

### 内存管理



[^注1]: 请参考这个回答：https://stackoverflow.com/a/2620632/4837812

