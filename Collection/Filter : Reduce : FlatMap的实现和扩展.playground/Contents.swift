import UIKit

var str = "Filter / Reduce / FlatMap的实现和扩展"

/// filter和与filter类似的语义

/// 我们提到过filter的用法，用于在Array中，过滤满足特定条件的元素。而这个条件，就是通过filter的closure参数来确定的
var fibonacci = [0, 1, 1, 2, 3, 5]

let aa = fibonacci.filter { $0 % 2 == 0 }
print(aa)

//按照上一节中实现map的思路，我们可以自己来实现一个filter
extension Array {
    func myFilter(predicate: (Element) -> Bool ) -> [Element] {
        var tmp: [Element] = []
        for value in self where predicate(value) {
            tmp.append(value)
        }
        return tmp
    }
}

fibonacci.myFilter { $0 % 2 == 0 } // [0, 2]


/*
    剔除掉数组中满足条件的元素
 */

extension Array {
    func reject(_ predicate: (Element) -> Bool) -> [Element] {
        return filter { !predicate($0) }
    }
}
let aaa = fibonacci.reject { $0 % 2 == 0 }
print(aaa)


/*
    另一个基于filter语义的常用操作是判断数组中是否存在满足条件的元素
 */
let flag = fibonacci.filter { $0 % 2 == 0 }.count > 0 // true
flag

/// 这样做并不理想 标准库提供了
fibonacci.contains { $0 % 2 == 0 } // true
// contains的一个好处就是只要遇到满足条件的元素，函数的执行就终止了

/*
    contains 是 是否有满足条件的
    如果的取反 n没有不满族条件的元素，也就是全部元素都满足了。
 */
extension Array {
    func allMatch(_ predicate: (Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
}

let evens = [2, 4, 6, 8]
evens.allMatch { $0 % 2 == 0 } // true

/*
    reduce和与reduce相关的语义： 除了用一个数组生成一个新的数组，有时，我们会希望把一个数组变成某种形式的值
 */
/// 1 求和
fibonacci.reduce(0, +) // 12

extension Array {
    func myReduce<T>(_ initial: T, _ next: (T, Element) -> T) -> T {
        var tmp = initial
        
        for value in self {
            tmp = next(tmp, value)
        }
        
        return tmp
    }
}
/// 除了求和之外，我们还可以把fibonacci reduce成一个字符串
let str1 = fibonacci.myReduce("") { str, num in
    return str + "\(num) "
}
str1
// / 仅仅用作理解reduce的例子
extension Array {
    func myMap2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([], { $0 + [transform($1)] })
    }
    
    func myFilter2(_ predicate: (Element) -> Bool) -> [Element] {
        return reduce([], { predicate($1) ? $0 + [$1] : $0 })
    }
}

// [0, 1, 1, 4, 9, 25]
fibonacci.myMap2 { $0 * $0 }
// [0, 2]
fibonacci.myFilter2 { $0 % 2 == 0 }


/*
    flatMap
    简单来说，如果你用在map中的closure参数不返回一个数组元素，而是也返回一个数组，这样，你就会得到一个数组的数组，但如果你只需要一个一维数组，flatMap就可以派上用场了，而这，也就是flat的含义
*/

let animals = ["🐱", "🐶", "🐰", "🐼"]
let ids = [1, 2, 3, 4]

var zz = animals.map { animal in
    return ids.map { id in (animal, id) }
}
print(zz)


var z = animals.flatMap { animal in
    return ids.map { id in (animal, id) }
}
print(z)
/// flatMap的实现很简单，只要在map内部的for循环里，不断把closure参数生成的数组的内容，添加到要返回的结果里就好了
extension Array {
    func myFlatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var tmp: [T] = []
        
        for value in self {
            tmp.append(contentsOf: transform(value))
        }
        
        return tmp
    }
}
