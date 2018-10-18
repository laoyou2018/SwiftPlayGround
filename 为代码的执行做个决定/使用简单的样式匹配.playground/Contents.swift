import UIKit

var str = "使用简单的样式匹配"

//// 用在分支和循环控制语句中的基本样式匹配方式

//匹配值的方式
let origin = (x: 0, y: 0)

/// 原始的匹配方法
let pt1 = (x: 0, y: 0)

if pt1.x == origin.x && pt1.y == origin.y {
    print("@Origin")
}

// / 还可以这样
if case (0, 0) = pt1 {
    print("@Origin")
}
/// 我们可以用case 匹配的值 = 要检查的对象的方式，对要检查的对象进行判断。在我们的例子里，判断的就是pt1是否等于原点

//// 除了用在if中匹配值，我们当然也可以在switch的case分支里，匹配特定形式的值
switch pt1 {
case (0, 0):
    print("@origin")
case (_, 0):
    print("on x axis")
case (0, _):
    print("on y axis")
case (-1...1, -1...1):
    print("inside 2x2 square")
default:
    break
}
/// 在上面这个例子里，除了用case (0, 0)表示匹配原点值之外，还可以用(_, 0)和(0, _)表示忽略掉_的部分，仅对tuple中某一部分的值进行匹配，或者，在tuple的每一个成员位置，使用range operator匹配值的某个范围

//除了把case用于条件分支语句，我们还可以用于循环语句，用于进一步控制循环条件
let array1 = [1, 1, 2, 2, 2]

for case 2 in array1 {
    print("found two") // Three times
}
/// 在上面这个例子里，当遇到数组中值为2的元素时，我们向控制台打印了一行话，因此，print一共会打印3次



/*
    把匹配的内容绑定到变量
 */
//除了在case中使用各种形式的具体值之外，我们还可以把匹配到的内容直接绑定到变量上，这样我们就可以在相应的处理代码中直接使用它们
switch pt1 {
case (let x, 0):
    print("(\(x), 0) is on x axis")
case (0, let y):
    print("(0, \(y)) is on y axis")
default:
    break
}
//在上面这个例子里，我们把之前_的部分换成了let x和let y，这样，同样是匹配在坐标轴上的点，这次，我们就可以在对应的case中，直接访问匹配到的值了。我们管这样的形式，叫做value binding


//除了直接绑定变量自身的值之外，我们还可以用类似的形式绑定enum中的关联值。例如，我们先定义一个表示方向的enum
enum Direction {
    case north, south, east, west(abbr: String)
}

let west = Direction.west(abbr: "W")

//为了演示，我们给.west添加个了一个associated value，表示方向的缩写。然后，我们既可以像这样来判断enum值自身
if case .west = west {
    print(west) // west("W")
}
//此时，print打印出来的值，就直接是字符“W”了。当然，case这样的用法，在switch的分支中，也是完全可以的



//自动提取optional的值
//除了绑定enum的associated value之外，我们还可以使用case来自动提取optional类型的非空值
let skills: [String?] =
    ["Swift", nil, "PHP", "JavaScirpt", nil]

for case let skill? in skills {
    print(skill) // Swift PHP JavaScript
}

//在我们的例子里，skills包含了5个元素，其中两个是nil，当我们用case let skill?这样的形式来绑定optional值的时候，Swift就会自动提取每一个非nil的元素，因此，print会输出“Swift PHP JavaScript”


//自动绑定类型转换的结果
//最后一类基本的样式匹配规则是自动绑定类型转换的结果。首先，我们创建一个[Any]
let someValues: [Any] = [1, 1.0, "One"]
//当我们遍历someValues，并且要根据不同类型的数组元素分别做一些操作的时候，可以这样


for value in someValues {
    switch value {
    case let v as Int:
        print("Integer \(v)")
    case let v as Double:
        print("Double \(v)")
    case let v as String:
        print("String \(v)")
    default:
        print("Invalid value")
    }
}
// Integer 1
// Double 1.0
// String One
//在上面的例子中，我们使用了case let Variable as Type的方式，把类型转换成功的结果，绑定在了变量V上。这样，我们就可以在对应的case里，访问到转换成功的值了
//如果你仅仅想判断类型，而不需要知道具体内容的话，还可以使用更简单的is操作符
for value in someValues {
    switch value {
    case is Int:
        print("Integer")
        // omit for simplicity...
    default:
        break
    }
}
//这样，当数组元素类型为Int的时候，我们就会向控制台打印“Integer”。
