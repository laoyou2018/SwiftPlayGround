import UIKit

var str = "使用高级样式匹配方式"

//使用where约束条件

for i in 1...10 where i % 2 == 0 {
    print(i)
}

//我们也可以把where用在更复杂的value binding语句里。例如，假设我们定义下面这样的enum表示手机电量
enum Power {
    case fullyCharged
    case normal(percentage: Double)
    case outOfPower
}

let battery = Power.normal(percentage: 0.1)
//这样，我们就可以在绑定.normal associated value的同时，使用where进一步约束它的关联值了
switch battery {
case .normal(let percentage) where percentage <= 0.1:
    print("Almost out of power")
case .normal(let percentage) where percentage >= 0.8:
    print("Almost fully charged")
default:
    print("Normal battery status")
}


//使用逗号串联条件
//在之前我们提到过，switch中的多个case默认是不向下贯通的，因此，我们不能像C语言一样，通过罗列多个case来实现对多个条件统一处理的效果
//switch halfPower {
//// !!! CANNOT fall through multiple cases !!!
//case .fullyCharged:
//case .outOfPower:
//    print("Fully charged or out of power")
//    // ...
//}

//要实现这样的效果，我们只能在一条case里，用逗号分隔多个情况

//switch halfPower {
//// ...
//case .fullyCharged, .outOfPower
//    print("Fully charged or out of power")
//    // ...
//}

//逗号除了用在switch...case...中表示逻辑或的概念，也可以用在if中表示逻辑与的概念，例如为了处理之前电量低的情况，我们还可以用if这样来实现
if case .normal(let percentage) = battery,
    case 0...0.1 = percentage {
    print("Almost out of power")
}

//在上面的代码里，第一个if case使用value binding读取了battery中.normal的associated value。接下来，第二个case进一步约束了第一个case中关联到的值小于10%的情况

//因此，当我们需要对多个条件递进执行判断的时候，不要写下面这样的if嵌套

//if A {
//    if B {
//        if C {
//
//        }
//    }
//}
//你完全可以使用逗号把这些条件逐步写在一个if里
//if A, B, C {
//
//}
//此时，Swift就会执行if A, then B, then C这样的语义了。特别是，当ABC之间还有计算关联的时候，这样就会显得额外方便

//使用tuple简化多个条件的比较
let username = "11@boxue.io"
let password = 11111111
if username == "11@boxue.io" && password == 11111111 {
    print("correct")
}

if case ("11@boxue.io", 11111111) = (username, password) {
    print("correct")
}
//这样，当同时要比较的元素比较多时，这种写法用起来就方便很多
