import UIKit

var str = "整数和浮点数"

/// 整数 - Int & UInt 除非明确s要使用UInt 我们总应该使用Int

//根据一个整数变量占据的内存空间（8 / 16 / 32 / 64-bit）以及整数是否带有符号（Unsinged）,Swift一共定义了8种不同的整数类型：

//Int(8 / 16 / 32 / 64)
//UInt(8 / 16/ 32/ 64)

/// 在64位平台上，我们分别使用min和max方法，来查看Int和Int64的范围
Int.min
Int.max

Int64.min
Int64.max

/// 整数的常用表达式

/// 包括使用10进制、16进制、8进制、2进制

let fifteenInDecimal = 15

let fifteenInHex = 0xF

let fifteenInOctal = 0o17

let fifteenInBinary = 0b1111


/// 我们j可以在数字中使用分隔符

let milllon = 1_000_000


/// 浮点数 Float & Double
//在Swift里，根据可以表达的精度范围，有两种不同的浮点数类型：
//
//Float: 最多表达6位精度的浮点数；
//Double: 至少可以表达15位精度的浮点数；
/// 如无明确需求，统一使用Double


var oneThirdInFloat: Float = 1/3
var oneThirdInDouble: Double = 1/3

print(oneThirdInFloat)  // 0.333333
print(oneThirdInDouble) // 0.333333333333333

var PI = 0.314e1
PI = 314e-2

/// 和数字有关的Type Inference

/// 我们可以吧不同的字面值进行运算
PI = 3 + 0.14
//PI = 3 + "0" // 这样不行

var three = 3
var zeroPointForteen = 0.14


//PI = three + zeroPointForteen  /// 这样也不行

