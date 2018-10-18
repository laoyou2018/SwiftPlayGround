import UIKit

var str = "通过closure参数化对数组元素的变形操作"

/// Swift有一套自己的“现代化”手段。简单来说，就是用closure来参数化对数组的操作行为。这听着有点儿抽象，我们从一个最简单的例子开始。

/// 从循环到map

/// 一个最朴素的做法是for循环
var fibonacci = [0, 1, 1, 2, 3, 5]
var squares = [Int]()

for value in fibonacci {
    squares.append(value * value)
}
print(squares)

/// 当我们要定义一个常量squares的时候，上面的代码就完全无法胜任了。先来看解决方案
let constSquares = fibonacci.map { $0 * $0 }
print(constSquares)

/// map 的实现
/*
    不了解Element也没关系，把它理解为Array中元素类型的替代符就好了 在后面我们讲到Sequence类型的时候，会专门提到它
 */
extension Array {
    func myMap<T>(transform: (Element) -> T) -> [T] {
        var tmp: [T] = []
        tmp.reserveCapacity(count) /// 分配合适的空间大小 给新数组预留了空间之外
        
        for value in self {
            tmp.append(transform(value))
        }
        return tmp
    }
}

let constSquares1 = fibonacci.myMap { $0 * $0 }
print(constSquares1)

/*
    参数化数组元素的执行动作
 */
//仔细观察myMap的实现，就会发现它最大的意义，就是保留了遍历Array的过程，而把要执行的动作留给了myMap的调用者通过参数去定制。而这，就是我们一开始提到的用closure来参数化对数组的操作行为的含义

/// 有了这种思路之后，我们就可以把各种常用的带有遍历行为的操作，定制成多种不同的遍历“套路”，而把对数组中每一个元素的处理动作留给函数的调用者。但是别急，在开始自动动手造轮子之前，Swift library已经为我们准备了一些，

/// 找到最大值和最小值
fibonacci.min()
fibonacci.max()
// 使用min和max很安全，因为当数组为空时，这两个方法将返回nil

/// 过滤出满足特定条件的元素
let aa = fibonacci.filter { $0 % 2 == 0 }
print(aa)

/// 比较数组相等或以特定元素开始。对这类操作，我们需要提供两个内容，一个是要比较的数组，另一个则是比较的规则
fibonacci.elementsEqual([0, 1, 1], by: { $0 == $1 })
fibonacci.starts(with: [0, 1, 1], by: { $0 == $1 })

/// 最原始的for循环的替代品
fibonacci.forEach { print($0) }

/// 要注意它和map的一个重要区别：forEach并不处理closure参数的返回值。因此它只适合用来对数组中的元素进行一些操作，而不能用来产生返回结果

/*
    对数组进行排序，这时，我们需要通过参数指定的是排序规则
 */
fibonacci.sort()
/// 降序
fibonacci.sort(by: >)


let pivot = fibonacci.partition(by: { $0 < 1 })
fibonacci[0 ..< pivot] // [5, 1，1，2, 3]
fibonacci[pivot ..< fibonacci.endIndex] // [0]
// partition(by:)则会先对传递给它的数组进行重排，然后根据指定的条件在重排的结果中返回一个分界点位置。这个分界点分开的两部分中，前半部分的元素都不满足指定条件；后半部分都满足指定条件。而后，我们就可以使用range operator来访问这两个区间形成的Array对象。大家可以根据例子中注释的结果，来理解partition的用法


/// 是把数组的所有内容，“合并”成某种形式的值 对这类操作，我们需要指定的，是合并前的初始值，以及“合并”的规则
fibonacci.reduce(0, +)


/*
    区分修改外部变量和保存内部状态
    当我们使用上面提到的这些带有closure参数的Array方法时，一个不好的做法就是通过closure去修改外部变量，并依赖这种副作用产生的结果
 */
var sum = 0
let constSquares2 = fibonacci.map { (fib: Int) -> Int in
    sum += fib
    return fib * fib
}
sum
/// 在这个例子里，map的执行产生了一个副作用，就是对fibonacci中所有的元素求和。这不是一个好的方法，我们应该避免这样。你应该单独使用reduce来完成这个操作，或者如果一定要在closure参数里修改外部变量，哪怕用forEach也是比map更好的方案

/// 但是，在函数实现内部，专门用一个外部变量来保存closure参数的执行状态，则是一个常用的实现技法。例如，我们要创建一个新的数组，其中每个值，都是数组当前位置和之前所有元素的和

extension Array {
    func accumulate<T>(_ initial: T,
                       _ nextSum: (T, Element) -> T) -> [T] {
        var sum = initial
        
        return map { next in
            sum = nextSum(sum, next)
            return sum
        }
    }
}
fibonacci.accumulate(0, +)
