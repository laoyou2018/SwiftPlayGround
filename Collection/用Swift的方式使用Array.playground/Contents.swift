import UIKit

var str = "用Swift的方式使用Array"

/*
    绝大多数时候，其实你不需要[]
    不喜欢下标操作符的理由是，对于array[index]这样的访问，甚至都没有使用optional来保护越界的情况
 */

let a = [1, 2, 3]
type(of: a[1]) // Int.type

/// 访问数组中的每一个元素
a.forEach { print($0) }
/// or
for value in a {
    print(value)
}

/// 获取元素以及索引值
for (index, value) in a.enumerated() {
    print("\(index) : \(value)")
}

/// 查找元素等一1的值的位置
a.index { $0 == 1 }
print(a.index { $0 == 1 })


/// 帅选数组中某些元素
a.filter { $0 % 2 == 0 }
print(a.filter { $0 % 2 == 0 })


/// 一些安全周到的方法
a.first
a.last
type(of: a.first)

//removeLast，你需要自行确保数组中有元素，否则会引发运行时错误；
//popLast，如果数组为空，会返回nil；
