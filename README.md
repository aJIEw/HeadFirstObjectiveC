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

### 基本数据类型

### 类和对象

Objective-C 虽然和 Java 一样都是面向对象的语言，但是如果你像我一样之前没有接触过 C，那么第一点感到不适应的地方可能会是：为什么所有的类都要分别创建一个 `.h` 和一个 `.m` 文件呢？为什么要在 `.h` 文件中定义所有的属性和方法，然后再在 `.m` 文件中去实现呢？

其实这主要是因为过去的编程范式遗留下来的习惯，为了最大程度地复用代码，同时也保证了代码的清晰度，而且编译器也能根据 `.h` 文件来决定哪些属性和方法会被编译到最终生成的可执行文件中。[^注1]

如下所示，我们创建了一个 `person.h` 和 `person.m` 文件，其中定义和实现了 Person 类：

```objective-c
// 所有类都继承自 NSObject
@interface Person : NSObject
  // 属性变量
  @property (assign) NSString *name;
  // 方法，+ 表示类方法（类似 Java 中的静态方法），- 表示实例方法
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

#### 生命周期

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

#### Constructors

默认构造器：

```objective-c
- (id)init {
  // 判断父类是否初始化成功
  if ([super init]) {
    _nickName = @"default";
  }
  return self;
}
```

自定义构造器：

```objective-C
- (id)initWithNickname:(NSString *)nickName {
  if ([super init]) {
    _nickName = nickName;
    _age = 1;
  }
  return self;
}
```

#### Protocols

协议类似于 Java 中的接口 (*Interface*)，我们可以在 `@protocol` 中定义方法和属性，然后交由其它类去实现。

```objective-c
@protocol VideoPlayer <NSObject>
  @property BOOL playing;

  - (void)play;

  - (void)pause;
@end
```

使用某个协议的类，必须实现该协议中所有的属性和方法。

#### Categories



#### Extensions

### 方法和属性

#### Selectors

### 内存管理



[^注1]: 请参考这个回答：https://stackoverflow.com/a/2620632/4837812

