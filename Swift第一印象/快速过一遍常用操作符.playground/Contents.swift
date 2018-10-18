import UIKit

var str = "快速过一遍常用操作符"

/// 基本操作符 basic operators

/// 赋值操作符

//: #### Basic assignment
let a = 20
var b = 10

/// 基本算术运算操作符
let sum = a + b
let sub = a - b
let mul = a * b
let div = a / b
let mod = a % b

/// “Swift 3不再允许浮点数取模。例如：8 ％ 2.5这样的写法在Swift 3中将会报错。如果要对浮点数取模，只能这样
8.truncatingRemainder(dividingBy: 2.5)

/// 复合运算操作符

//: #### Compound assignment

b += 10 // b = b + 10
b -= 10 // b = b - 10
b *= 10 // b = b * 10
b /= 10 // b = b / 10
b %= 10 // b = b % 10

//“Swift不会把数字自动转换成Bool类型。在需要Bool值的地方，你必须明确使用一个Bool变量。”
//“Swift中不再支持自增（++）和自减（--）操作符，使用它们的前缀和后缀版本都会得到一个编译器错误。因此，需要+1/-1的时候，只能使用b += 1和b -= 1来实现。”

/// 比较操作符
//: #### Comparison
let isEqual     = sum == 10
let isNotEqual  = sum != 10
let isGreater   = sum >  10
let isLess      = sum <  10
let isGe        = sum >= 10
let isLe        = sum <= 10

//除此之外，Swift还支持两个用于比较对象引用的操作符：Identity operator，它们用来判断两个操作数是否引用同一个对象，我们在后面讲到面向对象编程的时候，会进一步提到这两个操作符。

//: Identity operator

//===
//!==


/// 三元操作符
/*
 * if condition {
 *     expression1
 * }
 * else {
 *     expression2
 * }
 *
 */

let isSumEqualToTen = isEqual ? "Yes" : "No"


/// Nil Coalescing Operator swift特有的操作
// opt != nil ? opt! : b

var userInput: String? = "A user input"
let value = userInput ?? "A default input"


/// Range operator 区间操作

/// 闭区间range operator
//: Closed range operator
// begin...end

for index in 1...5 {
    print(index)
}

/// 半开半闭区间range operator
//: Half-open range operator
// begin..<end [begin, end)

for index in 1..<5 {
    print(index)
}

//逻辑运算符
/// Swift支持三种常用的逻辑运算：NOT，AND和OR。它们都返回一个Bool：
//: #### Logic operator

let logicalNot = !isEqual
let logicalAnd = isNotEqual && isLess
let logicalOR  = isGreater  || (isLess && isLe)
