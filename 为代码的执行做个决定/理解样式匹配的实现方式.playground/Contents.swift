import UIKit

var str = "理解样式匹配的实现方式"

//在我们上一节的例子中，留了一个问题。为什么case 0...0.1 = percentage中，range operator必须写在左边呢？实际上，这和样式匹配的实现方式有关。具体来说，分为下面两种情况：

//首先，当要匹配的变量和样式的类型相同，并且对应的类型实现了Equatable protocol时，就直接使用对应类型的==操作符进行匹配。例如我们之前比较用户名和密码的例子：

let username = "11@boxue.io"
let password = 11111111

if case ("11@boxue.io", 11111111) = (username, password) {
    print("correct")
}
//这里，就直接使用了Tuple类型的比较操作符

//其次，如果样式和要匹配的变量类型不同，或对应类型没有实现Equaltable protocol时，Swift会使用~=操作符进行比较。当这个操作符返回true时，就认为条件匹配，否则就认为不匹配。因此，为了判断某个数值是否在某个范围里，Swift标准库中实现了Range ~= Value这种形式的比较，但是，却没有实现Value ~= Range这样的版本。

//因此，当我们写成case percentage = 0...0.1时，编译器就会因为找不到对应的操作符而报错了。不过，由于这个操作符是可以自定义的，因此，我们可以通过重载它，来实现上面的功能
func ~=<T>(value: T, pattern: ClosedRange<T>) -> Bool {
    // 2
    return pattern.contains(value)
}
//为了能匹配不同的类型，我们把~=定义为了一个泛型函数。它的第一个参数表示~=的左操作数，按照我们的例子，应该是一个值；第二个参数表示~=的右操作数，它是一个ClosedRange<T>。在它的实现里，我们只要调用ClosedRange的contains方法，就可以实现“是否包含某个值”这样的语义了。

//而当我们重载了这个~=方法之后，之前发生编译错误的语句就可以正常工作了。我们也可以通过类似的方法，为自定义类型添加各种样式匹配规则。
