import UIKit

var str = "和Array相关的基础知识"

/// 如何创建一个Array
var array1: Array<Int> = Array<Int>()
var array2: [Int] = []
var array3 = array2

/// 同时指定初始值的方法
var threeInts = [Int](repeating: 3, count: 3)

var sixInts = threeInts + threeInts

var fiveInts = [1, 2, 3, 4, 5]


/// 两个常用的Array属性

// 获取数组中元素的个数
array1.count

fiveInts.count

// 表示数组是否为空
if array2.isEmpty {
    print("array2 is empty")
}

/// 访问Array中的元素

// 不被推荐的方式
fiveInts[2]
fiveInts[3]
//fiveInts[5] // 需要自己确保索引的安全性

/// 使用range operator访问一个数组的范围。 得到的并不是array  而是一个ArraySlice
fiveInts[0...2]
fiveInts[0..<2]
//fiveInts[0...6] // 需要自己保证安全性

//ArraySlice 转成 Array
Array(fiveInts[0...2])


/// 便利数组

// 1 for 循环
for value in fiveInts {
    print(value)
}
// 2如果我们想在遍历的时候，同时获得数组的索引和值，可以使用数组对象的enumerated()方法，它会返回一个Sequence对象，包含了每个成员的索引和值
/// Sequence是一个迭代协议 可以使用 for in
for (index, value) in fiveInts.enumerated() {
    print("\(index): \(value)")
}

/// 借助closure，我们还可以使用Array对象的forEach方法
fiveInts.forEach{ print($0) }

/// 添加和删除元素
array1.append(1)
array1 += [2, 3, 4]

/// 在中间位置添加元素
array1.insert(4, at: array1.endIndex) // 超出范围会引发运行时错误

// 要删除array的元素
array1.remove(at: 4) // 同样必须保证合法范围
array1.removeLast()
array1.removeFirst()
