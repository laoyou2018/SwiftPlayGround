import UIKit

var str = "使用Tuple打包数据"

/// 很多时候我们需要吧不同的类型的值，打包成一个单位处理：了；例如返回一个HTTP装太信息“

/// 定义一个Tuple

let success = (200, "HTTP OK")

let fileNotFound = (404, "File not found")

/// 还可以指定一个名字
let me = (name: "wxb", no: 11, email: "laoyou_wxb@163.com")


/// 访问Tuple中的数据成员

//1 下标
success.0
success.1

//2 指定了名字
me.email
me.name
me.no

/// Tuple Decomposition （分解）

//我们在定义Tuple的时候，还可以把一个Tuple的值，一一对应的拆分到不同的变量上，这叫做Tuple Decomposition。

var (successCode, successMessage) = success
successCode
successMessage

/// 需要说明的是 这里使用success 的值构建了一个新的Tuple 不会影响到原来的值。

successCode = 201
success
/// 可以用下划线忽略不需要的成员
let (_, errorMessage) = fileNotFound
print(errorMessage)



/// Tuple type
/// 每个Tuple的类型， 都是由所有的成员一起决定的。
/// 对于一开始我们定义的success和me，它们的类型就分别是：(Int, String)和(String, Int, String)

/// 当我们需要用type annotation定义一个Tuple的时候，我们可以这样写
var redirect: (Int, String) = (302, "not ok")


/// 元祖的比较 Tuple comparison

/// 当进行Tuple记性比较的时候，需要遵循下面的规则。
/// 1 只有两个元素个数相同的Tuple之间，才能进行比较。
/// 2 其次是从前到后依次进行 当相同位置的两个元素相等，则比较下一个位置，并根据第一个不相等的位置的大小来决定Tuple变量的关系
///    3 所有位置都想等 即相等
   /// 4 我门最多对6个元素的Tuple进行比较

let tuple11 = (1, 1)
let tuple12 = (1, "2")

//tuple11 < tuple12 /// 不能比较两个类型不同的tuple
