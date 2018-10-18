import UIKit

var str = "理解Array和NSArray的差异"

// 按值语义实现的Array
//在Swift中，Array是按照值语义实现的，当我们复制一个Array对象时，会拷贝整个Array的内容

var a = [1, 2, 3] // [1, 2, 3]
let copyA = a     // [1, 2, 3]

a.append(4)
// a  [1, 2, 3, 4]
// copyA [1, 2, 3]
// copyA.append(4)   // Compile error

/// 1 Swift数组是否可以被修改完全是通过var和let关键字来决定的，Array类型自身并不解决它是否可以被修改的问题；

/// 2 即如果你仅仅复制了Array而不对它修改时，真正的复制是不会发生的，两个数组仍旧引用同一个内存地址。只有当你修改了其中一个Array的内容时，才会真正让两个Array对象分开。为了看到这个过程，我们先来实现一个方法，把保存Array内容的地址变成一个字符串

func getBufferAddress<T>(of array: [T]) -> String {
    return array.withUnsafeBufferPointer({ buffer  in
        return String(describing: buffer.baseAddress)
    })
}

/// 其中，withUnsafeBufferPointer是Array的一个方法，它可以把保存Array内容的地址，传递给它的closure参数。在我们的例子里，这个closure只是把Array的地址，变成了一个String对象。

getBufferAddress(of: a)
getBufferAddress(of: copyA)

a.append(4)

getBufferAddress(of: a)
getBufferAddress(of: copyA)
